package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Dagger extends Item
	{
		[Embed(source = "../pics/dagger.png")]
		private var img:Class;
		[Embed(source = "../pics/dagger MV.png")]
		private var mv:Class; 
		public function Dagger() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Dagger", 0, 4, "An iron dagger.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}