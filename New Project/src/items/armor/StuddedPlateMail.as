package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class StuddedPlateMail extends Item
	{
		
		public function StuddedPlateMail() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Studded Plate Mail", 0, 40, "Plate armor with studs. ", "armor", true);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}