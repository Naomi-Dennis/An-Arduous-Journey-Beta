package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class BluePants extends Item
	{
		[Embed(source = "../pics/blue pants mv.png")]
		private var mv:Class; 
		public function BluePants() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Blue Pants", 0, 1, "A pair of blue pants.", "leggings", true);
			setIcon(ConvertEmbedToSprite(mv));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}