/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 8:14:30 PM
 ********************************
 **/
package be.arnordhaenens.validation
{
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ArnorValidation
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 23, 2011, at 8:14:30 PM
	 * @see		be.arnordhaenens.validation.ArnorValidation
	 **/
	public class ArnorValidation
	{
		/**
		 * Variables
		 **/
		private static const MAIL:RegExp = /([a-z0-9._-]+?)@([a-z0-9.-]+)\.([a-z]{2,4})/;
		
		/**
		 * Constructor
		 **/
		public function ArnorValidation()
		{
			
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Validate mail
		 **/
		public static function validateMail(input:String):*
		{
			var result:Object = MAIL.exec(input);
			
			if(result == null)
				return false; 
			else if(result != null)
				return true;
		}
		
		/**
		 * Validate text
		 **/
		public static function validateText(input:String):*
		{
			var count:int = input.length;
			for(var i:int=0; i>count; i++)
			{
				var index:int = input.search(" ");
				if(index != -1)
					input[index] = "";
			}
			
			if(input.length == 0)
				return false;
			else
				return true;
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
	}
}