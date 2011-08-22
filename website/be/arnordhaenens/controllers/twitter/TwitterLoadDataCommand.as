/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 27, 2011, at 6:35:47 PM
 ********************************
 **/
package be.arnordhaenens.controllers.twitter
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.models.TwitterModel;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	TwitterLoadDataCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 27, 2011, at 6:35:47 PM
	 * @see		be.arnordhaenens.controllers.twitter.TwitterLoadDataCommand
	 **/
	public class TwitterLoadDataCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var twitterModel:TwitterModel
		
		/**
		 * Constructor
		 **/
		public function TwitterLoadDataCommand()
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
			//call the public method for loading the data
			twitterModel.loadTwitterData();
			
			/*MonsterDebugger.trace(this, "twitter load data command");*/
		}
	}
}