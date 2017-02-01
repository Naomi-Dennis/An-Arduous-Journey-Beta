package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HatStraw  extends Item
	{
		[Embed(source = "../clothing_hair/straw.png")]
		private var mv:Class; 
		[Embed(source="../clothing_hair/straw_hat_icon.png")]
		private var ico:Class; 
		public function HatStraw() 
		{
			super("Straw Hat", 0, 0, "A straw hat.", "hair", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(ico));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}