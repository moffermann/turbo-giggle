@IsTest
private class ServiceTest {

	static testMethod void disableTest() {
		Test.startTest();
		Service.disable();
		Test.stopTest();
		System.assertNotEquals(0, Instance.instanceMap.size(), 'No se desactivaron los services');
		System.assert(Instance.instanceMap.containsKey(Service.class), 'No se desactivó el service');
		Service stub = (Service)Instance.instanceMap.get(Service.class);
		System.assertNotEquals(null, stub, 'El service es null. ');
	}

	static testMethod void getInstanceTest() {
		Service.disable(Service.class);
		Test.startTest();
		Service stub = (Service)Service.getInstance(Service.class);
		Test.stopTest();
		System.assertNotEquals(null, stub, 'El stub del service es null');
	}

	static testMethod void exceptionTest() {
		Test.startTest();
		Service.exception(Service.class);
		Test.stopTest();
		System.assertNotEquals(0, Instance.instanceMap.size(), 'No se excepcionó el Service');
		System.assert(Instance.instanceMap.containsKey(Service.class), 'No se excepcionó el service');
		Service stub = (Service)Instance.instanceMap.get(Service.class);
		System.assertNotEquals(null, stub, 'El service es null. ');
	}

	public class FooService extends Service {
	}

	static testMethod void getMapTest() {
		User[] users = [SELECT Id, Username FROM User];
		Test.startTest();
		Map<String, Sobject> userMap = FooService.getInstance(FooService.class).getMap(users, new Schema.SobjectField[] {User.Username});
		Test.stopTest();
		User user = [SELECT Username FROM User WHERE Id = :UserInfo.getUserId()];
		System.assert(userMap.containsKey(user.Username), 'El mapa no contiene la llave de username: ' + userMap.keySet());
		System.assert(userMap.get(user.Username) instanceof User, 'El mapa no contiene una instancia de User');
		User user2 = (User)userMap.get(user.Username);
		System.assertNotEquals(null, user2, 'User del mapa es null');
	}

}