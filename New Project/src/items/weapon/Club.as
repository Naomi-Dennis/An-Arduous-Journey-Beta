package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Club extends Item
	{
		[Embed(source = "../pics/club MV.png")]
		private var mv:Class; 
		[Embed(source = "../pics/club.png")]
		private var img:Class; 
		public function Club() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Club", 0, 5, "A wooden glub.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}