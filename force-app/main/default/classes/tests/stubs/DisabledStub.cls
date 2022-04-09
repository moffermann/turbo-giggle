/**
 * @description       : Stub 
 * @author            : GOCODE WO
 * @group             : 
 * @last modified on  : 06-17-2021
 * @last modified by  : GOCODE WO
 * Modifications Log 
 * Ver   Date         Author      Modification
 * 1.0   06-17-2021   GOCODE WO   Initial Version
**/
@isTest
public class DisabledStub implements StubProvider {

	public static DisabledStub newInstance() {
		return new DisabledStub();
	}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
		return null;
	}

}