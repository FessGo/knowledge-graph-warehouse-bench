import com.antfin.aikg.kgfabric.adaptor.geaflow.structure.GraphKey;
import com.antfin.arc.arch.api.algorithm.graph.IGraphVCPartition;
import com.antfin.arc.arch.api.algorithm.graph.VCAlgorithm;
import com.antfin.arc.arch.api.function.graph.VCFunction;
import com.antfin.arc.arch.message.graph.Edge;
import com.antfin.arc.arch.message.graph.Vertex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

public class CycleDetection3HopsAlgorithm extends VCAlgorithm<GraphKey, String, String, List<GraphKey>> {
    private static Logger LOGGER = LoggerFactory.getLogger(CycleDetection3HopsAlgorithm.class);
    protected CycleDetection3HopsAlgorithm() {
        super(3);
    }

    @Override
    public VCFunction<GraphKey, String, String, List<GraphKey>> getComputeFunction() {
        return new VCFunction<GraphKey, String, String, List<GraphKey>>() {
            private GraphContext<GraphKey, Vertex, Edge, List<GraphKey>> graphContext;

            @Override
            public void init(GraphContext<GraphKey, String, String, List<GraphKey>> graphContext) {
                this.graphContext = graphContext;
            }

            @Override
            public void compute(Vertex vertex, Iterator<List<GraphKey>> messageIterator) {
                GraphKey key = (GraphKey) vertex.getId();
                if (graphContext.getCurrentIterationId() == 1) {
                    List<GraphKey> inIds = graphContext.getInEdges().stream().map(Edge::getTargetId).collect(Collectors.toList());
                    for (GraphKey inId : inIds) {
                        if (inId.compareTo(key) < 0) {
                            List<GraphKey> list = new ArrayList<>();
                            list.add(inId);
                            list.add(key);
                            graphContext.sendMessageToNeighbors(list);
                        }
                    }
                } else if (graphContext.getCurrentIterationId() == 2) {
                    while (messageIterator.hasNext()) {
                        List<GraphKey> msg = messageIterator.next();
                        List<GraphKey> outIds = graphContext.getOutEdges().stream().map(Edge::getTargetId).collect(Collectors.toList());
                        for (GraphKey outId : outIds) {
                            if (outId.equals(msg.get(0))) {
                                StringBuilder path = new StringBuilder();
                                for (GraphKey k : msg) {
                                    path.append(k.getBizId());
                                    path.append(",");
                                }
                                path.append(key.getBizId());
				LOGGER.info("results={}",  path);
                            }
                        }
                    }
                }
            }
        };
    }

    @Override
    public IGraphVCPartition<GraphKey> getGraphPartition() {
        return GraphKey::getWorkerIndex;
    }
}
