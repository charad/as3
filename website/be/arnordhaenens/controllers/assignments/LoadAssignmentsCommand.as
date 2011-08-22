/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 7:51:05 PM
 ********************************
 **/
package be.arnordhaenens.controllers.assignments
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.services.AssignmentService;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	LoadAssignmentsCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 7:51:05 PM
	 * @see		be.arnordhaenens.controllers.assignments.LoadAssignmentsCommand
	 **/
	public class LoadAssignmentsCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var service:AssignmentService;
		
		/**
		 * Constructor
		 **/
		public function LoadAssignmentsCommand()
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
			service.getAllAssignments();
		}
	}
}