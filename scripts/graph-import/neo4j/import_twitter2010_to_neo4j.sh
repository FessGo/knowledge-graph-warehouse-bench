#/bin/bash
set -e
IFS=$'\t\n'
NEO4J_PATH=""
DPATH="twitter-2010"

DBNAME="twitter-2010"
rm -rf ../data/transactions/${DBNAME}
rm -rf ../data/databases/${DBNAME}

../bin/neo4j-admin database import full \
--nodes=User="$DPATH/node_header.csv,$DPATH/node.csv" \
--relationships=CONNECT="$DPATH/relation_header.csv,$DPATH/../twitter-2010.csv" \
--trim-strings=false \
"${DBNAME}"
