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
	public class HealthPotion extends Item
	{
		[Embed(source = "../pics/potions/ruby.png")]
		private var imgClass:Class; 
		public function HealthPotion() 
		{
			super("Health Potion", 32, 0.30, "A small vial of red liquid.", "Item", true);
			specialFoo = drinkMe; 
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			setIcon(ico); 
		}
		private function drinkMe(mob:Mob):void {
			var stats:Object = mob.getStatus();
			var pow:int = (mob.getMaxHp() * 0.30) 
			mob.changeHp(pow); 
			mob.getBattlePiece().showHeal(pow); 
		}
		
	}

}