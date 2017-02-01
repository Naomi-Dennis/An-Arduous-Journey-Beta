package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Bow extends Item
	{
		[Embed(source = "../pics/bow2.png")]
		private var img:Class; 
		[Embed(source = "../pics/BowMV.png")]
		private var mv:Class; 
		public function Bow() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Bow", 0, 1,"A simple composite bow.", "weapon", true);
			setEnchancements("dexterity", 5);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img)); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}