package Assets.Utility
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function GlowObj(obj:*, color:Number, strength:int=2, blurX:Number=2, blurY:Number=2, nAlpha:Number=.7):void
	{
		var spr:* = obj;
		var filter:GlowFilter = new GlowFilter(color, nAlpha, blurX, blurY);
		spr.filters= [filter]
	}

}