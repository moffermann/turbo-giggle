trigger WoodTypeInitialization on Account (before insert) {
	for (Account account : Trigger.new) {
		account.Total_Sales_Standard_Wood__c = 0;
		account.Total_Sales_Recycled_Wood__c = 0;
	}
}