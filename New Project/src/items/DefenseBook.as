package items
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class DefenseBook extends Item
	{
		[Embed(source="../pics/potions/defense book.png")]
		private var img:Class;
		
		public function DefenseBook()
		{
			super("Defense Book", 500, 2, "Read this book to gain (2) defense.", "Item", true);
			setIcon(ConvertEmbedToSprite(img));
			specialFoo = readMe;
		}
		
		private function readMe(tgt:Mob):void
		{
			tgt.raiseParticularStatByN("defense", this.getPower());
		}
	
	}

}