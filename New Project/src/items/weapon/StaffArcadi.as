package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class StaffArcadi extends Item
	{
		[Embed(source = "../pics/arcadiStaff.png")]
		private var mv:Class;
		[Embed(source = "../pics/arcadiStaffIco.png")]
		private var img:Class; 
		public function StaffArcadi() 
		{
			super("Arcadi Staff", 0, 1, "The staff of Arcadi.", "weapon", true);
			setEnchancements("wisdom", 20);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}