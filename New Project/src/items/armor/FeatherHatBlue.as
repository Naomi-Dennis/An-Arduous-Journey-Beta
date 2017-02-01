package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class FeatherHatBlue extends Item
	{
		[Embed(source = "../clothing_hair/feather_blue.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/feather_hat_ico.png")]
		private var icoClass:Class; 
		public function FeatherHatBlue() 
		{
		
			super("Blue Feather Hat", 0, 0, "A stylish feather hat.", "hair", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
	}

}