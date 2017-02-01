package Screens
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawBorder;
	import Assets.Utility.DrawSquare;
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class ScreenBackground extends Sprite
	{
		[Embed(source="../pics/vertical window border.png")]
		public var verticalBorder:Class;
		[Embed(source="../pics/horizontal window border.png")]
		public var horizontalBorder:Class;
		[Embed(source="../pics/StoneBackgroundTile.png")]
		public var bkgrndTile:Class;
		public var bkgrnd:Sprite = new Sprite();
		public var topBorder:Sprite = new Sprite();
		public var bottomBorder:Sprite = new Sprite();
		public var leftBorder:Sprite = new Sprite();
		public var rightBorder:Sprite = new Sprite();
		public var size:Object = {};
		private var standard:Boolean = false;
		public function ScreenBackground(_size:Object, backgroundColor:Number, borderColor:Number, _standard:Boolean=true)
		{
			/*
			 * size should be in the format {width:0, height:0}
			 * */
			standard = _standard; 
			size = _size;
			var borderThickness:Number = 2.5;
			var offset:int = 0;
			(standard) ? offset = 2 : offset = 0; 
			size.width += offset;
			size.height += offset; 
			leftBorder = ConvertEmbedToSprite(verticalBorder);
			leftBorder.height = size.height;
			leftBorder.width = borderThickness;
			rightBorder = ConvertEmbedToSprite(verticalBorder);
			rightBorder.height = size.height;
			rightBorder.width = borderThickness;
			rightBorder.x = size.width;
			topBorder = ConvertEmbedToSprite(horizontalBorder);
			topBorder.width = size.width;
			topBorder.height = borderThickness;
			bottomBorder = ConvertEmbedToSprite(horizontalBorder);
			bottomBorder.width = size.width;
			bottomBorder.height = borderThickness;
			bottomBorder.y = size.height;
			//	DrawBorder(bkgrnd, 5, borderColor); 
			fillBox();
			bkgrnd.addChild(bottomBorder);
			bkgrnd.addChild(topBorder);
			bkgrnd.addChild(leftBorder);
			bkgrnd.addChild(rightBorder);
			addChild(bkgrnd);
		}
		
		public function fillBox():void
		{
			
			var tileWidth:int = 60;
			var tileHeight:int = 63; 
			if (!standard){
				tileWidth = size.height;
				tileHeight = size.height; 
			}
			var tile:Sprite = ConvertEmbedToSprite(bkgrndTile);
			tile.width = tileWidth;
			tile.height = tileHeight;
			//addChild(tile);
			var maxHeight:int = 0;
			var maxWidth:int = 0;
			var counterWidth:int = size.width;
			var counterHeight:int = size.height;
			var offsetTile:Sprite = new Sprite();
			
			while (counterWidth > tile.width)
			{
				counterWidth -= tile.width;
				maxWidth++;
			}
			if (counterHeight < tile.height){
				maxHeight = 1; 
			}
			else{
				while (counterHeight > tile.height)
					{
					counterHeight -= tile.height
					maxHeight++;
				}
			}
			for (var i:int = 0; i < maxWidth; ++i)
			{
				for (var j:int = 0; j < maxHeight; j++)
				{
					tile = ConvertEmbedToSprite(bkgrndTile);
					tile.width = tileWidth;
					tile.height = tileHeight;
					tile.x = i * tile.width;
					tile.y = j * tile.height;
					addChild(tile);
					if (counterWidth > 0 )
					{
						offsetTile = ConvertEmbedToSprite(bkgrndTile);
						offsetTile.width = tile.width;
						offsetTile.height = tile.height;
						offsetTile.x = size.width - offsetTile.width;
						offsetTile.y = j * tile.height; 
						addChild(offsetTile);
					}
				}
				// ** //
				if (counterHeight > 0) {
					offsetTile = ConvertEmbedToSprite(bkgrndTile);
					offsetTile.width = tileWidth;
					offsetTile.height = tileHeight;
					offsetTile.x = i * tileWidth;
					offsetTile.y = size.height - offsetTile.height; 
					addChild(offsetTile);
				}
				
			}
			offsetTile = ConvertEmbedToSprite(bkgrndTile);
			offsetTile.width = tileWidth;
			offsetTile.height = tileHeight;
			offsetTile.x = size.width - offsetTile.width;
			offsetTile.y = size.height - offsetTile.height;
			addChild(offsetTile); 
			// * *//
		
		}
	
	}

}