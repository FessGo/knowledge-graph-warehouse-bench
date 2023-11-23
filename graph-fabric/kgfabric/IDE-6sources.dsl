CREATE FUSE OPERATOR fuseAccounts [type=RULE, params=e1,e2,e3,e4,e5,e6,f] {
	($f)-[transfer]->($f) = union(($e1)-[transfer1]->($e1), ($e2)-[transfer2]->($e2), ($e3)-[transfer3]->($e3), ($e4)-[transfer4]->($e4), ($e5)-[transfer5]->($e5), ($e6)-[transfer6]->($e6))
}
CREATE GRAPH VIEW fabricview {
	(source1:Account1)-[transfer1]->(source1:Account1)
	(source2:Account2)-[transfer2]->(source2:Account2)
	(source3:Account3)-[transfer3]->(source3:Account3)
	(source4:Account4)-[transfer4]->(source4:Account4)
	(source5:Account5)-[transfer5]->(source5:Account5)
	(source6:Account6)-[transfer6]->(source6:Account6)
} WITH OPERATOR {
	fuseAccounts(source1, source2, source3, source4, source5, source6, FusedAccount)
}
