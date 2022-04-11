public class AccountHandler extends Handler {

	public static AccountHandler getInstance() {
		return (AccountHandler)Handler.getInstance(AccountHandler.class);
	}

	public void woodTypeSummarize() {
		try {
			Opportunity[] oldOpportunities = (Opportunity[])Trigger.old;
			Map<Id, Opportunity> newOpportunityMap = (Map<Id, Opportunity>)Trigger.newMap;
			Boolean isUpdate = Trigger.isUpdate;
			Boolean isDelete = Trigger.isDelete;
			woodTypeSummarize(isUpdate, isDelete, oldOpportunities, newOpportunityMap);
		} catch (System.Dmlexception dml) {
			Opportunity opportunity = (Opportunity) (Trigger.isDelete ? Trigger.old[0]:Trigger.new[0]);	// The index 0 isn't precise here, because the error can be thrown in other record, but this only occurs in a batch update processes. We can fix it using custom exceptions including accountId inside exception and iterate over opportunities that share the account.
			for (Integer i=0; i < dml.getNumDml(); i++) {
				String message = dml.getDmlMessage(i);
				opportunity.addError('Error summarizing wood type in account. The error message is ' + message);
			}
		}
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
