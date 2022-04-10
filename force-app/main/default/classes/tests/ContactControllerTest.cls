@isTest
public with sharing class ContactControllerTest {

	@testSetup
	static void makeData(){
		Account account1 = new Account(Name = 'Cosa nostra', Website = 'www.cosanostra.com', Phone = '+569931544477');
		insert account1;
		Contact[] contacts = new Contact[]{
			new Contact(Firstname = 'Vito', Lastname = 'Corleone', Title = 'CEO',
									Phone = '+569999999999', Email = 'vito.corleone@cosanostra.com', AccountId = account1.Id),
			new Contact(Firstname = 'Peter', Lastname = 'Clemenza', Title = 'COO',
									Phone = '+569999999999', Email = 'peter.clemenza@cosanostra.com', AccountId = account1.Id)
		};
		insert contacts;
	}


	@isTest
	static void given_Account_when_CallGetContacts_must_ReturnTwoContactsWithAllFields(){
		Account account1 = [SELECT Id FROM Account WHERE Name = 'Cosa nostra'];
		Test.startTest();
		Contact[] contacts = ContactController.getContacts(account1.Id);
		Test.stopTest();
		System.assertEquals(2, contacts.size());
		System.assertNotEquals(null, contacts[0].Name);
		System.assertNotEquals(null, contacts[0].Title);
		System.assertNotEquals(null, contacts[0].Phone);
		System.assertNotEquals(null, contacts[0].Email);
		System.assertNotEquals(null, contacts[1].Name);
		System.assertNotEquals(null, contacts[1].Title);
		System.assertNotEquals(null, contacts[1].Phone);
		System.assertNotEquals(null, contacts[1].Email);
	}

}
