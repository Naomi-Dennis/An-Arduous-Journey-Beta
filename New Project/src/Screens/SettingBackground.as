package Screens
{
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.StandardTextFormat;
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class SettingBackground extends Sprite
	{
		protected var bkgrndSpr:Sprite = new Sprite();
		protected var tfMsg:TextField = DrawTextArea(300, 300, 20, "center");
		protected var overshadow:Sprite = DrawSquare(540, 540);
		protected var continueBtn:Sprite = DrawButton("Continue", 30);
		protected var restBtn:Sprite = DrawButton("Rest", 15);
		protected var callback:Function = null;
		public var restEncounter:Function = null;
		
		public function SettingBackground(bkgrnd:Class, msg:String, _callback:Function, finalEv:Boolean = false)
		{
			
			if (finalEv)
			{
				continueBtn = DrawButton("Finish Mission", 30);
				tfMsg.defaultTextFormat = StandardTextFormat(26, "center", "Monotype Corsiva");
				
			}
			callback = _callback;
			overshadow.alpha = 0.7;
			
			tfMsg.text = msg;
			tfMsg.x = Math.abs(540 / 2 - tfMsg.width / 2);
			tfMsg.y = Math.abs(540 / 2 - tfMsg.height / 2);
			bkgrndSpr = ConvertEmbedToSprite(bkgrnd);
			bkgrndSpr.width = 540;
			bkgrndSpr.height = 500;
			bkgrndSpr.y = 20;
			continueBtn.x = Math.abs(540 / 2 - continueBtn.width / 2);
			PlaceObjBelowRel(continueBtn, tfMsg);
			restBtn.x = Math.abs(540 / 2 - restBtn.width / 2);
			PlaceObjBelowRel(restBtn, continueBtn);
			addChild(bkgrndSpr);
			addChild(overshadow);
			addChild(tfMsg);
			addChild(continueBtn);
			
			continueBtn.addEventListener(MouseEvent.CLICK, callCallback);
			restBtn.addEventListener(MouseEvent.CLICK, rest);
		}
		
		protected function disableContinueBtn():void
		{
			continueBtn.removeEventListener(MouseEvent.CLICK, callCallback);
		}
		
		public function callCallback(e:MouseEvent):void
		{
			callback();
		}
		
		public function rest(e:MouseEvent):void
		{
			var rand:int = RandomNumber(100, 50);
			if (restEncounter == null || (restEncounter != null && rand >= 50))
			{
				Main.army.resetPersonnel();
				tfMsg.text = "You take a rest and feel prepared to fight again!"
				RemoveSprite(restBtn);
			}
			else
			{
				restEncounter();
			}
		}
	
	}

}