package items.armor 
{
	import Assets.Item;
	/**
	 * ...
	 * @author lk
	 */
		import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class BrownRobe extends Item
	{
		[Embed(source = "../clothing_hair/robe_brown2.png")]
		private var mv:Class; 
		public function BrownRobe() 
		{
			super("Brown Robe", 0, 0, "A brown wizard's robe.", "armor", true);
			setEnchancements("defense", 10);
			setEnchancements("wisdom", 5); 
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}