package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Crossbow extends Item
	{
		[Embed(source = "../pics/crossbowMV.png")]
		private var mv:Class; 
		[Embed(source = "../pics/crossbow1.png")]
		private var img:Class; 
		public function Crossbow() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Crossbow", 0, 1, "A quickshooting crossbow.", "weapon", true);
			
			setEnchancements("dexterity", 12);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}