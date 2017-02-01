package items 
{
	import Assets.Item;
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class WisdomPotion extends Item
	{
		[Embed(source = "../pics/potions/orange.png")]
		private var imgClass:Class; 
		public function WisdomPotion() 
		{
			super("Wisdom Potion", 0, 0.30, "A concotion that will increase your wisdom by 30% for 3 turns.", "Item", true);
			specialFoo = drinkMe; 
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			setIcon(ico); 
		}
		private function drinkMe(mob:Mob):void {
			var stats:Object = mob.getStatus();
			var pow:int = (stats.wisdom * this.getPower()) + stats.wisdom;
			mob.tempStatusChange("wisdom", pow, 3);			
		}
		
	}

}