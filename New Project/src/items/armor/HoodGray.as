package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HoodGray extends Item
	{
		[Embed(source = "../clothing_hair/hood_green2.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/hood_gray_ico.png")]
		private var icoClass:Class; 
		public function HoodGray() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Gray Hood", 0, 1, "A gray hood.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}