package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Blowgun extends Item
	{
		[Embed(source = "../pics/blowgun.png")]
		private var img:Class; 
		[Embed(source = "../pics/blowgunMV.png")]
		private var mv:Class; 
		public function Blowgun() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Blowgun", 0, 1, "A gun that is blown with your mouth.", "weapon", true);
			setEnchancements("dexterity", 5);
			setIcon(ConvertEmbedToSprite(img));
			setMobVersion(mv); 
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}