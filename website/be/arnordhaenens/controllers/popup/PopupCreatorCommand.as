/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 5:03:32 PM
 ********************************
 **/
package be.arnordhaenens.controllers.popup
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.views.components.popup.PopUpComponent;
	import be.arnordhaenens.views.mediators.popup.PopupMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	PopupCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 5:03:32 PM
	 * @see		be.arnordhaenens.controllers.popup.PopupCreatorCommand
	 **/
	public class PopupCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:PopUpComponent;
		[Inject]public var event:PopupEvent;
		
		/**
		 * Constructor
		 **/
		public function PopupCreatorCommand()
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
			_view = new PopUpComponent(event.data);
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_view))
				mediatorMap.mapView(PopUpComponent, PopupMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}