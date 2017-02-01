package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class TowerShield extends Item
	{
		[Embed(source = "../pics/tower shieldmv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/tower_shield.png")]
		private var img:Class; 
		public function TowerShield() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Tower Shield", 0, 25, "A large tower shield, created from a mixture of wood and metal. ", "shield", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}