public with sharing class Horse extends Animal {

	public override void makeNoise() {
		neigh();
	}

	public override void move() {
		slide();
	}

	public override void swim() {
		// ignore, cannot swim
	}

	private void neigh() {
		// neighing behavior here
	}

	public void slide() {
		// sliding behavior here
	}
}
