/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 4:14:32 PM
 ********************************
 **/
package be.arnordhaenens.controllers.contact
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.contact.ContactView;
	import be.arnordhaenens.views.mediators.contact.ContactMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	ContactCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 23, 2011, at 4:14:32 PM
	 * @see		be.arnordhaenens.controllers.contact.ContactCreatorCommand
	 **/
	public class ContactCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:ContactView;
		
		/**
		 * Constructor
		 **/
		public function ContactCreatorCommand()
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
			this._view = new ContactView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(ContactView))
				mediatorMap.mapView(ContactView, ContactMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}