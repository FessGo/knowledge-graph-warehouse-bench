INSERT OVERWRITE TABLE $OutputTable
SELECT C.id, D.id1, D.id2, D.type, D.phonenum, D.email, D.freqlogintype, D.accountlevel
from ldbc_fb_entity_account_table C
INNER JOIN 
(SELECT A.id as id1, B.id as id2, B.type, B.phonenum, B.email, B.freqlogintype, B.accountlevel
from ldbc_fb_entity_account_table A
INNER JOIN
ldbc_fb_entity_account_table B 
on A.isCandidateNode="true" and A.id != B.id and A.type=B.type AND  A.email=B.email AND A.freqlogintype=B.freqlogintype) D
ON C.isCandidateNode="true" AND C.id != D.id1 AND C.id != D.id2 and C.type=D.type AND C.freqlogintype=D.freqlogintype AND C.accountlevel=D.accountlevel;
