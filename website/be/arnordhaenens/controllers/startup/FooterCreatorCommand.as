/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 10:27:04 PM
 ********************************
 **/
package be.arnordhaenens.controllers.startup
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.footer.FooterComponent;
	import be.arnordhaenens.views.mediators.footer.FooterMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FooterCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 10:27:04 PM
	 * @see		be.arnordhaenens.controllers.startup.FooterCreatorCommand
	 **/
	public class FooterCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FooterComponent;
		
		/**
		 * Constructor
		 **/
		public function FooterCreatorCommand()
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
			_view = new FooterComponent();
			_view.name = "footer";
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_view))
				mediatorMap.mapView(FooterComponent, FooterMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}