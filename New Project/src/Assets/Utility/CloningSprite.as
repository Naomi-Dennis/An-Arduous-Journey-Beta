package Assets.Utility 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class CloningSprite 
	{
		private var src:String = ""; 
		private var bitmap:Bitmap = new Bitmap();
		private var loaded:Boolean = false; 
		public function CloningSprite(_src:String) 
		{
			src = _src; 
			var loader:Loader = new Loader(); 
			var request:URLRequest = new URLRequest("images/human_m.png"); 
			loader.load(request); 
			
			var info:LoaderInfo = loader.contentLoaderInfo as LoaderInfo; 
			info.addEventListener(Event.COMPLETE, loadImage); 
		}
		private function loadImage(e:Event):void {
			bitmap = LoaderInfo(e.currentTarget).content as Bitmap; // load it as a bitmap
			loaded = true; 
		}
		public function clone():Sprite {
			var spr:Sprite = new Sprite();
			var cloneBmpData:BitmapData = bitmap.bitmapData.clone(); 
			var cloneBmp:Bitmap = new Bitmap(cloneBmpData); 
			spr.addChild(cloneBmp); 
			spr.width = 16;
			spr.height = 16; 
			
			return spr; 
		}
		public function ready():Boolean {
			return loaded; 
		}
		
	}

}