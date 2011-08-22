package be.arnordhaenens.services
{
	import flash.net.Responder;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Class	HelloService.as
	 * @author	D'Haenens Arnor
	 * @see		be.arnordhaenens.services.myService
	 **/
	public class HelloService extends myService
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function HelloService()
		{
			super();
		}
		
		/**
		 * Return hello
		 **/
		public function hello(naam:String):void
		{
			responder = new Responder(handleHelloResult, handleFault);
			connection.call("myService.hello", responder, naam);
		}
		
		/**
		 * Handle result hello
		 **/
		private function handleHelloResult(result:Object):void
		{
			MonsterDebugger.trace(this, result);
		}
	}
}