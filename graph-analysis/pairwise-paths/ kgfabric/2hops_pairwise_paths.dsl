GraphStructure {
    (x:Account)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(y:Account),
    (x)−[p:freqLoginType]−>(Concept.MediumType)<−[p:freqLoginType]-(y),
    (x)−[p:email]−>(STD.Email)<−[p:Email]-(y)
}
Rule {
}
Action {
    get(__path__)
}
