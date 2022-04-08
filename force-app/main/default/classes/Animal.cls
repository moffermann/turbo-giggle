public abstract inherited sharing class Animal {

	// We convert this property in read-only because the animal type will be the instance name.
	global String animalType { get {
			String str = String.valueOf(this);
			return str.substring(0, str.indexOf(':'));
		}
	}

	// Extra: To allow instanciate animals by name
	public static Animal newInstance(String animalType) {
		//Using assertions instead of exceptions only for this test.
		System.assertNotEquals(null, animalType, 'The animal type can not be null');
		Type classType = Type.forName(animalType);
		System.assertNotEquals(null, classType, 'The animal type ' + animalType + ' has not been implemented yet');
		System.assert(Animal.class.isAssignableFrom(classType), 'Class type is not an animal');
		return (Animal)classType.newInstance();
	}

	public abstract void makeNoise();

	public abstract void move();

	public abstract void swim();
}