import { LightningElement, wire, api } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { subscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/Account_Selected__c';
export default class ContactList extends LightningElement {

	@api selectedAccount = {Id: '', Name: ''};

	@wire(MessageContext)
	messageContext;
	@wire(getContacts, { accountId: '$selectedAccount.Id' })
	contacts

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