import com.aliyun.odps.mapred.JobContext;
import com.antfin.aikg.kgfabric.adaptor.geaflow.benchmark.vc.CycleDetection3HopsAlgorithm;
import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.rocksdb.RocksDBVertexValue;
import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.rocksdb.RocksdbEdgeValueWrapper;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.StateConfigBuilder;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.odps.LoadRange;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.odps.ODPSInputConfig;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.odps.OdpsGraphFeature;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.odps.OdpsSubGraphSource;
import com.antfin.arc.arch.api.env.Env;
import com.antfin.arc.arch.api.job.mode.ISyncJob;
import com.antfin.arc.arch.api.pdata.set.PSetSource;
import com.antfin.arc.arch.message.graph.Edge;
import com.antfin.arc.arch.message.graph.Vertex;
import com.antfin.arc.cluster.context.ArchEnvContext;
import com.antfin.arch.pdata.impl.dataset.DataSet;
import com.antfin.arch.pdata.impl.graph.Graph;

import java.util.List;

public class ODPSBackendRunner {

    private static ODPSInputConfig getOdpsConfig(){
        // ...
    }

    private static Graph<String, RocksDBVertexValue, RocksdbEdgeValueWrapper> getOdpsSource(JobContext context, String partition, int parallelism){
        // init odps config
        ODPSInputConfig odpsEdgeInputConfig = getOdpsConfig();
        ODPSInputConfig odpsVertexInputConfig = getOdpsConfig();
        odpsVertexInputConfig.setEdgeTable(odpsVertexInputConfig.getVertexTable());
        LoadRange edgeLoadRange = new LoadRange();
        edgeLoadRange.setPartitionDesc(partition);
        LoadRange vertexLoadRange = new LoadRange();
        vertexLoadRange.setPartitionDesc(partition);

        // stage1# graph partition: data shuffle
        OdpsSubGraphSource<List<Vertex<String, RocksDBVertexValue>>> vertexSubGraphSource = new OdpsSubGraphSource<>(odpsVertexInputConfig, vertexLoadRange, true);
        vertexSubGraphSource.setGraphFeatureUdf(new OdpsGraphFeature());
        OdpsSubGraphSource edgeVertexSubGraphSource = new OdpsSubGraphSource(odpsEdgeInputConfig, edgeLoadRange, false);
        edgeVertexSubGraphSource.setGraphFeatureUdf(new OdpsGraphFeature());
        DataSet<Vertex<String, RocksDBVertexValue>> vertexDataSet = (DataSet) PSetSource.from(context, vertexSubGraphSource).withParallelism(parallelism);
        DataSet<Edge<String, RocksdbEdgeValueWrapper>> edgeDataSet = (DataSet) PSetSource.from(context, edgeVertexSubGraphSource).withParallelism(parallelism);

        return new Graph<>(vertexDataSet, edgeDataSet);
    }

    public static void main(String[] args) {
        ArchEnvContext context = (ArchEnvContext) Env.buildEnv(args);
        int parallelism = 8;

        context.withResource(parallelism);
        context.setRunningMode(ArchEnvContext.RunningMode.default_mode);

        StateConfigBuilder.newRocksDB()
                .withFsUri(Options.FS_URI)
                .withNamespace(Options.NAMESPACE)
                .withVertexType(Options.VERTEX_TYPE)
                .withEdgeType(Options.RELATION_TYPE)
                .commit(context);

        // stage1# graph partition: data format transform to rocksdb while loading graph state
        context.submitJob((ISyncJob<Object, Long>) ((jobContext, input) -> {
            Graph<String, RocksDBVertexValue, RocksdbEdgeValueWrapper> graph = getOdpsSource(jobContext,parallelism);
            // stage2#iteration
            graph.runVCIterator(new CycleDetection3HopsAlgorithm(), parallelism)
                    .getVertexDataSet()
                    .get();
        }));
    }

}
