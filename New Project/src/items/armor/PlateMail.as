package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class PlateMail extends Item
	{
		[Embed(source = "../pics/plate_mail1.png")]
		private var img:Class;
		[Embed(source = "../pics/plate_mailMV.png")]
		private var mv:Class; 
		public function PlateMail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Plate Mail", 0, 35, "Ordinary plate mail.", "armor", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
			tgt.equip(new SteelLeggings())
		}
		
	}

}