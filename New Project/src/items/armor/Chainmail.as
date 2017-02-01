package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Chainmail extends Item
	{
		[Embed(source = "../pics/chaimail.png")]
		private var img:Class;
		[Embed(source = "../pics/chainmailMV.png")]
		private var mv:Class; 
		public function Chainmail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Chainmail", 0, 20, "Ordinary chainmail.", "armor", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
			
		}
		
	}

}