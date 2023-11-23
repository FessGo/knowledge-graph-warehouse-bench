INSERT OVERWRITE TABLE $OutputTable
SELECT A.id, B.id, B.type, B.phonenum, B.email, B.freqlogintype, B.accountlevel
from ldbc_fb_entity_account_table A
INNER JOIN  
ldbc_fb_entity_account_table B 
ON A.isCandidateNode="true" and A.isCandidateNode="true"
and A.id != B.id and A.type=B.type AND A.freqlogintype=B.freqlogintype and A.email=B.email;
