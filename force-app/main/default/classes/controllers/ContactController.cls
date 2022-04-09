public with sharing class ContactController {

	@AuraEnabled(cacheable=true)
	public static Contact[] getContacts(Id accountId) {
		return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE AccountId = :accountId WITH SECURITY_ENFORCED];
	}

}
