public abstract class Instance {

	public static final Map<Type, Instance> instanceMap;

	Static {
		instanceMap = new Map<Type, Instance>();
	}

	public Instance() {
	}

	public static Instance getInstance(Type classType) {
		if (Instance.instanceMap.containsKey(classType)) {
			return Instance.instanceMap.get(classType);
		}
	Instance instance1 = (Instance)classType.newInstance();
		Instance.instanceMap.put(classType, instance1);
		return instance1;
	}

	public static void setInstance(Type classType, Instance instance1) {
		Instance.instanceMap.put(classType, instance1);
	}

	public static void setMock(Type classType, StubProvider stub) {
		Instance.instanceMap.put(classType, (Instance) Test.createStub(classType, stub));
	}

public static void setMock(Type[] classTypes, StubProvider stub) {
		for (Type classType : classTypes) {
			Instance.setMock(classType, stub);
		}
	}

	public static void exception(Type classType) {
		exception(new Type[] {classType});
	}

	public static void exception(Type[] classTypes) {
		ExceptionStub stub = new ExceptionStub();
		setMock(classTypes, stub);
	}

	public static void disable(Type apexType) {
		disable(new Type[] {apexType});
	}

	public static void disable(Type[] classTypes) {
		DisabledStub stub = new DisabledStub();
		setMock(classTypes, stub);
	}
	
	public static void disableAll(Type instanceType) {
		String suffix = '%' + instanceType.getName();
		ApexClass[] apexClasses = [SELECT Name, NamespacePrefix FROM ApexClass WHERE Name LIKE :suffix AND Status = 'Active' AND NamespacePrefix = NULL];
		Type[] apexTypes = new List<Type>();
		for (ApexClass apexClass : apexClasses) {
			Type apexType = Type.forName(apexClass.Name);
			if (apexType != null && instanceType.isAssignableFrom(apexType)) {
				apexTypes.add(apexType);
			}
		}
		disable(apexTypes);
	}

	private String getKey(Sobject o, Schema.SobjectField[] fields) {
		String key = '';
		for (Schema.SobjectField field : fields) {
		Object value = o.get(field);
			key += String.valueOf(value);
		}
		return key;
	}

	public Map<String, Sobject> getMap(Sobject[] sobjects, Schema.SobjectField[] keyFields) {
		Map<String, Sobject> resultMap = new Map<String, Sobject>();
		for (Sobject o :sobjects) {
			String key = getKey(o, keyFields);
			resultMap.put(key, o);
		}
		return resultMap;
	}
}
