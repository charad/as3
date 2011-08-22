/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 17, 2011, at 10:21:00 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.friends
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.models.FacebookModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookLoadFriendsCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 17, 2011, at 10:21:00 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookLoadFriendsCommand
	 **/
	public class FacebookLoadFriendsCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var model:FacebookModel;
		
		/**
		 * Constructor
		 **/
		public function FacebookLoadFriendsCommand()
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
			//call public function for loading friends timeline
			model.loadFollowers();
		}
	}
}