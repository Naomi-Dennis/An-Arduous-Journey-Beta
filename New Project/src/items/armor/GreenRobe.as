package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
		import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class GreenRobe extends Item
	{
		[Embed(source = "../clothing_hair/robe_green.png")]
		private var mv:Class; 
		public function GreenRobe() 
		{
			
			super("Green Robe", 0, 1, "A green wizard's robe.", "armor", true);
			setEnchancements("defense", 20);
			setEnchancements("wisdom", 15); 
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}