package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HoodCyan extends Item
	{
		[Embed(source = "../clothing_hair/hood_cyan.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/hood_cyan_ico.png")]
		private var icoClass:Class;
		public function HoodCyan() 
	{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Cyan Hood", 0, 1, "A cyan hood.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}