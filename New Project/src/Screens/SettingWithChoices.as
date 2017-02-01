package Screens 
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import Assets.Utility.CenterObjRelTo;
	import flash.events.MouseEvent; 
	public class SettingWithChoices extends SettingBackground
	{
		public var aBtns:Array = []; 
		public function SettingWithChoices(bkgrnd:Class, msg:String, choices:Array) 
		{
			//choices = Object{btn:Value, handle:Foo}; 
			super(bkgrnd, msg, null); 
			var currentObj:Object = { }; 
			var foo:Function = null; 
			var prevY:int = 350; 
			removeChild(continueBtn);
			for (var i:* in choices) {
				currentObj = choices[i]; 
				foo = currentObj.handle; 
				currentObj.btn.addEventListener(MouseEvent.CLICK, foo); 
				CenterObjRelTo(currentObj.btn, overshadow); 
				currentObj.btn.y = prevY; 
				prevY += currentObj.btn.height + 10; 
				aBtns.push(currentObj.btn); 
				addChild(currentObj.btn); 
			}
		}
		
		
	}

}