package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class RoyalChainmail extends Item
	{
		[Embed(source = "../pics/royal chainmail.png")]
		private var img:Class; 
		[Embed(source = "../pics/royal ringmailmv.png")]
		private var mv:Class; 
		public function RoyalChainmail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Royal Chainmail", 0, 20, "Chainmail created with Valorian steel. It is ingraved with the royal seal.", "armor", true);
			setEnchancements("strength", 1);
			setEnchancements("wisdom", 1);
			setEnchancements("dexterity", 1);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
			tgt.equip(new SteelLeggings());
		}
		
	}

}