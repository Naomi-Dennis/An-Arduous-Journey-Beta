package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class StaffAnucis extends Item
	{
		[Embed(source = "../pics/anucisStaff.png")]
		private var mv:Class;
		[Embed(source = "../pics/anucisStaffIco.png")]
		private var img:Class; 
		public function StaffAnucis() 
		{
			super("Anucis Staff", 0, 1, "The staff of Anucis.", "weapon", true);
			setEnchancements("wisdom", 10);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}