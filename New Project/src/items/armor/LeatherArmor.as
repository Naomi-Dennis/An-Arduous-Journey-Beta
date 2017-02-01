package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class LeatherArmor extends Item
	{
		[Embed(source = "../pics/leather_armour1.png")]
		private var img:Class;
		[Embed(source = "../pics/leather_armourMV.png")]
		private var mv:Class; 
		public function LeatherArmor() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Leather Armor", 0, 10, "Simple leather armor.", "armor", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}