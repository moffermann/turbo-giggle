public with sharing class AccountController {

	@AuraEnabled(cacheable=true)
	public static Account[] getAccounts() {
		return [SELECT Id, Name, Website, Phone FROM Account WITH SECURITY_ENFORCED];
	}

}
