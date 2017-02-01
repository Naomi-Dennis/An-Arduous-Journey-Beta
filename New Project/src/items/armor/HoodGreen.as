package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HoodGreen extends Item
	{
		[Embed(source = "../clothing_hair/hood_green2.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/hood_green2_ico.png")]
		private var icoClass:Class; 
		public function HoodGreen() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico)
			super("Green Hood", 0, 1, "A green hood.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}