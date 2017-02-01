package Screens 
{
	import flash.display.Sprite;
	import Screens.ScreenBackground;
	import Assets.Utility.DrawText;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	/**
	 * ...
	 * @author ...
	 */
	public class TutorialMessage extends Sprite
	{
		
		public function TutorialMessage(msg:String) 
		{
			var tfMsg:TextField = DrawText(msg, 15, "center", "unzialish");
			var bkgrnd:Sprite = new ScreenBackground({width:tfMsg.width, height:tfMsg.height}, 0xffffff, 0xffffff, false); 
			tfMsg.x = tfMsg.width / 2 - bkgrnd.width / 2;
			tfMsg.y += 1;
			tfMsg.x += 1; 
			addChild(bkgrnd);
			addChild(tfMsg); 
		}
		
	}

}