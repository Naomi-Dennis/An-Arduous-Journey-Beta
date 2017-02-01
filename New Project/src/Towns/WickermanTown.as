package Towns
{
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawSquare;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lk
	 */
	public class WickermanTown extends subMapScreen
	{
		[Embed(source = "../pics/VillageIcon.png")]
		private var villageClass:Class;
		private var constructed:Boolean = false;
		
		public function WickermanTown(title:String, bkgrndClass:Class, _levels:Array)
		{
			super(title, bkgrndClass, _levels);
			addEventListener(Event.ADDED_TO_STAGE, foo);
			if (!constructed)
			{
				setup();
				constructed = true;
			}
		}
		
		private function foo(e:Event):void
		{
			renderButtons();
			showScreen(ConvertEmbedToSprite(villageClass), "A small village on the western side of the Livi continent. It is a farming village, home to simple folk. Unfortunately, in this world, simple isn't always safe. And thus like the world, it regularly calls upon individuals to aid in its defense as well as its law and order.");
		}
		
		private function setup():void
		{
			addButton("The Coup", 508, 409);
			addButton("The Coup II", 226, 414);
			addButton("Defend the City", 374, 214);
			addButton("Critters in the Fields", 108, 239);
			addButton("Shady Characters", 399, 353);
			addButton("Bounty Hunter", 68, 120);
			addButton("Danger Dogs", 426, 256);
			addButton("Challenge1", 53, 380);
			addButton("Challenge2", 417, 132);
			addButton("Shop", 159, 363);
			
			assignLevelHandles("The Coup", 2);
			assignLevelHandles("The Coup II", 3);
			assignLevelHandles("Defend the City", 4);
			assignLevelHandles("Critters in the Fields", 5);
			assignLevelHandles("Shady Characters", 6);
			assignLevelHandles("Bounty Hunter", 7);
			assignLevelHandles("Danger Dogs", 8);
			assignLevelHandles("Shop", 9);
			assignLevelHandles("Challenge1", 10);
			assignLevelHandles("Challenge2", 11);
			
			aBtns["Critters in the Fields"].mission.mission.isInProgress = true;
			
			aBtns["The Coup"].mission.mission.finishCondition = finishMainMission("The Coup", ["The Coup II"]);
			aBtns["The Coup II"].mission.mission.finishCondition = finishMainMission("The Coup II", ["Defend the City"]);
			aBtns["Defend the City"].mission.mission.finishCondition = mapFinished;
			
			aBtns["Critters in the Fields"].mission.mission.finishCondition = finishMainMission("Critters in the Fields", ["Shady Characters"]);
			aBtns["Shady Characters"].mission.mission.finishCondition = finishMainMission("Shady Characters", ["Bounty Hunter"]);
			aBtns["Bounty Hunter"].mission.mission.finishCondition = finishMainMission("Bounty Hunter", ["Danger Dogs", "The Coup"]);
			aBtns["Danger Dogs"].mission.mission.finishCondition = resetSubMap;
			aBtns["Shop"].mission.mission.finishCondition = resetSubMap;
			
			
		}
		
		private function resetSubMap(map):void
		{
			refreshButtons();
		}
		
		public override function unlockMainMisisons():void
		{
			aBtns["The Coup"].misison.isInProgress = true;
			refreshButtons();
		}
		
		public function checkIfMainComplete():void
		{
			loadInitData()
			if (aBtns["Defend the City"].mission.mission.isComplete)
			{
				mainMissionsFinished = true;
			}
		}
	}

}