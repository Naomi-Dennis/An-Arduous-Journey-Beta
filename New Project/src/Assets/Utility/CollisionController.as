package Assets.Utility
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	
	 */
	public class CollisionController
	{
		private var spr:Sprite = new Sprite();
		private var target:*;
		private var callback:Function = null;  
		private var collide:Boolean = false; 
		public function CollisionController(_spr:Sprite, _tgt:*, _callback:Function=null) //the target must be extended from a sprite 
		{
			spr = _spr;
			target = _tgt;
			callback = _callback; 
		}
		
		public function updateSpr(_spr:Sprite):void
		{
			spr = _spr;
		}
		
		public function updateTarget(_target:*, aObjects:Array=null):void
		{
			target = _target;
		}
		
		public function repelTarget():void
		{
			spr.addEventListener(Event.ENTER_FRAME, repelTargetHandle);
			collide = true; 
		}
		
		public function stopRepellingTarget():void
		{
			spr.removeEventListener(Event.ENTER_FRAME, repelTargetHandle);
			collide = false; 
		}
		
		private function repelTargetHandle(e:Event):void
		{
			//////// cell boundaries ///////////
			var upBumper:Number = spr.x + spr.width / 2; 
			var leftBumper:Number = spr.y + spr.height / 2;
			/////// target boundaries //////////
			var targetMidWidth:Number = target.x + target.width / 2; 
			var targetMaxWidth:Number = target.x + target.width; 
			var targetMaxHeight:Number = target.y + target.height; 
			var targetMidHeight:Number = target.y + target.height / 2; 
			/* Repel functions are from the perspective of the target */
			if (spr.hitTestObject(target)) {
				if (target.hitTestPoint(upBumper, spr.y, true) || spr.hitTestPoint(targetMidWidth, targetMaxHeight, true)) {
					target.y -= target.spd; 
				}
				else if (target.hitTestPoint(spr.x, leftBumper, true) || spr.hitTestPoint(targetMaxWidth, targetMidHeight, true)) {
					target.x -= target.spd; 
				}
				else if (target.hitTestPoint(spr.x + spr.width, leftBumper, true) || spr.hitTestPoint(target.x, targetMidHeight, true)) {
					target.x += target.spd; 
				}
				else if (target.hitTestPoint(upBumper, spr.y + spr.height, true) || spr.hitTestPoint(targetMidWidth, target.y, true)) {
					target.y += target.spd; 
				}
			/* ************************************************************ */
			
			//*************************** Call back function *******************/
				(callback != null) ? callback() : null;
			/* **************************************************************** */
			}
		
		}
		
		private function repelTargetLeft():Boolean
		{
			var targetPos:Number = target.x + target.width;
			var sprPos:Number = spr.x;
			if (target.controller.travelRight)
			{
				if (targetPos + target.spd >= sprPos)
				{
					target.controller.travelRight = false;
					target.x = (spr.x - target.width) - 1;
				}
			}
			return false;
		}
		
		private function repelTargetRight():Boolean
		{
			var targetPos:Number = target.x;
			var sprPos:Number = spr.x + spr.width;
			if (target.controller.travelLeft)
			{
				if (targetPos <= sprPos)
				{
					target.controller.travelLeft = false;
					target.x = (target.x + target.spd) + 1;
				}
			}
			return false;
		}
		
		private function repelTargetUp():Boolean
		{
			var targetPos:Number = target.y + target.height;
			var sprPos:Number = spr.y
			if ((target.y + target.height) >= spr.y - 1) {
				target.controller.travelDown = false; 
				target.y = (spr.y - target.height) - (target.spd) -  1; 
			}
			return false;
		}
		
		private function repelTargetDown():Boolean
		{
			var targetPos:Number = target.y + target.height;
			var sprPos:Number = spr.y
			if ((target.y <= spr.y + spr.height + 1)) {
				target.controller.travelUp = false; 
				target.y = spr.y + spr.height + (target.spd) + 1;
			}
			return false;
		}
	
	}

}