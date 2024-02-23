GraphStructure {
    (x:Account)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(y:Account),
    (x)−[p:freqLoginType]−>(Concept.MediumType)<−[p:freqLoginType]-(y),
    (x)−[p:email]−>(STD.Email)<−[p:Email]-(y)
    (y)−[p:accountType]−>(Concept.AccountType)<−[p:accountType]-(z:Account),
    (y)−[p:freqLoginType]−>(Concept.MediumType)<−[p:freqLoginType]-(z),
    (y)−[p:accountLevel]−>(Concept.AccountLevel)<−[p:accountLevel]-(z)
}
Rule {
}
Action {
    get(__path__)
}
