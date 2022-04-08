public with sharing class Cow extends Walker {

	public override void makeNoise() {
		moo();
	}

	public override void swim() {
		// ignore, cannot swim
	}

	private void moo() {
		// mooing behavior here
	}
}
