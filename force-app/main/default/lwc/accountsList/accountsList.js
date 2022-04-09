import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/Account_Selected__c';
export default class AccountsList extends LightningElement {

	@wire(getAccounts)
	accounts;
	@wire(MessageContext)
	messageContext;

	fetchContacts(event){
		event.preventDefault();
		const index = parseInt(event.target.dataset.index),
					payload = { account: this.accounts.data[index] };
		publish(this.messageContext, ACCOUNT_SELECTED_CHANNEL, payload);
	}

}