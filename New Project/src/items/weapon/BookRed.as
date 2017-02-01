package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class BookRed extends Item
	{
		[Embed(source = "../clothing_hair/book_red.png")]
		private var mv:Class;
		[Embed(source="../clothing_hair/book_red_ico.png")]
		private var img_icon:Class; 
		public function BookRed() 
		{
			super("Red Book", 0, 1, "A wizard's amplification spellbook.", "weapon", true);
			setEnchancements("wisdom", 20);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(img_icon));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}