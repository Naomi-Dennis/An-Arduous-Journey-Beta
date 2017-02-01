package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BlessedBlade extends Item
	{
		[Embed(source = "../pics/blessed_blade MV.png")]
		private var mv:Class; 
		[Embed(source = "../pics/blessed_blade.png")]
		private var img:Class; 
		public function BlessedBlade() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Blessed Blade", 0, 25, "The Blessed Blade of the seventh.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}