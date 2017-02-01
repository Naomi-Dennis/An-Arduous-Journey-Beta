package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class ElvenScalemail extends Item
	{
		[Embed(source = "../pics/eleven_scalemailMV.png")]
		private var mv:Class;
		[Embed(source = "../pics/elven_scalemail.png")]
		private var img:Class; 
		public function ElvenScalemail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Eleven Scalemail", 0, 45, "Chainmail created with the look of a snake forged by the elves.", "armor", true);
			setEnchancements("dexterity", 3);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
			tgt.equip(new IronLeggings());
		}
		
	}

}