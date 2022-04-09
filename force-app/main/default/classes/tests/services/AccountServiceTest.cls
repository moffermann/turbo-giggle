@IsTest
private class AccountServiceTest {

	@TestSetup
	static void init() {
		Handler.disable(AccountHandler.class);
		Account account = new Account(Name = 'ACME CO');
		insert account;
		Opportunity opportunity1 = new Opportunity(AccountId = account.Id, Name = 'Test Opp 1', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 1000, Wood_Type__c = 'Standard');
		insert opportunity1;
		Opportunity opportunity2 = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Prospecting', CloseDate = Date.today(), Amount =3500, Wood_Type__c = 'Standard');
		insert opportunity2;
	}

	@IsTest
	static void summarizeTest() {
		Handler.disable(AccountHandler.class);
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity[] opportunities = [SELECT Id, AccountId FROM Opportunity];
		for (Opportunity opportunity : opportunities) {
			opportunity.StageName = 'Closed Won';
		}
		update opportunities;

		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
		Set<Id> accountIds = new Set<Id> {account.Id};
		Test.startTest();
		AccountService.getInstance().woodTypeSummarize(accountIds);
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(4500, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}
}
