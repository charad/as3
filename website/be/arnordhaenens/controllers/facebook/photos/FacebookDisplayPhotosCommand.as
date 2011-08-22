/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 1:53:05 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.photos
{	
	/**
	 * Imports
	 **/
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookDisplayPhotosCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 1:53:05 PM
	 * @see		be.arnordhaenens.controllers.facebook.photos.FacebookDisplayPhotosCommand
	 **/
	public class FacebookDisplayPhotosCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:*;
		
		/**
		 * Constructor
		 **/
		public function FacebookDisplayPhotosCommand()
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
			//create new instance
			
			//check if it has been mapped
			
			//add child to the context view
			//contextView.addChild(_view);
		}
	}
}