public abstract class Service extends Instance {

	public static void disable() {
		Instance.disableAll(Service.class);
	}

}