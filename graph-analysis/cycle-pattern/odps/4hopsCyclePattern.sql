INSERT OVERWRITE TABLE $OutputTable
SELECT  F.startid,F.endid,G.e_id2,G.e_id3,G.e_id4,F.createtime,G.e_ts1,G.e_ts2,G.e_ts3
from $EdgeTable F
INNER JOIN 
(SELECT  C.startid as e_id1,C.endid as e_id2,D.d_id2 as e_id3,D.d_id3 as e_id4,C.createtime as e_ts1, D.d_ts1 as e_ts2, D.d_ts2 as e_ts3
from $EdgeTable C
INNER JOIN  
(select A.startid as d_id1, A.endid as d_id2, B.endid as d_id3, A.createtime as d_ts1, B.createtime as d_ts2
    from $EdgeTable A 
    INNER JOIN  $EdgeTable B 
    on A.endid=B.startid and A.startid != B.endid) D
    ON C.endid = D.d_id1 AND C.startid != D.d_id3) G
    ON F.endid = G.e_id1 and F.startid = G.e_id4;
