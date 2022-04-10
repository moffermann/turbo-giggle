import { createElement } from 'lwc';
import AccountsList from 'c/accountsList';
import { getAccounts } from '@salesforce/apex/AccountController.getAccounts';
import { publish } from 'lightning/messageService';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/Account_Selected__c';

const mockAccountsList = require("./data/getAccounts.json");

describe('c-accounts-list', () => {
	afterEach(() => {
		while (document.body.firstChild) {
				document.body.removeChild(document.body.firstChild);
		}
		jest.clearAllMocks();
	});
	it('displays a list of accounts', () => {
		const accountListElement = createElement('c-accounts-list', { is: AccountsList });
		document.body.appendChild(accountListElement);
		getAccounts.emit(mockAccountsList);
		return Promise.resolve().then(() => {
			const accountLinkElements = accountListElement.shadowRoot.querySelectorAll(".accountLink");
			for (let i = 0; i < accountLinkElements.length; i++)
				expect(accountLinkElements[i].textContent).toBe(mockAccountsList[i].Name);
		});
	});

	it('must publish to LMS when an account is clicked.', () => {
		const accountListElement = createElement('c-accounts-list', { is: AccountsList });
		document.body.appendChild(accountListElement);
		getAccounts.emit(mockAccountsList);
		return Promise.resolve().then(() => {
			const firstAccountLinkElement = accountListElement.shadowRoot.querySelector(".accountLink");
			firstAccountLinkElement.click();
			expect(publish).toHaveBeenCalled();
			expect(publish.mock.calls[0][1]).toBe(ACCOUNT_SELECTED_CHANNEL);
		});
	});

});