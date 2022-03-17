public with sharing class Horse extends Animal {

	public Horse() {

	}

	public void makeNoise() {
		neigh();
	}

	public void move() {
		slide();
	}

	public void swim() {
		// ignore, cannot swim
	}

	private void neigh() {
		// neighing behavior here
	}

	public void slide() {
		// sliding behavior here
	}
}
