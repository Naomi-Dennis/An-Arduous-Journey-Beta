package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class Staff extends Item
	{
		[Embed(source = "../pics/staff02.png")]
		private var img:Class
		[Embed(source="../pics/staff_fork.png")]
		private var mv:Class; 
		public function Staff() 
		{
			super("Staff", 0, 1, "A basic magic staff.", "weapon", true);
			setEnchancements("wisdom", 5);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}