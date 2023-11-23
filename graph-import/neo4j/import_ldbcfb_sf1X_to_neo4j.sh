#/bin/bash
set -e
IFS=$'\t\n'
NEO4J_PATH=""
PP="sf1"
DPATH="$PP.new"
HPATH="header.new"
SDPATH="semantic/$PP"
SCPATH="semantic/concept"
SHPATH="semantic/header"

DBNAME="ldbc-fb-x"
rm -rf ../data/transactions/${DBNAME}
rm -rf ../data/databases/${DBNAME}
rm -rf ../data/transactions/${DBNAME1}
rm -rf ../data/databases/${DBNAME1}

../bin/neo4j-admin database import full \
--nodes=Account="$HPATH/account_header.csv,$DPATH/account.csv" \
--nodes=Person="$HPATH/person_header.csv,$DPATH/person.csv" \
--nodes=Medium="$HPATH/medium_header.csv,$DPATH/medium.csv" \
--nodes=Company="$HPATH/company_header.csv,$DPATH/company.csv" \
--nodes=Loan="$HPATH/loan_header.csv,$DPATH/loan.csv" \
--nodes=AccountType="$SHPATH/accountTypes_header.csv,$SCPATH/accountTypes.csv" \
--nodes=AccountLevel="$SHPATH/accountLevels_header.csv,$SCPATH/accountLevels.csv" \
--nodes=BusinessType="$SHPATH/businessTypes_header.csv,$SCPATH/businessTypes.csv" \
--nodes=City="$SHPATH/city_header.csv,$SCPATH/city.csv" \
--nodes=Country="$SHPATH/country_header.csv,$SCPATH/country.csv" \
--nodes=Email="$SHPATH/email_header.csv,$SCPATH/email.csv" \
--nodes=MediumType="$SHPATH/mediumType_header.csv,$SCPATH/mediumType.csv" \
--nodes=Phone="$SHPATH/phone_header.csv,$SCPATH/phone.csv" \
--nodes=RiskLevel="$SHPATH/riskLevels_header.csv,$SCPATH/riskLevels.csv" \
--nodes=Url="$SHPATH/urls_header.csv,$SCPATH/urls.csv" \
--nodes=LoanUsage="$SHPATH/loanUsages_header.csv,$SCPATH/loanUsages.csv" \
--relationships=ACCOUTTOTYPE="$SHPATH/accountToType_header.csv,$SDPATH/accountToType.csv" \
--relationships=ACCOUTTOEMAIL="$SHPATH/accountToEmail_header.csv,$SDPATH/accountToEmail.csv" \
--relationships=ACCOUTTOLEVEL="$SHPATH/accountToLevel_header.csv,$SDPATH/accountToLevel.csv" \
--relationships=ACCOUTTOLOGINTYPE="$SHPATH/accountToLoginType_header.csv,$SDPATH/accountToLoginType.csv" \
--relationships=ACCOUTTOPHONE="$SHPATH/accountToPhone_header.csv,$SDPATH/accountToPhone.csv" \
--relationships=COMPANYTOBUSINESS="$SHPATH/companyToBusiness_header.csv,$SDPATH/companyToBusiness.csv" \
--relationships=COMPANYTOCITY="$SHPATH/companyToCity_header.csv,$SDPATH/companyToCity.csv" \
--relationships=COMPANYTOCOUNTRY="$SHPATH/companyToCountry_header.csv,$SDPATH/companyToCountry.csv" \
--relationships=COMPANYTOURL="$SHPATH/companyToUrl_header.csv,$SDPATH/companyToUrl.csv" \
--relationships=LOANTOUSAGE="$SHPATH/loanToUsage_header.csv,$SDPATH/loanToUsage.csv" \
--relationships=MEDIUMTORISKLEVEL="$SHPATH/mediumToRiskLevel_header.csv,$SDPATH/mediumToRiskLevel.csv" \
--relationships=MEDIUMTOTYPE="$SHPATH/mediumToType_header.csv,$SDPATH/mediumToType.csv" \
--relationships=PERSONTOCITY="$SHPATH/personToCity_header.csv,$SDPATH/personToCity.csv" \
--relationships=PERSONTOCOUNTRY="$SHPATH/personToCountry_header.csv,$SDPATH/personToCountry.csv" \
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
