package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class StuddedLeatherArmor extends Item
	{
		[Embed(source = "../pics/studded leather armorMV.png")]
		private var mv:Class; 
		[Embed(source = "../pics/studdedLeatherArmor.png")]
		private var img:Class; 
		public function StuddedLeatherArmor() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Studded Leather Armor", 0, 15, "Strong armor with metal studs.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img)); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}