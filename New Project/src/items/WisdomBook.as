package items
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class WisdomBook extends Item
	{
		
		[Embed(source="../pics/potions/wisdom book.png")]
		private var img:Class;
		
		public function WisdomBook()
		{
			super("Wisdom Book", 500, 2, "Read this book to gain (2) more wisdom.", "Item", true);
			setIcon(ConvertEmbedToSprite(img));
			specialFoo = readMe;
		}
		
		private function readMe(tgt:Mob):void
		{
			tgt.raiseParticularStatByN("wisdom", this.getPower());
		}
	}

}