package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class FeatherHatRed extends Item 
	{
		[Embed(source="../clothing_hair/feather_red.png")]
		private var mv:Class;
		[Embed(source = "../clothing_hair/feather_red_ico.png")]
		private var icoClass:Class; 
		public function FeatherHatRed() 
		{

			super("Red Feather Hat", 0, 0, "A stylish feather hat.", "hair", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
				tgt.getMobIcon().equip(this);
		}
		
	}

}