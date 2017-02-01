package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class GoldenBuckler extends Item
	{
		[Embed(source = "../pics/golden buckler.png")]
		private var img:Class; 
		[Embed(source = "../pics/golden bucklermv.png")]
		private var mv:Class; 
		public function GoldenBuckler() 
		{
			var ico:Sprite = new Sprite();
			super("Golden Buckler", 0, 15, "A wooden buckler with a thick outer gold plate.", "armor", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}