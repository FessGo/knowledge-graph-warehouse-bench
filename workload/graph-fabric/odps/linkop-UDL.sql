set -e

ODPSCMD="/opt/taobao/tbdpapp/odpswrapper/odpswrapper.py"

for LINKTABLE in "linktable_pair2k" "linktable_pair20k" "linktable_pair100k" "linktable_pair200k" "linktable_pair400k"
do
	# use bi_udf:bi_group_concat_order to mock simple fuseop 
	
	$ODPSCMD -e "
	set odps.sql.reducer.instances=8;
	set odps.sql.joiner.instances=8;
	INSERT OVERWRITE TABLE fabric_results_table 
	(select startid, bi_udf:bi_group_concat_order(endid, nums, ','), count(*) from
	(select startid, endid, row_number() OVER (PARTITION by startid ORDER BY endid, createtime) AS nums from
	(select B.id2 as startid, A.endid as endid, A.createtime as createtime FROM ldbc_fb_sf10_relation_transfer_p1 A
	INNER JOIN ${LINKTABLE} B
	ON A.startid=B.id1
	UNION 
	select A.startid as startid, A.endid as endid, A.createtime as createtime FROM ldbc_fb_sf10_relation_transfer_p2 A
	INNER JOIN ${LINKTABLE} B
	ON A.startid=B.id2))  GROUP BY startid)
	UNION 
	(select endid, bi_udf:bi_group_concat_order(startid, nums, ','), count(*) from
	(select startid, endid, row_number() OVER (PARTITION by endid ORDER BY startid, createtime) AS nums from
	(select A.startid as startid, B.id2 as endid, A.createtime as createtime FROM ldbc_fb_sf10_relation_transfer_p1 A
	INNER JOIN ${LINKTABLE} B
	ON A.endid=B.id1
	UNION 
	select A.startid as startid, A.endid as endid, A.createtime as createtime FROM ldbc_fb_sf10_relation_transfer_p2 A
	INNER JOIN ${LINKTABLE} B
	ON A.endid=B.id2)) GROUP BY endid);
	"
done
