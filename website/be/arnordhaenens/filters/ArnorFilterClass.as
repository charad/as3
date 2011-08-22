/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 2:53:06 PM
 ********************************
 **/
package be.arnordhaenens.filters
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ArnorFIlterClass
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 21, 2011, at 2:53:06 PM
	 * @see		be.arnordhaenens.filters.ArnorFIlterClass
	 **/
	public class ArnorFilterClass
	{
		/**
		 * Variables
		 **/
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Create a DropShadow filter
		 **/
		public static function createDropShadowFilter():DropShadowFilter
		{
			//create new instance
			var shadow:DropShadowFilter;
			
			//set the values for the filter
			shadow = new DropShadowFilter();
			shadow.distance = 3;
			shadow.alpha = .75;
			shadow.color = 0x000000;
			shadow.blurX = shadow.blurY = 24;
			shadow.quality = BitmapFilterQuality.HIGH;
			
			return shadow;
		}
		
		/**
		 * Create Black-White color filter for the video
		 **/
		public static function createBWFilter():ColorMatrixFilter
		{
			//set the values
			var rLum:Number = 0.2225;
			var gLum:Number = 0.7169;
			var bLum:Number = 0.0606;
			
			//create new matrix
			var bwMatrix:Array = [	rLum, gLum, bLum, 0, 0,
				rLum, gLum, bLum, 0, 0,
				rLum, gLum, bLum, 0, 0,
				0, 0, 0, 1, 0];
			
			var cmatrix:ColorMatrixFilter = new ColorMatrixFilter(bwMatrix);
			
			return cmatrix;
		}
		
		/**
		 * Create blur filter
		 **/
		public static function createBlurFilter():BlurFilter
		{
			var blurFilter:BlurFilter = new BlurFilter();
			blurFilter.blurX = 6;
			blurFilter.blurY = 6;
			blurFilter.quality = BitmapFilterQuality.HIGH;
			
			return blurFilter;
		}
	}
}