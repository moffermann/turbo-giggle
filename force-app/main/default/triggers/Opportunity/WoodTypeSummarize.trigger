// Amount will be always  in zero in after insert event, althought we must initialize it with 0 (may be in other before insert trigger).
trigger WoodTypeSummarize on Opportunity (after update, after delete, after undelete) {
	AccountHandler.getInstance().woodTypeSummarize();
}