GraphStructure {
	(x:Account)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(y:Account),
	(x)−[p:freqLoginType]−>(Concept.MediumType)<−[p:freqLoginType]-(y),
	(x)−[p:email]−>(STD.Email)<−[p:Email]-(y),
	(y)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(z:Account),
	(y)−[p:freqLoginType]−>(Concept.MediumType)<−[p:freqLoginType]-(z),
    	(y)−[p:accountLevel]−>(Concept.AccountLevel)<−[p:accountLevel]-(z),
	(y)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(k:Account),
    	(y)−[p:email]−>(STD.Email)<−[p:email]-(k),
    	(y)−[p:accountLevel]−>(Concept.AccountLevel)<−[p:accountLevel]-(k)
}
Rule {
}
Action {
    get(__path__)
}
