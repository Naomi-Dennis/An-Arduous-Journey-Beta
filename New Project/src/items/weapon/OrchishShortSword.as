package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class OrchishShortSword extends Item
	{
		[Embed(source = "../pics/orchish short sword mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/orchish short sword.png")]
		private var img:Class; 
		public function OrchishShortSword() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Orchish Short Sword", 0, 14, "A heavy, short sword; forged by the orcs.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}