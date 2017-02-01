package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class RoyalShield extends Item
	{
		[Embed(source = "../pics/royal shieldmv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/royal_shield.png")]
		private var img:Class; 
		public function RoyalShield() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Royal Shield", 0, 27, "The royal shield of the king. It is created from titanium", "shield", true);
			setEnchancements("defense", 3);
			setEnchancements("strength", 3);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}