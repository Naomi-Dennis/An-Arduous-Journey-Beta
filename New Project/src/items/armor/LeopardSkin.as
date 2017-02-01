package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class LeopardSkin extends Item
	{
		[Embed(source = "../pics/leopardskinIco.png")]
		private var img:Class; 
		[Embed(source = "../pics/animal_skin.png")]
		private var mv:Class; 
		public function LeopardSkin() 
		{
			var ico:Sprite = ConvertEmbedToSprite(img); 
			super("Leopard Skin", 0, 3, "Armor made from leapord skin.", "armor", true);
			setMobVersion(mv);
			setIcon(ico);
			setEnchancements("defense", 3);
			setEnchancements("dexterity", 3); 
			
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}