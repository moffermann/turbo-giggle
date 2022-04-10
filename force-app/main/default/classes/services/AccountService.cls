public without sharing class AccountService extends Service {

	public static AccountService getInstance() {
		return (AccountService)Service.getInstance(AccountService.class);
	}

	public void woodTypeSummarize(Set<Id> accountIds) {
		AggregateResult[] results = [SELECT SUM(Amount) TotalAmount, AccountId, Wood_Type__c FROM Opportunity WHERE AccountId IN :accountIds AND IsWon = true AND Wood_Type__c IN ('Standard', 'Recycled') GROUP BY AccountId, Wood_Type__c];
		Map<Id, Account> accountMap = new Map<Id, Account>();
		for (AggregateResult result : results) {
			Id accountId = (Id)result.get('AccountId');
			String woodType = (String)result.get('Wood_Type__c');
			Decimal totalAmount = (Decimal)result.get('TotalAmount');

			Account account = accountMap.get(accountId);
			if (account == null) {
				account = new Account(Id = accountId);
				accountMap.put(accountId, account);
			}

			if (woodType == 'Standard')
				account.Total_Sales_Standard_Wood__c = totalAmount;
			else if (woodType == 'Recycled')
				account.Total_Sales_Recycled_Wood__c = totalAmount;
		}
		update accountMap.values();
	}
}
