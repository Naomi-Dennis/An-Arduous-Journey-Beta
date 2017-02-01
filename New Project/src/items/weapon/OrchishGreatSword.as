package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class OrchishGreatSword extends Item
	{
		[Embed(source = "../pics/orcish great sword mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/orcish great sword.png")]
		private var img:Class; 
		public function OrchishGreatSword() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Orchish Great Sword", 0, 35, "A heavy, giant sword forged by the orcs.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}