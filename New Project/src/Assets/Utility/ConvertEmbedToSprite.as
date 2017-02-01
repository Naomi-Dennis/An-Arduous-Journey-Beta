package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite; 
	public function ConvertEmbedToSprite(embedd:*):Sprite
	{
		var spr:Sprite = new Sprite(); 
		var bmp:Bitmap = new embedd() as Bitmap; 
		spr.addChild(bmp); 
		return spr; 
	}
}