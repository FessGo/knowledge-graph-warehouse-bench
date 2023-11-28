set -e
KGFABRIC_BUILDER_PATH="kgfabric-local-builder.jar"
DPATH="twitter2010"
SCHEMA="twitter2010.schema"

NAMESPACE="twitter2010"
java -jar ${KGFABRIC_BUILDER_PATH} import
--schema="${SCHEMA}" \
--nodes=User="$DPATH/node.csv" \
--relationships=CONNECT="$DPATH/twitter-2010.csv" \
"${NAMESPACE}"
