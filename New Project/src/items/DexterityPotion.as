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
	public class DexterityPotion extends Item
	{
		[Embed(source = "../pics/potions/pink.png")]
		private var imgClass:Class; 
		public function DexterityPotion() 
		{
			super("Dexterity Potion", 0, 0.30, "A concotion that will increase your dexterity by 30% for 3 turns.", "Item", true);
			specialFoo = drinkMe; 
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			setIcon(ico); 
		}
		private function drinkMe(mob:Mob):void {
			var stats:Object = mob.getStatus();
			var pow:int = (stats.dexterity * this.getPower()) + stats.dexterity;
			mob.tempStatusChange("dexterity", pow, 3);
		}
		
	}

}