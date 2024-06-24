UNWIND ids AS startId
MATCH (a:Account) WHERE id(a) = startId
MATCH (a)-[:ACCOUTTOLOGINTYPE|ACCOUTTOLEVEL|ACCOUTTOEMAIL|ACCOUTTOTYPE]->(b),
       (b)<-[:ACCOUTTOLOGINTYPE|ACCOUTTOLEVEL|ACCOUTTOEMAIL|ACCOUTTOTYPE]-(c:Account)
WITH DISTINCT c
RETURN COLLECT(c) AS uniqueNeighbors
