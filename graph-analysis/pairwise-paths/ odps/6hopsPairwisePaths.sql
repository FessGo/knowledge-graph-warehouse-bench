INSERT OVERWRITE TABLE $OutputTable
SELECT F.id, G.id1, G.id2, G.id3, G.type, G.phonenum, G.email, G.freqlogintype, G.accountlevel
from ldbc_fb_entity_account_table F
INNER JOIN 
(SELECT C.id as id1, D.id1 as id2, D.id2 as id3, D.type, D.phonenum, D.email, D.freqlogintype, D.accountlevel
from ldbc_fb_entity_account_table C
INNER JOIN 
(SELECT A.id as id1, B.id as id2, B.type, B.phonenum, B.email, B.freqlogintype, B.accountlevel
from ldbc_fb_entity_account_table A
INNER JOIN  
ldbc_fb_entity_account_table B 
on A.isCandidateNode="true" and A.id != B.id and A.type=B.type AND A.freqlogintype=B.freqlogintype AND  A.email=B.email) D
ON C.id != D.id1 AND C.id != D.id2 and C.type=D.type AND C.freqlogintype=D.freqlogintype and C.accountlevel=D.accountlevel) G
on F.isCandidateNode="true" AND F.id != G.id1 AND F.id != G.id2 AND F.id != G.id3 and F.type=G.type and F.accountlevel=G.accountlevel AND F.email=G.email;
