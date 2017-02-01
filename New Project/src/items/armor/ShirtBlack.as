package items.armor
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	
	/**
	 * ...
	 * @author lk
	 */
	public class ShirtBlack extends Item
	{
		[Embed(source = "../clothing_hair/shirt_black.png")]
		private var img:Class;
		[Embed(source = "../clothing_hair/shirt_black_ico.png")]
		private var icoClass:Class; 
		public function ShirtBlack()
		{
			
			super("Black Shirt", 0, 1, "A simple black shirt.", "armor", true);
			setIcon(ConvertEmbedToSprite(icoClass));
			setMobVersion(img);
		}
		
		public function equipMe(tgt:Mob):void
		{
			tgt.equip(this);
		}
	
	}

}