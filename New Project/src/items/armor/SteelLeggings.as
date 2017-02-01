package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class SteelLeggings extends Item
	{
		[Embed(source = "../pics/steel plate legmv.png")]
		private var mv:Class; 
		public function SteelLeggings() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Steel Leggings", 1, 15, "Iron Leggings that protect your legs", "leggings", true);
			setIcon(ConvertEmbedToSprite(mv));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}