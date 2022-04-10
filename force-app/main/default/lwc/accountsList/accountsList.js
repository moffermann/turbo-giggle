import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/Account_Selected__c';
export default class AccountsList extends LightningElement {

	accounts = [];
	error;

	@wire(getAccounts)
	wiredAccounts({error, data}){
		if (data)
			this.accounts = data;
		else
			this.error = error;
	}

	@wire(MessageContext)
	messageContext;

	fetchContacts(event){
		event.preventDefault();
		const index = parseInt(event.target.dataset.index, 10),
					payload = { account: this.accounts[index] };
		publish(this.messageContext, ACCOUNT_SELECTED_CHANNEL, payload);
	}

}