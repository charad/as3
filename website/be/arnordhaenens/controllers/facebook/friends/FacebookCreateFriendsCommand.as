/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 19, 2011, at 11:41:39 AM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.friends
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.views.components.facebook.FacebookFriendsComponent;
	import be.arnordhaenens.views.mediators.facebook.FacebookFriendsMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookCreateFriendsCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 19, 2011, at 11:41:39 AM
	 * @see		be.arnordhaenens.controllers.facebook.friends.FacebookCreateFriendsCommand
	 **/
	public class FacebookCreateFriendsCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var event:FacebookEvent;
		private var _view:FacebookFriendsComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookCreateFriendsCommand()
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
			_view = new FacebookFriendsComponent(event.data);
			_view.name = "friends";
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_view))
				mediatorMap.mapView(FacebookFriendsComponent, FacebookFriendsMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}