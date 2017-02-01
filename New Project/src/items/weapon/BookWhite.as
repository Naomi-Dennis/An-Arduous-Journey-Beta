package items.weapon 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class BookWhite extends Item
	{
		[Embed(source = "../clothing_hair/book_white.png")]
		private var mv:Class;
		[Embed(source = "../clothing_hair/book_white_ico.png")]
		private var icon_img:Class; 
		public function BookWhite() 
		{
			super("White Book", 0, 1, "A wizard's amplification spellbook.", "weapon", true);
			setEnchancements("wisdom", 25);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icon_img));
		}
		public function equipMe(tgt:Mob):void {
			tgt.equip(this); 
		}
		
	}

}