package items.armor
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class Vest extends Item
	{
		[Embed(source = "../clothing_hair/shirt_vest.png")]
		private var img:Class;
		[Embed(source = "../clothing_hair/shirt_vest_ico.png")]
		private var icoClass:Class; 
		public function Vest()
		{
			super("Vest", 0, 1, "A simple vest.", "armor", true);
			setIcon(ConvertEmbedToSprite(icoClass));
			setMobVersion(img);

		}
		
		public function equipMe(tgt:Mob):void
		{
			tgt.equip(this);
		}
	
	}

}