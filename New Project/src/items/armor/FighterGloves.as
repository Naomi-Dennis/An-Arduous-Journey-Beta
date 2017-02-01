package items.armor 
{
	import flash.display.Sprite;
	import Assets.Item;
	/**
	 * ...
	 * @author lk
	 */
	public class FighterGloves extends Item
	{
		[Embed(source = "../pics/red fighter gloves mv.png")]
		private var mv:Class; 
		public function FighterGloves() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Fighter Gloves", 0, 7, "A pair of figting gloves.", "weapon", true);
			setMobVersion(mv);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}