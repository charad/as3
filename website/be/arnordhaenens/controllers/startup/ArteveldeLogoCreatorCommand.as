/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 9:39:51 PM
 ********************************
 **/
package be.arnordhaenens.controllers.startup
{
	import be.arnordhaenens.views.components.ArteveldeLogo;
	import be.arnordhaenens.views.mediators.ArteveldeMediator;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ArteveldeLogoCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 19, 2011, at 9:39:51 PM
	 * @see		be.arnordhaenens.controllers.ArteveldeLogoCreatorCommand
	 **/
	public class ArteveldeLogoCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _logo:ArteveldeLogo;
		
		/**
		 * Constructor
		 **/
		public function ArteveldeLogoCreatorCommand()
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
			_logo = new ArteveldeLogo();
			_logo.name = "arteveldelogo";
			
			//check if has mapping
			if(!mediatorMap.hasMediatorForView(_logo))
				mediatorMap.mapView(ArteveldeLogo, ArteveldeMediator);
			
			//add to the contextview
			contextView.addChild(_logo);
		}
	}
}