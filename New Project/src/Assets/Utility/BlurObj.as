package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J Dennis
	 */
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.display.Sprite; 
	
	public function BlurObj(spr:*, blurX:Number, blurY:Number):void
	{
		var filter:BlurFilter = new BlurFilter(blurX, blurY); 
		spr.filters = [filter]; 
	
	}

}