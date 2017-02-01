package items.weapon 
{
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class WeaponTemplate extends Item
	{
		
		public function WeaponTemplate() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("WEAPON_NAME", VALUE, POWER, "DESCRIPTION", "weapon", true);
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}