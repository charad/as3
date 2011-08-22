/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 9:26:08 PM
 ********************************
 **/
package be.arnordhaenens.controllers.startup
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.menu.MenuComponent;
	import be.arnordhaenens.views.mediators.menu.MenuMediator;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	MenuCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 21, 2011, at 9:26:08 PM
	 * @see		be.arnordhaenens.controllers.startup.MenuCreatorCommand
	 **/
	public class MenuCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:MenuComponent;
		
		/**
		 * Constructor
		 **/
		public function MenuCreatorCommand()
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
			_view = new MenuComponent();
			_view.name = "menu";
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_view))
				mediatorMap.mapView(MenuComponent, MenuMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}