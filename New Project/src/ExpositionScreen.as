package 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.StandardTextFormat;
	import Assets.Utility.VerticalScrollBar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ExpositionScreen extends Sprite
	{
		[Embed(source="pics/backgrounds/dark background.png")]
		private var bkgrndClass:Class;
		private var bkgrnd:Sprite = new Sprite();
		private var textField:TextField = DrawTextArea(450, 275, 20, "center");
		private var timer:Timer = new Timer(1500);
		protected var continueBtn:Sprite = DrawButton("Continue", 24); 
		private var scrollBar:VerticalScrollBar = new VerticalScrollBar(0xffffff, 0xa2a2a2, "large");
		public function ExpositionScreen(showProgressBar:Boolean=true) 
		{
			bkgrnd = ConvertEmbedToSprite(bkgrndClass); 
			bkgrnd.y = 40; 
			bkgrnd.width = 540;
			bkgrnd.height = 450;
			textField.y = 60;
			textField.defaultTextFormat = StandardTextFormat(18, "center", "unzialish");
			CenterObjRelTo(textField, bkgrnd);
			CenterObjRelTo(continueBtn, bkgrnd); 
			PlaceObjBelowRel(continueBtn, textField, 40); 
			addChild(bkgrnd); 
			addChild(textField); 
			//addChild(continueBtn);
			
			scrollBar.setPercentage(-1);
			scrollBar.x = 16; 
			scrollBar.y = 540/2 - scrollBar.height / 2; 
			timer.addEventListener(TimerEvent.TIMER, flowText);
			
			//continueBtn.addEventListener(MouseEvent.CLICK, removeScreen); 
			if (showProgressBar){
				addChild(scrollBar);
				scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, activateScrollBar);
				addEventListener(Event.ENTER_FRAME, passiveScrollBar);
			}
			
			
		}
		private function passiveScrollBar(e:Event):void{
			scrollBar.setPercentage( ((textField.scrollV / textField.maxScrollV) - 1) );
		}
		private function activateScrollBar(e:MouseEvent):void{
			removeEventListener(Event.ENTER_FRAME, passiveScrollBar);
			addEventListener(Event.ENTER_FRAME, coordinateScroll);
			timer.stop();
		}
		private function coordinateScroll(e:Event):void{
			
			textField.scrollV = textField.maxScrollV * (1 - (scrollBar.ratio * -1));
		}
		private function skipIntro(e:MouseEvent):void{
			textField.scrollV = textField.bottomScrollV; 
			timer.stop(); 
		}
		protected function removeScreen(e:Event):void{
			timer.stop();
			textField.scrollV = 1; 
			RemoveSprite(this); 
		}
		public function setText(txt:String):void{
			textField.text = txt; 
		}
		/**
		 * CHANGE THE TIMER EVENT IT REFERENCES BEFORE USING!
		 */
		public function runText():void{
			textField.scrollV = 1; 
			timer.start();
		}
		
		private function flowText(e:TimerEvent):void{
			textField.scrollV += 1;
			if (textField.scrollV == textField.bottomScrollV){
				e.currentTarget.reset();
			}
		}
		
		
	}

}
