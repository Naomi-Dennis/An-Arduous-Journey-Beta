package items.armor
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class ShirtHawaii extends Item
	{
		[Embed(source = "../clothing_hair/shirt_hawaii.png")]
		private var img:Class;
		[Embed(source = "../clothing_hair/shirt_hawaii_ico.png")]
		private var icoClass:Class; 
		public function ShirtHawaii()
		{
			super("Hawaiian Shirt", 0, 1, "A simple Hawaiian shirt.", "armor", true);
			setIcon(ConvertEmbedToSprite(icoClass));
			setMobVersion(img);
		}
		
		public function equipMe(tgt:Mob):void
		{
			tgt.equip(this);
		}
	
	}

}