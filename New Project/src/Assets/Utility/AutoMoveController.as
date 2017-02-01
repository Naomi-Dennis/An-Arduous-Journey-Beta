package Assets.Utility
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class AutoMoveController
	{
		private var spr:Sprite = null;
		private var spd:int = 0;
		private var changeDirDelay:Number = 0;
		private var moveTimer:Timer = new Timer(1000);
		
		public var travelLeft:Boolean = false;
		public var travelRight:Boolean = false
		public var travelDown:Boolean = false;
		public var travelUp:Boolean = false;
		
		private var lastDir:String = "";
		private var isMoving:Boolean = false;
		
		public function AutoMoveController(_spr:*, _spd:int = 1, _changeDirDelay:Number = 1000)
		{
			spr = _spr;
			spd = _spd;
			changeDirDelay = _changeDirDelay;
			moveTimer.delay = changeDirDelay;
			moveTimer.addEventListener(TimerEvent.TIMER, movingHandle);
		}
		
		public function beginMove():void
		{
			isMoving = true;
			moveTimer.start();
			spr.addEventListener(Event.ENTER_FRAME, checkDirection);
			genDirection();
		}
		
		public function stopMoving():void
		{
			isMoving = false;
			moveTimer.stop();
			if (spr.hasEventListener(Event.ENTER_FRAME))
			{
				spr.addEventListener(Event.ENTER_FRAME, checkDirection);
			}
		}
		
		private function checkDirection(e:Event):void
		{
			if (isMoving)
			{
				if (travelLeft)
				{
					spr.x -= spd;
				}
				else if (travelRight)
				{
					spr.x += spd;
				}
				else if (travelDown)
				{
					spr.y += spd;
				}
				else if (travelUp)
				{
					spr.y -= spd;
				}
				
				if (!travelLeft && !travelDown && !travelRight && !travelUp) {
					genDirection();
				}
			}
		}
		
		private function movingHandle(e:TimerEvent):void
		{
			genDirection();
		}
		
		private function genDirection():void
		{
			var exclude:String = "";
			var dirs:Array = ["Left", "Right", "Down", "Up"];
			if (lastDir.length > 0)
			{
				exclude = lastDir.slice(6, lastDir.length);
				
				for (var i:*in dirs)
				{
					if (dirs[i] == exclude)
					{
						(i != 0) ? dirs.splice(i, 1) : dirs.splice(0, 1);
					}
				}
			}
			var rand:int = RandomNumber(dirs.length - 1, 0);
			travelUp = false;
			travelRight = false;
			travelDown = false;
			travelLeft = false;
			var newDir:String = "travel" + dirs[rand];
			this[newDir] = true;
			lastDir = newDir;
		}
	
	}

}