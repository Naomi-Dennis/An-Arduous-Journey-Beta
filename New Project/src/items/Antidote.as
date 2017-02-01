package items 
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Antidote extends Item
	{
		[Embed(source = "../pics/potions/emerald.png")]
		private var imgClass:Class; 
		public function Antidote() 
		{
			super("Antidote", 0, 0, "A concotion that will instantly cure poison!", "Item", true);
			specialFoo = drinkMe; 
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			setIcon(ico); 
		}
		private function drinkMe(mob:Mob):void {
			mob.processAfflictions(0, 0, "poison");
		}
		
	}

}