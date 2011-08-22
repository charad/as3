/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 17, 2011, at 5:26:54 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.timeline
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.models.FacebookModel;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookLoadTimelineCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 17, 2011, at 5:26:54 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookLoadTimelineCommand
	 **/
	public class FacebookLoadTimelineCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var model:FacebookModel;
		
		/**
		 * Constructor
		 **/
		public function FacebookLoadTimelineCommand()
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
			//call the load timeline function from the model
			model.loadTimeline();
		}
	}
}