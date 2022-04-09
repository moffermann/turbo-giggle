@IsTest
private class InstanceTest {

	static testMethod void getInstanceTest() {
		Instance.disable(Instance.class);
		Test.startTest();
		Instance stub = (Instance)Instance.getInstance(Instance.class);
		Test.stopTest();
		System.assertNotEquals(null, stub, 'El stub del instance es null');
	}

	static testMethod void exceptionTest() {
		Test.startTest();
		Instance.exception(Instance.class);
		Test.stopTest();
		System.assertNotEquals(0, Instance.instanceMap.size(), 'No se excepcionó el Instance');
		System.assert(Instance.instanceMap.containsKey(Instance.class), 'No se excepcionó el instance');
		Instance stub = (Instance)Instance.instanceMap.get(Instance.class);
		System.assertNotEquals(null, stub, 'El instance es null. ');
	}

	public class FooInstance extends Instance {
	}

	static testMethod void getMapTest() {
		User[] users = [SELECT Id, Username FROM User];
		Test.startTest();
		Map<String, Sobject> userMap = FooInstance.getInstance(FooInstance.class).getMap(users, new Schema.SobjectField[] {User.Username});
		Test.stopTest();
		User user = [SELECT Username FROM User WHERE Id = :UserInfo.getUserId()];
		System.assert(userMap.containsKey(user.Username), 'El mapa no contiene la llave de username: ' + userMap.keySet());
		System.assert(userMap.get(user.Username) instanceof User, 'El mapa no contiene una instancia de User');
		User user2 = (User)userMap.get(user.Username);
		System.assertNotEquals(null, user2, 'User del mapa es null');
	}

		//Solo cobertura
	static testMethod void setInstanceTest() {
		Instance.setInstance(Instance.class, null);
	}
}