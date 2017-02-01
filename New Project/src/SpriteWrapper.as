package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Naomi
	 */
	public class SpriteWrapper extends Sprite
	{
		private var layers:Array = [];
		private var DEFAULT_DATA:BitmapData;
		public var bitmapData:BitmapData;
		
		public function SpriteWrapper(_bitmapData:BitmapData = null)
		{
			if (_bitmapData == null)
			{
				bitmapData = new BitmapData(32, 32, true, 0x0);
			}
			bitmapData = _bitmapData;
		
			//addChild(new Bitmap(bitmapData));
		}
		
		public function changeBitmapData(newBitmapData:BitmapData):void
		{
			removeChildren();
			bitmapData = newBitmapData
			removeFromBitmapData("default");
			layers.push({"default": bitmapData});
			if (numChildren < 1)
			{
				addChild(new Bitmap(newBitmapData));
			}
		}
		
		public function changeDefaultData(newBmd:BitmapData):void
		{
			DEFAULT_DATA = newBmd;
		}
		
		public function clear():void
		{
			removeChildren();
			bitmapData = DEFAULT_DATA.clone();
			layers.push({"default": bitmapData});
			addChild(new Bitmap(bitmapData));
			layers = [];
			
		}
		
		public function applyColor(color:Number):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			ct.alphaMultiplier = 0.5; 
			var className:String; 
			for (var i:int = 0; i < numChildren; ++i)
			{
				className = getQualifiedClassName(getChildAt(i)) 
				if (className == "flash.display::Bitmap")
				{
					getChildAt(i).transform.colorTransform = ct;
				}
			}
		}
		
		public function removeColor():void
		{
			var className:String; 
			for (var i:int = 0; i < numChildren; ++i)
			{
				className = getQualifiedClassName(getChildAt(i)) 
				if (className == "flash.display::Bitmap")
				{
					getChildAt(i).transform.colorTransform = new ColorTransform();
				}
			}
		}
		
		public function addToBitmapData(newBmd:BitmapData, layerName:String):void
		{
			if (bitmapData == null)
			{
				bitmapData = DEFAULT_DATA.clone();
			}
			removeChildren();
			if (layerName == "cell_state"){
				bitmapData.draw(newBmd, null, new ColorTransform(1,1,1,0.5));
			}
			else{
				bitmapData.draw(newBmd);
			}
			var obj:Object = new Object();
			obj.layerName = newBmd;
			layers.push(obj);
			addChild(new Bitmap(bitmapData));
		}
		
		public function removeFromBitmapData(layerName:String):void
		{
			clear();
			var n:int = 0;
			for (var i:* in layers)
			{
				if (layers[i].layerName.toLowerCase() == layerName.toLowerCase())
				{
					n = i;
				}
				else if (layers[i].layerName == "default")
				{
					continue;
				}
				bitmapData.draw(layers[i].layerName);
			}
			
			if (n == 0)
			{
				layers.splice(0, 1);
			}
			else
			{
				layers.splice(n, 1);
			}
		}
	
	}

}