package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class RougansBattleAxe extends Item
	{
		[Embed(source = "../pics/rougan battle axe mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/rougan battle axe.png")]
		private var img:Class; 
		public function RougansBattleAxe() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Rougan's Battle Axe", 0, 25, "A heavily studded battle axe. ", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}