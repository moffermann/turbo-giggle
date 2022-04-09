public with sharing class AccountServiceStub implements StubProvider {

	public Set<Id> accountIds {get; set;}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
		if (stubbedMethodName == 'woodTypeSummarize' && listOfArgs != null && listOfArgs.size() > 0)
		this.accountIds = (Set<Id>)listOfArgs[0];
		return null;
	}
}
