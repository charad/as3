/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 21, 2011, at 9:00:30 PM
 ********************************
 **/
package be.arnordhaenens.controllers.pictures
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.services.PictureAssignmentService;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	LoadPictureAssignmentsCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 21, 2011, at 9:00:30 PM
	 * @see		be.arnordhaenens.controllers.pictures.LoadPictureAssignmentsCommand
	 **/
	public class LoadPictureAssignmentsCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var service:PictureAssignmentService;
		
		/**
		 * Constructor
		 **/
		public function LoadPictureAssignmentsCommand()
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
			//call public function of the service
			this.service.loadPictureAssignments();
		}
	}
}