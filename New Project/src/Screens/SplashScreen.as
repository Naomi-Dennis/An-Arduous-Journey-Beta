package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawText;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import items.PrizeBox;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class SplashScreen extends Sprite
	{
		public var logo:PrizeBox = new PrizeBox();
		public var tfText:TextField = DrawText("Triangular Studios Presents...", 30, "center"); 
		[Embed(source = "../snd/Choir intro 1.mp3")]
		public var introSnd:Class; 
		public function SplashScreen() 
		{
			logo.width = 200;
			logo.height = 200;
			logo.x = Math.abs(540 / 2 - logo.width / 2); 
			logo.y = Math.abs(540 / 2 - logo.height / 2) - 60;
			tfText.x = Math.abs(tfText.width / 2 - 540 / 2);
			PlaceObjBelowRel(tfText, logo);
			addChild(logo);
			addChild(tfText);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void {
			Main.sndConfig.adjustSoundVolume(0.0);
			Main.sndConfig.playSound(introSnd)
			var timer:Timer = new Timer(7500);
			timer.addEventListener(TimerEvent.TIMER, fadeOut);
			timer.start();
		}
		public function fadeOut(e:TimerEvent):void {
			e.currentTarget.stop();
			var timer:Timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, fadingOut);
			timer.start(); 
		}
		public function fadingOut(e:TimerEvent):void {
			if (logo.alpha <= 0 && tfText.alpha <= 0) {
				RemoveSprite(logo);
				RemoveSprite(tfText);
				
				this.parent.addChild(new TitleScreen()); 
				this.parent.addChild(new LogoPrizeBox());
				RemoveSprite(this); 
				e.currentTarget.stop();
			}
			else {
				logo.alpha -= 0.1; 
				tfText.alpha = logo.alpha; 
			}
		}
		
	}

}