package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class BrownShoes extends Item
	{
		[Embed(source = "../pics/brown shoes mv.png")]
		private var mv:Class; 
		public function BrownShoes() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Brown Shoes", 0, 2, "A pair of brown shoes", "shoes", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}