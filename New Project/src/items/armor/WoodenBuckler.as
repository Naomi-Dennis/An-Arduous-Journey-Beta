package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class WoodenBuckler extends Item
	{
		[Embed(source = "../pics/wooden buckler.png")]
		private var img:Class; 
		[Embed(source = "../pics/wooden_bucklerMV.png")]
		private var mv:Class; 
		public function WoodenBuckler() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Wooden Buckler", 0, 5, "A simple wooden buckler.", "shield", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}