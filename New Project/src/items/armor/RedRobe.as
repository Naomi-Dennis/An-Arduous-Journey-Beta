package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
		import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class RedRobe extends Item
	{
		[Embed(source = "../clothing_hair/robe_red.png")]
		private var mv:Class; 
		public function RedRobe() 
		{
			
			super("Red Robe", 0, 1, "A red wizard's robe.", "armor", true);
			setEnchancements("defense", 30);
			setEnchancements("wisdom", 25); 
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(mv));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}