public with sharing class Cat extends Walker {

	public Cat() {

	}

	public void makeNoise() {
		meow();
	}

	public void swim() {
		// ignore, cannot swim
	}

	private void meow() {
		// meowing behavior here
	}
}
