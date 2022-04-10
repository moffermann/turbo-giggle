@isTest
public with sharing class AccountControllerTest {

	@testSetup
	static void makeData(){
		Account[] accounts = new Account[]{
			new Account(Name = 'Account 1', Website = 'www.account1.com', Phone = '+569933355544'),
			new Account(Name = 'Account 2', Website = 'www.account2.com', Phone = '+569933355566')
		};
		insert accounts;
	}

	@isTest
	static void given_TwoAccounts_when_CallGetAccounts_then_ReturnTwoAccountsWithAllFields(){
		Test.startTest();
		Account[] accounts = AccountController.getAccounts();
		Test.stopTest();
		System.assertEquals(2, accounts.size());
		System.assertNotEquals(null, accounts[0].Name);
		System.assertNotEquals(null, accounts[0].Website);
		System.assertNotEquals(null, accounts[0].Phone);
		System.assertNotEquals(null, accounts[1].Name);
		System.assertNotEquals(null, accounts[1].Website);
		System.assertNotEquals(null, accounts[1].Phone);
	}

}
