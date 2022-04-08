public with sharing class Cat extends Walker {

	public override void makeNoise() {
		meow();
	}

	public override void swim() {
		// ignore, cannot swim
	}

	private void meow() {
		// meowing behavior here
	}
}
