package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class Scarf extends Item
	{
		[Embed(source = "../clothing_hair/neck_scarf.png")]
		private var mv:Class;
		[Embed(source = "../clothing_hair/neck_scarf_ico.png")]
		private var icoClass:Class; 
		public function Scarf() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Straw Hat", 0, 1, "A straw hat.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}