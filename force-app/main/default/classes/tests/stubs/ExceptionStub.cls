@IsTest
public class ExceptionStub implements StubProvider {

	public class StubException extends Exception {}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
		throw new StubException('No debería invocarse este método: ' + stubbedMethodName);
	}
}