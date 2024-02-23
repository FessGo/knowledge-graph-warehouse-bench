INSERT OVERWRITE TABLE $OutputTable
SELECT C.startid,C.endid,D.id2,D.id3,C.createtime,D.ts1,D.ts2 FROM $EdgeTable C
INNER JOIN  
(select A.startid as id1, A.endid as id2, B.endid as id3, A.createtime as ts1, B.createtime as ts2 FROM $EdgeTable A 
    INNER JOIN $EdgeTable B 
    ON A.endid=B.startid AND A.startid != B.endid) D
    ON C.endid = D.id1 AND C.startid = D.id3;
