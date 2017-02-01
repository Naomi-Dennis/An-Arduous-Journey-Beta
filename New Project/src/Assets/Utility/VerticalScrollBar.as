package Assets.Utility 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class VerticalScrollBar extends Sprite
	{
		public var scrubber:Sprite = new Sprite(); 
		private var bar:Sprite = new Sprite(); 
		public var ratio:Number = 0; // scrubber pos / bar pos 
		public function VerticalScrollBar(scrubberColor:Number=0xffffff, barColor:Number=0xa2a2a2, size:String="medium") 
		{
			var scrubberWidth:Number;
			var barHeight:Number; 
			if (size == "large") {
				scrubberWidth = 20;
				barHeight = 100;
			}
			else if (size == "medium") {
				scrubberWidth = 13; 
				barHeight = 75; 
			}
			else if (size == "small") {
				scrubberWidth = 8;
				barHeight = 40; 
			}
			
			scrubber = DrawSquare(scrubberWidth, 5, scrubberColor); 
			bar = DrawSquare(3, barHeight, barColor); 
			
			addChild(bar); 
			addChild(scrubber);
			scrubber.x = bar.width / 2 - scrubber.width / 2; 
			scrubber.addEventListener(MouseEvent.MOUSE_DOWN, dragScrubber);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function setBarValue(n:Number):void {
			scrubber.y = ((bar.height - scrubber.height) * n); 
		}
		private function updateRatio(e:Event):void {
			ratio = ((scrubber.y + scrubber.height) / bar.height) - 1.0;
		}
		public function setPercentage(n:Number):void{
			ratio = n;
			scrubber.y  = bar.height * (ratio + 1.0) - scrubber.height; 
		}
		private function init(e:Event):void {
			this.parent.addEventListener(MouseEvent.MOUSE_UP, stopDraggingScrubber); 
			e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, init); 
			addEventListener(Event.ENTER_FRAME, updateRatio);
		}
		private function dragScrubber(e:MouseEvent):void {
			var bounds:Rectangle = new Rectangle(-scrubber.width/2, 0, 0.2, bar.height - scrubber.height); 
			scrubber.startDrag(false, bounds); 

		}
		private function stopDraggingScrubber(e:MouseEvent):void {
			scrubber.stopDrag(); 
		}
		
	}

}