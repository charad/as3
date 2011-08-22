/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 6:01:27 PM
 ********************************
 **/
package be.arnordhaenens.services
{
	import be.arnordhaenens.events.AssignmentEvent;
	
	import flash.net.Responder;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	AssignmentService
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 22, 2011, at 6:01:27 PM
	 * @see		be.arnordhaenens.services.AssignmentService
	 **/
	public class AssignmentService extends myService
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function AssignmentService()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		public function getAllAssignments():void
		{
			//create new responder
			responder = new Responder(handleAssignmentsLoaded, handleFault);
			
			//call the function from the service
			connection.call("AssignmentService.getAllAssignments", responder);
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
		 * Handle assignments loaded
		 **/
		private function handleAssignmentsLoaded(result:Object):void
		{
			/*MonsterDebugger.trace(this, "assignment result");
			MonsterDebugger.trace(this, result);*/
			
			//dispatch the event
			//send the data
			dispatch(new AssignmentEvent(AssignmentEvent.ASSIGNMENTS_LOADED, result));
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
	}
}