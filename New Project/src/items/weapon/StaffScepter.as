package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class StaffScepter extends Item
	{
		[Embed(source = "../pics/sceptreStaff.png")]
		private var mv:Class;
		[Embed(source = "../pics/sceptreStaffIco.png")]
		private var img:Class; 
		public function StaffScepter() 
		{
			super("Scepter Staff", 0, 1, "The staff of Scepter.", "weapon", true);
			setEnchancements("wisdom", 30);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}