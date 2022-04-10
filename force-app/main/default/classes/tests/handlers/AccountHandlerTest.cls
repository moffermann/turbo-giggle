@IsTest
private class AccountHandlerTest {

	@TestSetup
	static void init() {
		Account account = new Account(Name = 'ACME CO');
		insert account;
		Opportunity oldOpportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 1', StageName = 'Prospecting', CloseDate = Date.today(), Amount = 1000, Wood_Type__c = 'Standard');
		insert oldOpportunity;
		Opportunity newOpportunity = new Opportunity(AccountId = account.Id, Name = 'Test Opp 2', StageName = 'Closed Won'	, CloseDate = Date.today(), Amount = 1000, Wood_Type__c = 'Standard');
		insert newOpportunity;
	}

	@IsTest
	static void woodTypeSummarizeTest() {
		//Testing handler layer.
		Boolean isUpdate = true;
		Boolean isDelete = false;
		AccountServiceStub stub = new AccountServiceStub();
		Service.setMock(AccountService.class, stub);
		Opportunity oldOpportunity = [SELECT Id, Wood_Type__c, Amount, StageName, AccountId, IsWon FROM Opportunity WHERE Name = 'Test Opp 1'];
		Opportunity newOpportunity = [SELECT Id, Wood_Type__c, Amount, StageName, AccountId, IsWon FROM Opportunity WHERE Name = 'Test Opp 2'];
		Id opportunityId = oldOpportunity.Id;
		System.assert(newOpportunity.IsWon, 'New opportunity is not won!');
		Opportunity[] oldOpportunities = new Opportunity[] {oldOpportunity};
		Map<Id, Opportunity>  newOpportunityMap = new Map<Id, Opportunity> {opportunityId => newOpportunity};
		Test.startTest();
		AccountHandler.getInstance().woodTypeSummarize(); // only for coverage
		AccountHandler.getInstance().woodTypeSummarize(isUpdate, isDelete, oldOpportunities, newOpportunityMap);
		Test.stopTest();
		Set<Id> accountIds = stub.accountIds;
		System.assertNotEquals(null, accountIds, 'Method woodTypeSummarize was not invoked');
		System.assert(accountIds.contains(newOpportunity.AccountId), 'AccountId was not passed');
	}
}
