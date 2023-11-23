CREATE FUSE OPERATOR fuseAccounts [type=RULE, params=e1,e2,f] {
	($f)-[transfer]->($f) = union(($e1)-[transfer1]->($e1), ($e2)-[transfer2]->($e2))
}
CREATE GRAPH VIEW fabricview {
	(source1:Account1)-[transfer1]->(source1:Account1)
	(source2:Account2)-[transfer2]->(source2:Account2)
} WITH OPERATOR {
	fuseAccounts(source1, source2, FusedAccount)
}
