package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class StuddedMorningstar extends Item
	{
		[Embed(source = "../pics/studded morningstar mv.png")]
		private var mv:Class; 
		[Embed(source = "../pics/studded morningstar.png")]
		private var img:Class; 
		public function StuddedMorningstar() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Studded Morningstar", 0, 40, "A studded mace. I wouldn't want to get hit with this.", "weapon", true);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}