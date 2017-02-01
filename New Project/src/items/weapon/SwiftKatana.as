package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class SwiftKatana extends Item
	{
		[Embed(source = "../pics/swift katana mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/swift katana.png")]
		private var img:Class; 
		public function SwiftKatana() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Switft Katana", 0, 15, "A lightweight katana.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}