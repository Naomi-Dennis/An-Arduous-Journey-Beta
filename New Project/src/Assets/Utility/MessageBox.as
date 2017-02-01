package Assets.Utility 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class MessageBox extends Sprite
	{
		private var bkgrnd:Sprite = new Sprite();
		private var ok:Sprite = DrawButton("Ok", 20);
		private var yes:Sprite = DrawButton("Yes");
		private var no:Sprite = DrawButton("No"); 
		private var customButtons:Array = [];
		private var tfMsg:TextField = new TextField(); 
		public function MessageBox(size:Object, text:String, mode:String = "ok", handles:Object=null ) 
		{
			bkgrnd = DrawSquare(size.width, size.height, 0x777777); 
			DrawBorder(bkgrnd, 5, 0x444444); 
			tfMsg.y = 10;
			tfMsg.x = 10; 
			tfMsg = DrawTextArea(bkgrnd.width - 10, bkgrnd.height - 10, 20, "center"); 
			tfMsg.text = text; 
			addChild(bkgrnd); 
			addChild(tfMsg);
			if (mode == "ok") {
				addOkButton(handles);
			}
			else if (mode == "yes_no") {
				addYesNoButton(handles);
			}
		
		}
		private function addOkButton(handles:Object=null):void {
			CenterObjRelTo(ok, bkgrnd);
			ok.y = bkgrnd.height - ok.height - 10; 
			ok.addEventListener(MouseEvent.CLICK, okHandle(handles)); 
			addChild(ok);
		}
		private function addYesNoButton(handles:Object=null):void {
			yes.x = bkgrnd.width / 4 - yes.width;
			yes.y = bkgrnd.height - yes.height - 10; 
			
			no.x = yes.width + yes.x + 100; 
			no.y = yes.y; 
			
			addChild(yes);
			addChild(no);
			
			yes.addEventListener(MouseEvent.CLICK, yesHandle(handles));
			no.addEventListener(MouseEvent.CLICK, noHandle(handles));
		}
		private function okHandle(handles:Object = null):Function {
			var spr:Sprite = this;
			return function(e:MouseEvent):void{
				(handles != null) ? handles.ok() : null;
				RemoveSprite(spr); 
			}
		}
		private function yesHandle(handles:Object = null):Function {
			var spr:Sprite = this;
			return function(e:MouseEvent):void {
				(handles != null) ? handles.yes() : null;
				RemoveSprite(spr); 
			}
		}
		
		private function noHandle(handles:Object = null):Function {
			var spr:Sprite = this;
			return function(e:MouseEvent):void {
				(handles != null) ? handles.no() : null;
				RemoveSprite(spr); 
			}
		}
	
		
	}

}