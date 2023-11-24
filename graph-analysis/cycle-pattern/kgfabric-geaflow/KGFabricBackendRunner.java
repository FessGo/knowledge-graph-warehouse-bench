import com.antfin.aikg.kgfabric.adaptor.geaflow.benchmark.vc.CycleDetection3HopsAlgorithm;
import com.antfin.aikg.kgfabric.adaptor.geaflow.benchmark.Options;
import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.EdgeValueWrapper;
import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.GraphKey;
import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.VertexValueWrapper;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.SourceUtil;
import com.antfin.aikg.kgfabric.adaptor.geaflow.util.StateConfigBuilder;
import com.antfin.arc.arch.api.env.Env;
import com.antfin.arc.arch.api.job.mode.ISyncJob;
import com.antfin.arc.cluster.context.ArchEnvContext;
import com.antfin.arch.pdata.impl.graph.Graph;

public class KGFabricBackendRunner {

    public static int parallelism = 8;
    public static void main(String[] args) {
        ArchEnvContext context = (ArchEnvContext) Env.buildEnv();
        context.withResource(parallelism);
        context.setRunningMode(ArchEnvContext.RunningMode.default_mode);

        StateConfigBuilder.newRocksDB()
                .withFsUri(Options.FS_URI)
                .withNamespace(Options.NAMESPACE)
                .withVertexType(Options.VERTEX_TYPE)
                .withEdgeType(Options.RELATION_TYPE)
                .commit(context);

        // no stage1#graph partition
        context.submitJob((ISyncJob<Object, Long>) ((jobContext, input) -> {
            Graph<GraphKey, VertexValueWrapper, EdgeValueWrapper> graph = Graph.buildGraph(jobContext, SourceUtil.getNoShuffleSource(parallelism));
            // stage2#iterations
            return graph.runVCIterator(new CycleDetection3HopsAlgorithm(), parallelism)
                    .getVertexDataSet()
                    .get();
        }));

    }
}
