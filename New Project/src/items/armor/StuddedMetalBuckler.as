package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class StuddedMetalBuckler extends Item
	{
		
		public function StuddedMetalBuckler() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Studded Metal Buckler", 0, 12, "A studden metal buckler. It's heavy.", "shield", true);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}