package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author lk
	 */
	public class BlueCape extends Item
	{
		[Embed(source = "../pics/bluecapemv.png")]
		private var mv:Class; 
		public function BlueCape() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Blue Cape", 0, 0, "A wonderous blue cape", "cape", true);
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}