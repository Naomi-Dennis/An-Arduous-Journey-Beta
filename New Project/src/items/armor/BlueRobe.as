package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
		import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class BlueRobe extends Item
	{
		[Embed(source = "../clothing_hair/robe_blue.png")]
		private var mv:Class;
		public function BlueRobe() 
		{
			
			super("Blue Robe", 0, 1, "A wizard's blue robe.", "armor", true);
			setEnchancements("defense", 10);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}