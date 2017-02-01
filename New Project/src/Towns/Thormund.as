package Towns 
{
	import Screens.EndingScreen;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Thormund extends subMapScreen
	{
		[Embed(source = "../pics/townIcon.png")]
		private var townIco:Class; 
		private var constructed:Boolean = false; 
		public function Thormund(title:String, bkgrndClass:Class, _levels:Array) 
		{
			super(title, bkgrndClass, _levels);
			addEventListener(Event.ADDED_TO_STAGE, giveMeButtons);
		}
		private function giveMeButtons(e:Event):void{
			if (!constructed){
				setup();
				constructed = true; 
			}
			refreshButtons();
		}
		private function setup():void{
			addButton("Into the Depths1", 42, 267);
			addButton("Into the Depths2", 163, 336);
			addButton("Into the Depths3", 308, 336);
			addButton("Into the Depths4", 373, 226);
			addButton("Into the Depths5", 448, 201);
			addButton("Into the Depths6", 508, 365);
			addButton("Challenge4", 149, 135);
			
			
			assignLevelHandles("Into the Depths1", 0);
			assignLevelHandles("Into the Depths2", 1);
			assignLevelHandles("Into the Depths3", 2);
			assignLevelHandles("Into the Depths4", 3);
			assignLevelHandles("Into the Depths5", 4);
			assignLevelHandles("Into the Depths6", 5);
			assignLevelHandles("Challenge4", 6);
		
			
			aBtns["Into the Depths1"].mission.mission.isInProgress = true; 
			
			aBtns["Into the Depths1"].mission.mission.finishCondition = finishMainMission("Into the Depths1", ["Into the Depths2"]); 
			aBtns["Into the Depths2"].mission.mission.finishCondition = finishMainMission("Into the Depths2", ["Into the Depths3"]); 
			aBtns["Into the Depths3"].mission.mission.finishCondition = finishMainMission("Into the Depths3", ["Into the Depths4"]); 
			aBtns["Into the Depths4"].mission.mission.finishCondition = finishMainMission("Into the Depths4", ["Into the Depths5"]); 
			aBtns["Into the Depths5"].mission.mission.finishCondition = finishMainMission("Into the Depths5", ["Into the Depths6"]); 
			aBtns["Into the Depths6"].mission.mission.finishCondition = showEpilogue;
			constructed = true; 
			
		}
		private function showEpilogue():void{
			mainMissionsFinished = true; 
			var win:EndingScreen = new EndingScreen();
			win.runText();
			this.parent.addChild(win);
		}
		
	}

}