package Assets.Utility 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public function SpriteToBitmapData(sprite:Sprite):BitmapData
    {
        var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
        bitmapData.draw(sprite);

        return bitmapData;

    }

}