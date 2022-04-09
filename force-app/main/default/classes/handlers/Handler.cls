public abstract class Handler extends Instance {

	public static void disable() {
		Instance.disableAll(Handler.class);
	}
}