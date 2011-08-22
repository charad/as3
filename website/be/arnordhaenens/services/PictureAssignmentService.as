/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 21, 2011, at 12:32:32 PM
 ********************************
 **/
package be.arnordhaenens.services
{
	import be.arnordhaenens.events.PictureEvent;
	
	import flash.net.Responder;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	PictureAssignmentService
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 21, 2011, at 12:32:32 PM
	 * @see		be.arnordhaenens.services.PictureAssignmentService
	 **/
	public class PictureAssignmentService extends myService
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function PictureAssignmentService()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Load all the assignments 
		 * Pictures
		 **/
		public function loadPictureAssignments():void
		{
			//create new responder
			responder = new Responder(handlePictureAssignmentsLoaded, handleFault);
			
			//call the function in the service
			connection.call("PictureAssignmentService.getAllImageAssignments", responder);
		}
		
		/**
		 * Load all the images of a certain assignment
		 **/
		public function loadImagesAssignment(p_assignment:*):void
		{
			//create new responder
			responder = new Responder(handleImagesLoaded, handleFault);
			
			//call the function in the service
			connection.call("PictureAssignmentService.getImagesAssignment", responder, p_assignment);
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		/**
		 * Handle all the assignments of the type 'picture' loaded
		 **/
		private function handlePictureAssignmentsLoaded(result:Object):void
		{
			//MonsterDebugger.trace(this, result);
			
			//dispatch the event with the data
			dispatch(new PictureEvent(PictureEvent.PICTURE_ASSIGNMENTS_LOADED, result));
		}
		
		/**
		 * Handle images loaded for a certain assignment
		 **/
		private function handleImagesLoaded(result:Object):void
		{
			MonsterDebugger.trace(this, result);
			
			//dispatch event with the data
			dispatch(new PictureEvent(PictureEvent.IMAGES_LOADED, result));
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
	}
}