/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 17, 2011, at 12:58:35 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.token
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.services.FacebookService;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookGetTokenCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 17, 2011, at 12:58:35 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookGetTokenCommand
	 **/
	public class FacebookGetTokenCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var event:FacebookEvent;
		[Inject]public var service:FacebookService;
		
		/**
		 * Constructor
		 **/
		public function FacebookGetTokenCommand()
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
			//MonsterDebugger.trace(this, "<!--GET TOKEN COMMAND-->");
			service.getAccessToken(event.data);
		}
	}
}