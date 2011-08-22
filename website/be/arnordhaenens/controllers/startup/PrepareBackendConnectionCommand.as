/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 1:30:47 PM
 ********************************
 **/
package be.arnordhaenens.controllers.startup
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.services.HelloService;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	PrepareBackendConnectionCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 23, 2011, at 1:30:47 PM
	 * @see		be.arnordhaenens.controllers.startup.PrepareBackendConnectionCommand
	 **/
	public class PrepareBackendConnectionCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var service:HelloService;
		
		/**
		 * Constructor
		 **/
		public function PrepareBackendConnectionCommand()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Override public function execute
		 * 
		 * When the command has to be executed
		 * Do something and then be destroyed after completion
		 * 
		 * Can be the result of dispatching an event
		 * Can be the result of executing a command directly
		 **/
		override public function execute():void
		{
			//call to the hello function
			this.service.hello("Arnor");
		}
	}
}