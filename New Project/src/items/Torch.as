package items
{
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author lk
	 */
	public class Torch extends Sprite
	{
		[Embed(source = "../pics/Torch/torch1.png")]
		private var img1:Class;
		[Embed(source = "../pics/Torch/torch2.png")]
		private var img2:Class;
		[Embed(source = "../pics/Torch/torch3.png")]
		private var img3:Class;
		[Embed(source = "../pics/Torch/torch4.png")]
		private var img4:Class;
		private var state1:Sprite = new Sprite();
		private var state2:Sprite = new Sprite();
		private var state3:Sprite = new Sprite();
		private var state4:Sprite = new Sprite();
		
		public function Torch()
		{
			state1 = ConvertEmbedToSprite(img1);
			state2 = ConvertEmbedToSprite(img2);
			state3 = ConvertEmbedToSprite(img3);
			state4 = ConvertEmbedToSprite(img4);
			
			addChild(state1);
			var timer:Timer = new Timer(150);
			timer.addEventListener(TimerEvent.TIMER, animate);
			timer.start();
		}
		
		private function animate(e:TimerEvent):void
		{
			var i:int = e.currentTarget.currentCount as int;
			if (contains(state1)) {
				RemoveSprite(state1);
				addChild(state2);
			}
			else if (contains(state2)) {
				RemoveSprite(state2);
				addChild(state3);
			}
			else if (contains(state3)) {
				RemoveSprite(state3);
				addChild(state4);
			}
			else if (contains(state4)) {
				RemoveSprite(state4);
				addChild(state1); 
			}
		
		}
	
	}

}