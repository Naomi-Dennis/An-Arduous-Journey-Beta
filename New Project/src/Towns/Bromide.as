package Towns 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Bromide extends subMapScreen
	{
		[Embed(source = "../pics/townIcon.png")]
		private var townIco:Class; 
		private var constructed:Boolean = false; 
		public function Bromide(title:String, bkgrndClass:Class,  _levels:Array) 
		{
			super(title, bkgrndClass, _levels); 
			mainMissionsFinished = false;
			addEventListener(Event.ADDED_TO_STAGE, foo);
		}
		private function foo(e:Event):void{
			if (!constructed){
				setup(); 
				constructed = true;
			}
			renderButtons();
			showScreen( ConvertEmbedToSprite(townIco), "A medium sized town home to the Lord Marim. It stands as the buffer at the center of Livi, working as a bridge between the commercial sectors on the continent. Many have sought riches in Bromide, and only few have found it, with even fewer keeping it.");  
		}
		private function setup():void{
			addButton("Ruins", 116, 141);
			addButton("Survivors", 163, 231);
			addButton("Glimmer of Hope", 377, 295);
			addButton("Fighting Back", 338, 231);
			addButton("Vanquishing Evil1", 72, 333);
			addButton("Vanquishing Evil2", 316, 193);
			addButton("Vanquishing Evil3", 276, 131);
			addButton("Vanquishing Evil4", 128, 351);
			addButton("Vanquishing Evil5", 472, 275);
			addButton("Vanquishing Evil6", 480, 113);
			addButton("Challenge3", 61, 369); 
			addButton("Shop", 282, 314); 
		
			
			
			assignLevelHandles("Ruins", 0); 
			assignLevelHandles("Survivors", 1);
			assignLevelHandles("Glimmer of Hope", 2);
			assignLevelHandles("Fighting Back", 3);
			assignLevelHandles("Vanquishing Evil1", 4)
			assignLevelHandles("Vanquishing Evil2", 5)
			assignLevelHandles("Vanquishing Evil3", 6)
			assignLevelHandles("Vanquishing Evil4", 7)
			assignLevelHandles("Vanquishing Evil5", 8)
			assignLevelHandles("Vanquishing Evil6", 9)
			assignLevelHandles("Challenge3", 10); 
			assignLevelHandles("Shop", 10); 
			
			
			aBtns["Ruins"].mission.mission.isInProgress = true; 
			aBtns["Vanquishing Evil1"].mission.mission.isInProgress = true; 
			
			aBtns["Ruins"].mission.mission.finishCondition = finishMainMission("Ruins", ["Survivors"]); 
			aBtns["Survivors"].mission.mission.finishCondition = finishMainMission("Survivors", ["Glimmer of Hope"]); 
			aBtns["Glimmer of Hope"].mission.mission.finishCondition = finishMainMission("Glimmer of Hope", ["Fighting Back"]); 
			aBtns["Fighting Back"].mission.mission.finishCondition = mapFinished; 
			
			
			aBtns["Vanquishing Evil1"].mission.mission.finishCondition = finishMainMission("VanquishingEvil1", ["VanquishingEvil2"]);
			aBtns["Vanquishing Evil2"].mission.mission.finishCondition = finishMainMission("VanquishingEvil2", ["VanquishingEvil3"]);
			aBtns["Vanquishing Evil3"].mission.mission.finishCondition = finishMainMission("VanquishingEvil3", ["VanquishingEvil4"]);
			aBtns["Vanquishing Evil4"].mission.mission.finishCondition = finishMainMission("VanquishingEvil4", ["VanquishingEvil5"]);
			aBtns["Vanquishing Evil5"].mission.mission.finishCondition = finishMainMission("VanquishingEvil5", ["VanquishingEvil6"]);
			aBtns["Vanquishing Evil6"].mission.mission.finishCondition = refreshButtons;
			
			 loadInitData()
		}
		public override function unlockMainMisisons():void{
			aBtns["Ruins"].misison.isInProgress = true; 
			refreshButtons();
		}
	}

}