package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class OrchishRingmail extends Item
	{
		[Embed(source = "../pics/orchich ringmail mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/orchishRingmail.png")]
		private var img:Class; 
		public function OrchishRingmail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Orchish Ringmail", 0, 60, "Strong chainmail created by the orcs.", "armor", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
			tgt.equip(new IronLeggings());
		}
		
	}

}