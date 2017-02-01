package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite; 
	public function ConvertEmbedToBitmapData(embedd:*, width:int=32, height:int=32):BitmapData
	{
		var bmp:Bitmap = new embedd() as Bitmap;
		bmp.width = width;
		bmp.height = height;
		return  bmp.bitmapData 
	}
}