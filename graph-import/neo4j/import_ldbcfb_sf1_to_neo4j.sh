#/bin/bash
set -e
IFS=$'\t\n'
NEO4J_PATH=""
DPATH="sf1.new"
HPATH="header.new"

DBNAME="ldbc-fb"
rm -rf ../data/transactions/${DBNAME}
rm -rf ../data/databases/${DBNAME}

../bin/neo4j-admin database import full \
--nodes=Account="$HPATH/account_header.csv,$DPATH/account.csv" \
--nodes=Person="$HPATH/person_header.csv,$DPATH/person.csv" \
--nodes=Medium="$HPATH/medium_header.csv,$DPATH/medium.csv" \
--nodes=Company="$HPATH/company_header.csv,$DPATH/company.csv" \
--nodes=Loan="$HPATH/loan_header.csv,$DPATH/loan.csv" \
--relationships=TRANSFER="$HPATH/transfer_header.csv,$DPATH/transfer.csv,$DPATH/loantransfer.csv" \
--relationships=COMPANYAPPLYLOAD="$HPATH/companyApplyLoan_header.csv,$DPATH/companyApplyLoan.csv" \
--relationships=COMPANYGUARANTEE="$HPATH/companyGuarantee_header.csv,$DPATH/companyGuarantee.csv" \
--relationships=COMPANYINVEST="$HPATH/companyInvest_header.csv,$DPATH/companyInvest.csv" \
--relationships=COMPANYOWMACCOUNT="$HPATH/companyOwnAccount_header.csv,$DPATH/companyOwnAccount.csv" \
--relationships=DEPOSIT="$HPATH/deposit_header.csv,$DPATH/deposit.csv" \
--relationships=PERSONAPPLYLOAN="$HPATH/personApplyLoan_header.csv,$DPATH/personApplyLoan.csv" \
--relationships=PERSONGUARANTEE="$HPATH/personGuarantee_header.csv,$DPATH/personGuarantee.csv" \
--relationships=PERSONINVEST="$HPATH/personInvest_header.csv,$DPATH/personInvest.csv" \
--relationships=PERSONOWNACCOUNT="$HPATH/personOwnAccount_header.csv,$DPATH/personOwnAccount.csv" \
--relationships=REPAY="$HPATH/repay_header.csv,$DPATH/repay.csv" \
--relationships=SIGNIN="$HPATH/signIn_header.csv,$DPATH/signIn.csv" \
--relationships=WITHDRAW="$HPATH/withdraw_header.csv,$DPATH/withdraw.csv" \
--trim-strings=false \
"${DBNAME}"
