package items
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class StrengthBook extends Item
	{
		[Embed(source="../pics/potions/strength book.png")]
		private var img:Class;
		
		public function StrengthBook()
		{
			super("Strength Book", 500, 2, "Read this book to gain (2) strength.", "Item", true);
			setIcon(ConvertEmbedToSprite(img));
			specialFoo = readMe;
		}
		
		private function readMe(tgt:Mob):void
		{
			tgt.raiseParticularStatByN("strength", this.getPower());
		}
	
	}

}