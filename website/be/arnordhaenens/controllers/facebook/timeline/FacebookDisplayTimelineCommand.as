/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 11:51:25 AM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.timeline
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.views.components.facebook.timeline.FacebookPostComponent;
	import be.arnordhaenens.views.mediators.facebook.timeline.FacebookPostMediator;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookDisplayTimelineCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 11:51:25 AM
	 * @see		be.arnordhaenens.controllers.facebook.timeline.FacebookDisplayTimelineCommand
	 **/
	public class FacebookDisplayTimelineCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FacebookPostComponent;
		[Inject]public var event:FacebookEvent;
		
		/**
		 * Constructor
		 **/
		public function FacebookDisplayTimelineCommand()
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
			_view = new FacebookPostComponent(event.data);
			_view.name = "post";
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_view))
				mediatorMap.mapView(FacebookPostComponent, FacebookPostMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}