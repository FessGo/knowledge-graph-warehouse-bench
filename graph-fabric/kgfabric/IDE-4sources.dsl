CREATE FUSE OPERATOR fuseAccounts [type=RULE, params=e1,e2,e3,e4,f] {
	($f)-[transfer]->($f) = union(($e1)-[transfer1]->($e1), ($e2)-[transfer2]->($e2), ($e3)-[transfer3]->($e3), ($e4)-[transfer4]->($e4))
}
CREATE GRAPH VIEW fabricview {
	(source1:Account1)-[transfer1]->(source1:Account1)
	(source2:Account2)-[transfer2]->(source2:Account2)
	(source3:Account3)-[transfer3]->(source3:Account3)
	(source4:Account4)-[transfer4]->(source4:Account4)
} WITH OPERATOR [ide=TRUE] {
	fuseAccounts(source1, source2, source3, source4, FusedAccount)
}
