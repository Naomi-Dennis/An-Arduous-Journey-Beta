package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HoodOrange extends Item
	{
		[Embed(source = "../clothing_hair/hood_orange.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/hood_orange_ico.png")]
		private var icoClass:Class; 
		public function HoodOrange() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Orange Hood", 0, 1, "An orange hood.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}