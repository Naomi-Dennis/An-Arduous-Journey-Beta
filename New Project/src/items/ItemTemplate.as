package items 
{
	import Assets.Item;
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class ItemTemplate extends Item
	{
		
		public function ItemTemplate() 
		{
			super("ItemTemplate", VALUE, POWER, "DESCRIPTION", "Item", true);
			specialFoo = drinkMe; 
			var ico:Sprite = new Sprite();
			ico.addChild( DrawText("POT") );
			setIcon(ico); 
		}
		private function drinkMe(mob:Mob):void {
			
		}
		
	}

}