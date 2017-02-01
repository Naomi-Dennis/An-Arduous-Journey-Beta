package Assets.Utility 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class CheckBox extends Sprite
	{
		private var bkgrnd:Sprite = DrawSquare(22, 22, 0x333333); 
		private var checkMark:TextField = DrawText("X", 20); 
		public var checked:Boolean = true;
		public function CheckBox(on:Boolean=true) 
		{
			checked = on; 
			(checked) ? checkMark.alpha = 0.8 : checkMark.alpha = 0; 
			addChild(bkgrnd); 
			addChild(checkMark);
			addEventListener(MouseEvent.CLICK, check);
			CenterObjRelTo(checkMark, bkgrnd); 
			checkMark.y -= 3;
		}
		private function check(e:MouseEvent):void {
			if(!checked){
				checkMark.alpha = 0.8; 
				checked = true; 
			}
			else {
				checkMark.alpha = 0;
				checked = false; 
			}
		}
		
	}

}