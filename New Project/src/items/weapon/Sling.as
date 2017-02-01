package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Sling extends Item
	{
		[Embed(source = "../pics/sling1.png")]
		private var img:Class; 
		[Embed(source = "../pics/slingMV.png")]
		private var mv:Class; 
		public function Sling() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Sling", 0, 2, "A basic sling", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}