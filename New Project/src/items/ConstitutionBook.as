package items
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class ConstitutionBook extends Item
	{
		[Embed(source="../pics/potions/consitution book.png")]
		private var img:Class;
		
		public function ConstitutionBook()
		{
			super("Constitution Book", 500, 2, "Read this book to gain (2) constitution.", "Item", true);
			setIcon(ConvertEmbedToSprite(img));
			specialFoo = readMe;
		}
		
		private function readMe(tgt:Mob):void
		{
			tgt.raiseParticularStatByN("constitution", this.getPower());
		}
	}

}