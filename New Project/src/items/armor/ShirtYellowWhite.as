package items.armor
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class ShirtYellowWhite extends Item
	{
		[Embed(source = "../clothing_hair/shirt_white_yellow.png")]
		private var img:Class;
		[Embed(source = "../clothing_hair/shirt_white_yellow_ico.png")]
		private var icoClass:Class; 
		public function ShirtYellowWhite()
		{
			super("Yellow White Shirt", 0, 1, "A simple multicolored shirt.", "armor", true);
			setIcon(ConvertEmbedToSprite(icoClass));
			setMobVersion(img);

		}
		
		public function equipMe(tgt:Mob):void
		{
			tgt.equip(this);
		}
	
	}

}