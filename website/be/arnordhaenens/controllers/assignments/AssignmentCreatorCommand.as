/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:34:22 PM
 ********************************
 **/
package be.arnordhaenens.controllers.assignments
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.assignments.AssignmentView;
	import be.arnordhaenens.views.mediators.assignments.AssignmentMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	AssignmentCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 9:34:22 PM
	 * @see		be.arnordhaenens.controllers.assignments.AssignmentCreatorCommand
	 **/
	public class AssignmentCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:AssignmentView;
		
		/**
		 * Constructor
		 **/
		public function AssignmentCreatorCommand()
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
			_view = new AssignmentView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(AssignmentView))
				mediatorMap.mapView(AssignmentView, AssignmentMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}