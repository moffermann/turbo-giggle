@IsTest
private class HandlerTest {

	static testMethod void disableTest() {
		Test.startTest();
		Handler.disable();
		Test.stopTest();
		System.assertNotEquals(0, Instance.instanceMap.size(), 'No se desactivaron los handlers');
		System.assert(Instance.instanceMap.containsKey(Handler.class), 'No se desactivó el handler');
		Handler stub = (Handler)Instance.instanceMap.get(Handler.class);
		System.assertNotEquals(null, stub, 'El handler es null. ');
	}

	static testMethod void getInstanceTest() {
		Handler.disable(Handler.class);
		Test.startTest();
		Handler stub = (Handler)Handler.getInstance(Handler.class);
		Test.stopTest();
		System.assertNotEquals(null, stub, 'El stub del handler es null');
	}

	static testMethod void exceptionTest() {
		Test.startTest();
		Handler.exception(Handler.class);
		Test.stopTest();
		System.assertNotEquals(0, Instance.instanceMap.size(), 'No se excepcionó el Handler');
		System.assert(Instance.instanceMap.containsKey(Handler.class), 'No se excepcionó el handler');
		Handler stub = (Handler)Instance.instanceMap.get(Handler.class);
		System.assertNotEquals(null, stub, 'El handler es null. ');
	}

}