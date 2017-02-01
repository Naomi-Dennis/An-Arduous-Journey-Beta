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
	public class HorizontalScrollBar extends Sprite
	{
		private var scrubber:Sprite = new Sprite(); 
		private var bar:Sprite = new Sprite(); 
		public var ratio:Number = 0; // scrubber pos / bar pos 
		public function HorizontalScrollBar(scrubberColor:Number=0xffffff, barColor:Number=0xa2a2a2, size:String="medium") 
		{
			var scrubberHeight:Number;
			var barWidth:Number; 
			if (size == "large") {
				scrubberHeight = 20;
				barWidth = 100;
			}
			else if (size == "medium") {
				scrubberHeight = 13; 
				barWidth = 75; 
			}
			else if (size == "small") {
				scrubberHeight = 13;
				barWidth = 50; 
			}
			
			scrubber = DrawSquare(5, scrubberHeight, scrubberColor); 
			bar = DrawSquare(barWidth, 3, barColor); 
			
			addChild(bar); 
			addChild(scrubber);
			scrubber.y = bar.height / 2 - scrubber.height / 2 + 0.1;
			scrubber.addEventListener(MouseEvent.MOUSE_DOWN, dragScrubber);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function updateRatio(e:Event):void {
			ratio = ((scrubber.x + scrubber.width) / bar.width) - 1.0;
		}
		private function init(e:Event):void {
			this.parent.addEventListener(MouseEvent.MOUSE_UP, stopDraggingScrubber); 
			e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, init); 
			addEventListener(Event.ENTER_FRAME, updateRatio);
		}
		private function dragScrubber(e:MouseEvent):void {
			var bounds:Rectangle = new Rectangle(0, -scrubber.height/2 + 1, bar.width - scrubber.width, 0.1); 
			scrubber.startDrag(false, bounds); 
		
		}
		private function stopDraggingScrubber(e:MouseEvent):void {
			scrubber.stopDrag(); 
		}
		
	}

}