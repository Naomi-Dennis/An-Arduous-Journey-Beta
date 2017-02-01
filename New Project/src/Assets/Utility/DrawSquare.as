package Assets.Utility
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function DrawSquare(w:int, h:int, color:Number=0x000000):Sprite
	{
		var square:Sprite = new Sprite();
		square.graphics.beginFill(color, 1);
		square.graphics.drawRect(0, 0, w, h);
		square.graphics.endFill();
		return square;
	}
}