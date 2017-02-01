package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Morningstar extends Item
	{
		[Embed(source = "../pics/morningstar1.png")]
		private var img:Class; 
		[Embed(source = "../pics/morningstar mv.png")]
		private var mv:Class; 
		public function Morningstar() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Morningstar", 0, 35, "A mace.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}