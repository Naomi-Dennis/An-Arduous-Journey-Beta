package Assets.Utility 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public function BitmapDataToSprite(bitmapData:BitmapData, smoothing:Boolean = false):Sprite
    {
        var sprite:Sprite = new Sprite();
        sprite.addChild( new Bitmap(bitmapData.clone(), "auto", smoothing) );
        return sprite;

    } // END FUNCTION bitmapToSprite

}