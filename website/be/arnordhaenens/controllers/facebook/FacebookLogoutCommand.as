/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 12:11:37 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.models.FacebookModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookLogoutCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 12:11:37 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookLogoutCommand
	 **/
	public class FacebookLogoutCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var model:FacebookModel;
		
		/**
		 * Constructor
		 **/
		public function FacebookLogoutCommand()
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
			//call public function to log out
			model.logoutFacebook();
		}
	}
}