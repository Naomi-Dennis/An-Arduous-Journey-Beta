package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BattleAxe extends Item
	{
		[Embed(source = "../pics/battle axe mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/battle_axe1.png")]
		private var img:Class;
		public function BattleAxe() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Battle Axe", 0, 15, "A heavy battle axe.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}