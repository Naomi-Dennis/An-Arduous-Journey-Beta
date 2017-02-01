package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BearSkin extends Item
	{
		[Embed(source="../pics/animal_skin1.png")]
		private var img:Class; 
		[Embed(source = "../pics/animal_skin.png")]
		private var mv:Class;
		public function BearSkin() 
		{
			var ico:Sprite = ConvertEmbedToSprite(img); 
			
			super("Bear Skin", 0, 3, "Armor made from bear skin.", "armor", true);
			setIcon(ico);
			setMobVersion(mv);
			setEnchancements("defense", 3);
			setEnchancements("strength", 3); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}