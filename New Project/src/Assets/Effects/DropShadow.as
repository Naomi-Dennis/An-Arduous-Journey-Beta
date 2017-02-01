package Assets.Effects
{
	import flash.filters.DropShadowFilter;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public function DropShadow(obj:*):void
	{
		var spr:* = obj;
		var blurX:Number = 2;
		var blurY:Number = 2;
		var distance:Number = 3
		var angle:Number = 45; 
		var color:Number = 0x000000;
		
		var filter:DropShadowFilter = new DropShadowFilter(distance, angle, color, 1);
		spr.filters = [filter];
	}

}