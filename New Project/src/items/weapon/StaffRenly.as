package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class StaffRenly extends Item
	{
		[Embed(source = "../pics/renlyStaff.png")]
		private var mv:Class;
		[Embed(source = "../pics/renlyStaffIco.png")]
		private var img:Class; 
		public function StaffRenly() 
		{
			super("Renly Staff", 0, 1, "The staff of Renly.", "weapon", true);
			setEnchancements("wisdom", 40);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}