package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class IronLeggings extends Item
	{
		[Embed(source = "../pics/ironPlateLegMV.png")]
		private var mv:Class; 
		[Embed(source = "../pics/iron_leggings_icon.png")]
		private var ico_class:Class; 
		public function IronLeggings() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Iron Leggings", 0, 8, "Iron Leggings that protect your legs", "leggings", true);
			setIcon(ConvertEmbedToSprite(ico_class));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}