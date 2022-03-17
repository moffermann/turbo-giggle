public inherited sharing class Animal {

	public String animalType;

	public Animal(String animalType) {
		this.animalType = animalType;
	}

	public static Animal newInstance(String animalType) {
		//Using assertions instead of exceptions only for this exam.
		System.assertNotEquals(null, animalType, 'The animal type can not be null');
		Type classType = Type.forName(animalType);
		System.assertNotEquals(null, classType, 'The animal type ' + animalType + ' has not been implemented yet');
		System.assert(Animal.class.isAssignableFrom(classType), 'Class type is not an animal');
		Animal animal = (Animal)classType.newInstance();
		animal.animalType = animalType;
		return animal;
	}

	public abstract void makeNoise();

	public abstract void move();

	public abstract void swim();
}