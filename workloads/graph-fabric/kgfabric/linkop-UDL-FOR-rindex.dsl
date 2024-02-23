CREATE LINK OPERATOR mockLink {
	main_class:"com.alipay.kgfabric.operators.mockLinker",
	jar:"kgfabric-operator-mocklinker-1.0.0.jar"
}

CREATE FUSE OPERATOR fuseAccount [type=RULE, params=e1,e2,f] {
	($f)-[transfer]->($f) = union(($e1)-[transfer1]->($e1), ($e2)-[transfer2]->($e2))
}

--param: number of linkpairs. We set it to 2000/20000/100000/200000/400000 for the paper experiments

CREATE GRAPH VIEW fabricview [rindex=TRUE] {
	(source1:Account1)-[transfer1]->(source1:Account1)
	(source2:Account2)-[transfer2]->(source2:Account2)
} WITH OPERATOR {
	mockLink(source1, source2, FusedAccount, 2000)
	fuseAccounts(source1, source2, FusedAccount)
}