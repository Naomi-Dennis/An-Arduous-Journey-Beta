package 
{
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import flash.text.TextField;
	import items.PrizeBox;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class LogoPrizeBox extends Sprite
	{
		
		public function LogoPrizeBox() 
		{
			addChild(new PrizeBox());
			var tf:TextField = DrawText("A game by Naomi J Dennis"); 
			tf.alpha = 0.5; 
			tf.x = 32;
			tf.y = 3
			addChild(tf);
		}
		
	}

}