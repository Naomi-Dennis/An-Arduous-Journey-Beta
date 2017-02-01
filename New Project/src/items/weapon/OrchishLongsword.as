package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class OrchishLongsword extends Item
	{
		[Embed(source = "../pics/orcish longsword mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/orcish_long_sword.png")]
		private var img:Class; 
		public function OrchishLongsword() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Orchish Longsword", 0, 20, "A very heavy, long, giant sword forged by the orcs.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}