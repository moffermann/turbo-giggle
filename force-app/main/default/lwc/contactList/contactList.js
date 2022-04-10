import { LightningElement, wire, api } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { subscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/Account_Selected__c';
export default class ContactList extends LightningElement {

	@api selectedAccount = {Id: '', Name: ''};
	contacts = [];
	error;

	@wire(MessageContext)
	messageContext;


	@wire(getContacts, { accountId: '$selectedAccount.Id' })
	wiredContacts({data, error}){
		if (data)
			this.contacts = data;
		else
			this.error = error;
	}

	connectedCallback() {
		if (!this.subscription) {
			this.subscription = subscribe(
				this.messageContext,
				ACCOUNT_SELECTED_CHANNEL,
				(message) => this.setSelectedAccount(message),
				{ scope: APPLICATION_SCOPE }
			);
		}
  }

	setSelectedAccount(message){
		this.selectedAccount = message.account;
	}

}