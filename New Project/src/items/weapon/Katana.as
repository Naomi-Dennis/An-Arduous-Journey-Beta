package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Katana extends Item
	{
		[Embed(source = "../pics/katana mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/katana1.png")]
		private var img:Class; 
		public function Katana() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Katana", 0, 7, "A slim, double sided, katana.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
			
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}