package Assets.Effects
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function GlowObj(obj:*, color:Number, strength:int=2):void
	{
		var spr:* = obj;
		var blurX:Number = 2;
		var blurY:Number = 2;
		var filter:GlowFilter = new GlowFilter(color, .7, blurX, blurY);
		spr.filters = [filter];
	}

}