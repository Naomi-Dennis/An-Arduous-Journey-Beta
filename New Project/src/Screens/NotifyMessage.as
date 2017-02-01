package Screens 
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent; 
	import flash.text.TextField;
	public class NotifyMessage extends Sprite
	{
		public var aBtns:Array = []; 
		private var txtField:TextField; 
		public function NotifyMessage(msg:String) 
		{
			//choices = Object{btn:Value, handle:Foo};
			txtField = DrawTextArea(400, 200, 24, "center"); 
			txtField.y = 50; 
			txtField.x = 540 / 2 - txtField.width / 2; 
			txtField.text = msg; 
			addChild( DrawSquare(540, 540) ); 
			var currentObj:Object = { }; 
			var foo:Function = null; 
			var prevY:int = 350; 
			var continueBtn:Sprite = DrawButton("Close", 24); 
			continueBtn.x = 540 / 2 - continueBtn.width / 2; 
			continueBtn.y = 490; 
			addChild(continueBtn);
			addChild(txtField);
			continueBtn.addEventListener(MouseEvent.CLICK, removeWin);
		}
		private function removeWin(e:MouseEvent):void{
			RemoveSprite(this); 
		}
		
	}

}