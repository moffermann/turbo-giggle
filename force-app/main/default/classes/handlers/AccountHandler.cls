public class AccountHandler extends Handler {

	public static AccountHandler getInstance() {
		return (AccountHandler)Handler.getInstance(AccountHandler.class);
	}

	public void woodTypeSummarize() {
		Opportunity[] oldOpportunities = (Opportunity[])Trigger.old;
		Map<Id, Opportunity> newOpportunityMap = (Map<Id, Opportunity>)Trigger.newMap;
		Boolean isUpdate = Trigger.isUpdate;
		Boolean isDelete = Trigger.isDelete;
		woodTypeSummarize(isUpdate, isDelete, oldOpportunities, newOpportunityMap);
	}

	@TestVisible
	private void woodTypeSummarize(Boolean isUpdate, Boolean isDelete, Opportunity[] oldOpportunities, Map<Id, Opportunity> newOpportunityMap) {
		if (oldOpportunities == null || newOpportunityMap == null)
		return;
		Set<Id> accountIds = new Set<Id>();
		for (Opportunity oldOpportunity : oldOpportunities) {
			Opportunity newOpportunity = isUpdate ? newOpportunityMap.get(oldOpportunity.Id) : null;
			System.assertNotEquals(null, oldOpportunity, 'Old Opportunity never will be null!'); // Only for testing purposes in this test.
			if (newOpportunity != null)
				System.assertEquals(newOpportunity.AccountId, oldOpportunity.AccountId, 'The account never will change (master detail)'); // Only for testing purposes in this exam.
			if (isDelete && !oldOpportunity.IsWon)
				continue; // Nothing to do this opportunity is currently not summarized.
			if (!isDelete && !newOpportunity.IsWon && !oldOpportunity.IsWon)
				continue; // Ignoring opportunities that aren't won because they should not summarized yet.
			if (Test.isRunningTest())
				System.assertNotEquals(oldOpportunity.StageName, newOpportunity.StageName, 'Las etapas son iguales: ' + newOpportunity.StageName);
			if (!accountIds.contains(oldOpportunity.AccountId) && (isDelete || newOpportunity.Amount != oldOpportunity.Amount || newOpportunity.Wood_Type__c != oldOpportunity.Wood_Type__c || oldOpportunity.StageName != newOpportunity.StageName)) {
				accountIds.add(oldOpportunity.AccountId);
			}
		}

		if (!accountIds.isEmpty()) {
			AccountService.getInstance().woodTypeSummarize(accountIds);
		}
	}
}
