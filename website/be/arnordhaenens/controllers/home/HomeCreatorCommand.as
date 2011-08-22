/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 9:11:34 PM
 ********************************
 **/
package be.arnordhaenens.controllers.home
{
	import be.arnordhaenens.views.components.home.HomeView;
	import be.arnordhaenens.views.mediators.home.HomeMediator;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	StartCommand
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 19, 2011, at 9:11:34 PM
	 * @see		be.arnordhaenens.controllers.StartCommand
	 **/
	public class HomeCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _home:HomeView;
		
		/**
		 * Constructor
		 **/
		public function HomeCreatorCommand()
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
			_home = new HomeView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(_home))
				mediatorMap.mapView(HomeView, HomeMediator);
			
			//add child to the context view
			contextView.addChild(_home);
		}
	}
}