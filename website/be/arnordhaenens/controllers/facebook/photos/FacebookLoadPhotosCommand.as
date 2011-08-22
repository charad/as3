/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 1:47:59 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.photos
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.models.FacebookModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookLoadPhotosCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 1:47:59 PM
	 * @see		be.arnordhaenens.controllers.facebook.photos.FacebookLoadPhotosCommand
	 **/
	public class FacebookLoadPhotosCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var model:FacebookModel;
		
		/**
		 * Constructor
		 **/
		public function FacebookLoadPhotosCommand()
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
			//call the public function from the model
			//to load the public photos
			model.loadPhotos();
		}
	}
}