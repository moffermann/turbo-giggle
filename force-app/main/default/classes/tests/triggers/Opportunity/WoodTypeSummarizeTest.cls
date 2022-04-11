@IsTest
private class WoodTypeSummarizeTest {

	@TestSetup
	static void init() {
		Account account = new Account(Name = 'ACME CO');
		insert account;
		Opportunity opportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 1', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 1000, Wood_Type__c = 'Standard');
		insert opportunity;
	}

	@IsTest
	static void baseStandardSummarizeTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		Test.startTest();
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(1000, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}


	@IsTest
	static void twoStandardSummarizeTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		opportunity.StageName = 'Closed Won';
		update opportunity;
		opportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 500, Wood_Type__c = 'Standard');
		insert opportunity;
		Test.startTest();
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(1500, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}


	@IsTest
	static void deleteSummarizedStandardOpportunityTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		opportunity.StageName = 'Closed Won';
		update opportunity;
		opportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 500, Wood_Type__c = 'Standard');
		insert opportunity;
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.startTest();
		delete opportunity;	// Deleting opportunity already summarized
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(1000, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}


		// ---- Testing Recycled field -----

	@IsTest
	static void baseRecycledSummarizeTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		opportunity.Wood_Type__c = 'Recycled';
		update opportunity;
		Test.startTest();
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(1000, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}


	@IsTest
	static void twoRecycledSummarizeTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		opportunity.Wood_Type__c = 'Recycled';
		opportunity.StageName = 'Closed Won';
		update opportunity;
		opportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 500, Wood_Type__c = 'Recycled');
		insert opportunity;
		Test.startTest();
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(1500, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}

	@IsTest
	static void deleteRecycledOpportunitySummarizedTest() {
		Account account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not initialized!');
		System.assertEquals(0, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not initialized!');
		Opportunity opportunity = [SELECT Id FROM Opportunity WHERE Name = 'Test Opp 1' LIMIT 1];
		opportunity.Wood_Type__c = 'Recycled';
		opportunity.StageName = 'Closed Won';
		update opportunity;
		opportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 500, Wood_Type__c = 'Recycled');
		insert opportunity;
		opportunity.StageName = 'Closed Won';
		update opportunity;
		Test.startTest();
		delete opportunity;	// Deleting opportunity already summarized
		Test.stopTest();
		account = [SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account LIMIT 1];
		System.assertEquals(0, account.Total_Sales_Standard_Wood__c, 'Total_Sales_Standard_Wood__c was not summarized!');
		System.assertEquals(1000, account.Total_Sales_Recycled_Wood__c, 'Total_Sales_Recycled_Wood__c was not summarized!');
	}
}
