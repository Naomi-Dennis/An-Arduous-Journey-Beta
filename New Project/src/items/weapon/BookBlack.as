package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class BookBlack extends Item
	{
		[Embed(source = "../clothing_hair/book_black.png")]
		private var mv:Class;
		[Embed(source = "../clothing_hair/book_black_ico.png")]
		private var img_icon:Class; 
		public function BookBlack() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("Black Book", 0, 1, "A wizard's amplification spellbook.", "weapon", true);
			setEnchancements("wisdom", 10);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img_icon));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}