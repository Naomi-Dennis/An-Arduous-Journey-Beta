package Assets.Utility 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
		
		public function DrawBorderStandalone(spr:Sprite, thickness:Number=1.0, color:Number=0xffffff) :Sprite
		{
			var width:int = spr.width;
			var height:int = spr.height;
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(thickness, color); 
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(width, 0);
			border.graphics.lineTo(width, height);
			border.graphics.lineTo(0, height);
			border.graphics.lineTo(0, 0); 
			return border; 
		}
}