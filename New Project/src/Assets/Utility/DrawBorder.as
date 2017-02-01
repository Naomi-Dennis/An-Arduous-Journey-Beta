package Assets.Utility 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
		
		public function DrawBorder(spr:Sprite, thickness:Number=1.0, color:Number=0xffffff) :void
		{
			var width:int = spr.width;
			var height:int = spr.height;
			spr.graphics.lineStyle(thickness, color); 
			spr.graphics.moveTo(0, 0);
			spr.graphics.lineTo(width, 0);
			spr.graphics.lineTo(width, height);
			spr.graphics.lineTo(0, height);
			spr.graphics.lineTo(0, 0); 
		}
}