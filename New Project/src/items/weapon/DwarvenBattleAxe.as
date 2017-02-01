package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class DwarvenBattleAxe extends Item
	{
		[Embed(source = "../pics/dwarven battle axe mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/dwarven battle axe.png")]
		private var img:Class; 
		public function DwarvenBattleAxe() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Dwarven Battle Axe", 0, 35, "A near perfect battle axe, forged by dwarves.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}