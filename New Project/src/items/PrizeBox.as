package items 
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class PrizeBox extends Sprite
	{
		[Embed(source = "../pics/misc_orb.png")]
		private var state1:Class; 
		[Embed(source = "../pics/misc_orb2.png")]
		private var state2:Class; 
		private var icoA:Sprite = new Sprite();
		private var icoB:Sprite = new Sprite();
		private var obj:*;
		public function PrizeBox() 
		{
			addEventListener(Event.ENTER_FRAME, animate);
			icoA = ConvertEmbedToSprite(state1);
			icoB = ConvertEmbedToSprite(state2);
			addChild(icoA);
			addChild(icoB);
			icoB.alpha = 0; 
		}
		public function setObj(_obj:*):void {
			obj = obj;
		}
		public function getObject():*{
			return obj;
		}
		private function animate(e:Event):void {
			
			if (getTimer() % 20 == 0) {
				icoB.alpha = 0;
				icoA.alpha = 1; 
			}
			else if (getTimer() % 20 != 0) {
				icoB.alpha = 1; 
				icoA.alpha = 0;
			}
		}
		
	}

}