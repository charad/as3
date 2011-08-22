/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 11:02:20 AM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.message
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.models.FacebookModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookPostMessageCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 11:02:20 AM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookPostMessageCommand
	 **/
	public class FacebookPostMessageCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var model:FacebookModel;
		[Inject]public var event:FacebookEvent;
		
		/**
		 * Constructor
		 **/
		public function FacebookPostMessageCommand()
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
			model.postMessage();
		}
	}
}