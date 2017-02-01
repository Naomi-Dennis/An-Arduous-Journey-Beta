package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
		import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class PurpleRobe extends Item
	{
		[Embed(source = "../clothing_hair/robe_purple.png")]
		private var mv:Class; 
		public function PurpleRobe() 
		{
			super("Purple Robe", 0, 1, "A purple wizard's robe.", "armor", true);
			setEnchancements("defense", 40);
			setEnchancements("wisdom", 35); 
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}