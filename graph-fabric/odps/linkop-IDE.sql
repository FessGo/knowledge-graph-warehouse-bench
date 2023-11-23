set -e

Fabic2Tables="SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p1 
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p2"

Fabic4Tables="SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p1 
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p2
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p3
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p4"

Fabic6Tables="SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p1 
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p2
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p3
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p4
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p5
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p6"

Fabic8Tables="SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p1 
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p2
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p3
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p4
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p5
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p6
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p7
UNION SELECT  startid, endid, amount FROM  ldbc_fb_sf10_relation_transfer_p8"

ODPSCMD="/opt/taobao/tbdpapp/odpswrapper/odpswrapper.py"

for SourceTables in "Fabic2Tables" "Fabic4Tables" "Fabic6Tables" "Fabic8Tables"
do
	# use bi_udf:bi_group_concat_order to mock simple fuseop 
	
	$ODPSCMD -e "
	set odps.sql.reducer.instances=8;
	set odps.sql.joiner.instances=8;
	INSERT OVERWRITE TABLE fabric_results_table
	(select startid, bi_udf:bi_group_concat_order(endid, nums, ','), count(*) from
	(select startid, endid, row_number() OVER (PARTITION by startid ORDER BY endid, createTime) AS nums
	from ($SourceTables)) GROUP BY startid)
	UNION 
	(select endid, bi_udf:bi_group_concat_order(startid, nums, ','), count(*) from
	(select startid, endid, row_number() OVER (PARTITION by endid ORDER BY startid, createTime) AS nums 
	from ($SourceTables)) GROUP BY endid);
	"
done
