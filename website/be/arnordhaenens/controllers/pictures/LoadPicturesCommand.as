/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 21, 2011, at 12:31:10 PM
 ********************************
 **/
package be.arnordhaenens.controllers.pictures
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.services.PictureAssignmentService;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	LoadPicturesCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 21, 2011, at 12:31:10 PM
	 * @see		be.arnordhaenens.controllers.pictures.LoadPicturesCommand
	 **/
	public class LoadPicturesCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var service:PictureAssignmentService;
		[Inject]public var event:PictureEvent;
		
		/**
		 * Constructor
		 **/
		public function LoadPicturesCommand()
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
			service.loadImagesAssignment(event.data);
		}
	}
}