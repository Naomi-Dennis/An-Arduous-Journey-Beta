package items.armor 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class ArmorTemplate extends Item
	{
		
		public function ArmorTemplate() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("ARMOR_NAME", VALUE, POWER, "DESCRIPTION", "armor", true);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}