package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class BrownPants extends Item
	{
		[Embed(source = "../pics/pants_brown mv.png")]
		private var mv:Class; 
		public function BrownPants() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Brown Pants", 0, 1, "A pair of brown pants.", "leggings", true);
			setIcon(ConvertEmbedToSprite(mv));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}