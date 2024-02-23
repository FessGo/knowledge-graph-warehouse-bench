INSERT OVERWRITE TABLE $OutputTable
SELECT  H.startid,H.endid,I.f_id2,I.f_id3,I.f_id4,I.f_id5,H.createtime,I.f_ts1,I.f_ts2,I.f_ts3,I.f_ts4
from $EdgeTable H
INNER JOIN 
(SELECT  F.startid as f_id1,F.endid as f_id2,G.e_id2 as f_id3,G.e_id3 as f_id4,G.e_id4 as f_id5,F.createtime as f_ts1,G.e_ts1 as f_ts2,G.e_ts2 as f_ts3,G.e_ts3 as f_ts4
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
    ON F.endid = G.e_id1 and F.startid != G.e_id4) I
    ON H.endid = I.f_id1 and H.startid = I.f_id5;
