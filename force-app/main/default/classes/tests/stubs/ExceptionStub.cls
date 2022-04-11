@IsTest
public class ExceptionStub implements StubProvider {
	public Exception ex {get; set;}

	public ExceptionStub() {
		this(null);
	}

	public ExceptionStub(Exception ex) {
			this.ex = ex;
	}

	public class StubException extends Exception {}

	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, System.Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
		if (this.ex == null)
			throw new StubException('No debería invocarse este método: ' + stubbedMethodName);
		throw this.ex;
	}
}