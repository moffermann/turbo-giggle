public with sharing class Cow extends Walker {
    public Cow() {

    }

	public void makeNoise() {
		moo();
	}

	public void swim() {
		// ignore, cannot swim
	}

	private void moo() {
		// mooing behavior here
	}
}
