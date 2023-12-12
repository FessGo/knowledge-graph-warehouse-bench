set -e
KGFABRIC_BUILDER_PATH="kgfabric-local-builder.jar"
DPATH="sf1.new"
SCHEMA="ldbcfbx.spg.schema"

NAMESPACE="ldbc-fb-x"
java -jar ${KGFABRIC_BUILDER_PATH} import
--schema="${SCHEMA}" \
--concepts=Concept.BusinessType="$DPATH/businessType.csv" \
--concepts=Concept.AccountType="$DPATH/accountType.csv" \
--concepts=Concept.AccountLevel="$DPATH/accountLevel.csv" \
--concepts=Concept.MediumType="$DPATH/mediumType.csv" \
--concepts=Concept.RiskLevel="$DPATH/riskLevel.csv" \
--concepts=Concept.Country="$DPATH/country.csv" \
--concepts=Concept.City="$DPATH/city.csv" \
--entities=Account="$DPATH/account.csv" \
--entities=Person="$DPATH/person.csv" \
--entities=Medium="$DPATH/medium.csv" \
--entities=Company="$DPATH/company.csv" \
--entities=Loan="$DPATH/loan.csv" \
--relationships=TRANSFER="$DPATH/transfer.csv,$DPATH/loantransfer.csv" \
--relationships=COMPANYAPPLYLOAD="$DPATH/companyApplyLoan.csv" \
--relationships=COMPANYGUARANTEE="$DPATH/companyGuarantee.csv" \
--relationships=COMPANYINVEST="$DPATH/companyInvest.csv" \
--relationships=COMPANYOWMACCOUNT="$DPATH/companyOwnAccount.csv" \
--relationships=DEPOSIT="$DPATH/deposit.csv" \
--relationships=PERSONAPPLYLOAN="$DPATH/personApplyLoan.csv" \
--relationships=PERSONGUARANTEE="$DPATH/personGuarantee.csv" \
--relationships=PERSONINVEST="$DPATH/personInvest.csv" \
--relationships=PERSONOWNACCOUNT="$DPATH/personOwnAccount.csv" \
--relationships=REPAY="$DPATH/repay.csv" \
--relationships=SIGNIN="$DPATH/signIn.csv" \
--relationships=WITHDRAW="$DPATH/withdraw.csv" \
"${NAMESPACE}"
