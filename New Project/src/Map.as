package
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.RemoveSprite;
	import Screens.NotifyMessage;
	import Screens.OptionScreen;
	import Screens.PrologueScreen;
	import Screens.TownDescriptionScreen;
	import Towns.Bromide;
	import Towns.Thormund;
	import flash.display.Sprite;
	import Assets.Utility.GlowObj;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.globalization.LastOperationStatus;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import items.PrizeBox;
	import items.armor.RoyalChainmail;
	import items.DefenseBook;
	import Screens.QuickArmyGUI;
	import Towns.MissionStruct;
	import ProcessLevel;
	import Towns.subMapScreen;
	import Towns.WickermanTown;
	import mobs.CampaignEnemies.TrainingDummy;
	import mobs.PlayersLibrary;
	
	/**
	 * ...
	 * @author lk
	 */
	public class Map extends Sprite
	{
		private var aBtns:Object = {};
		[Embed(source = "map4.png")]
		private var img:Class;
		
		[Embed(source = "pics/backgrounds/firstTown.png")]
		private var firstTown:Class;
		
		[Embed(source = "pics/backgrounds/bromideTown.png")]
		private var bromide:Class;
		
		[Embed(source = "ThromundCaveBackground.png")]
		private var thormund:Class;
		
		private var mapImg:*;
		private var defMission:MissionStruct;
		private var levels:Array = [];
		private var processLevels:ProcessLevel = new ProcessLevel();
		private var overlay:Sprite = DrawSquare(540, 540);
		private var partyIco:Sprite = new RoyalChainmail().getIcon();
		private var optionsIco:Sprite = new DefenseBook().getIcon();
		private var partySpr:QuickArmyGUI = new QuickArmyGUI();
		private var partyGui:ArmyHangerGUI
		private var buttonsInitialiazed:Boolean = false;
		public var nLoadingTimer:int = 0;
		public var tmpFoo:Function = null;
		private var fog:Fog = new Fog();
		public var currentSub:subMapScreen;
		
		public function Map()
		{
			partyGui = new ArmyHangerGUI();
			partySpr = new QuickArmyGUI();
			mapImg = new img();
			mapImg.width = 540
			mapImg.height = 480;
			mapImg.y = 30;
			addChild(mapImg);
			
			partyIco.width -= 5;
			partyIco.height -= 5;
			partyIco.y = 512;
			partyIco.x = 10;
			var partyTxt:TextField = DrawText("Party", 17, "center");
			partyTxt.y = partyIco.height / 2 - partyTxt.height / 2;
			partyTxt.x = partyIco.width + partyIco.x + 10;
			partyIco.addChild(partyTxt);
			addChild(partyIco);
			
			optionsIco.width -= 5;
			optionsIco.height -= 5;
			optionsIco.x = 510;
			optionsIco.y = partyIco.y;
			var optionsTxt:TextField = DrawText("Options", 17, "center");
			optionsTxt.x -= optionsTxt.width + 10;
			optionsTxt.y = partyTxt.y;
			
			addChild(partySpr);
			
			/* Configure Buttons */
			applyBtns(partyIco);
			applyBtns(optionsIco);
			partyIco.addEventListener(MouseEvent.CLICK, viewParty);
			optionsIco.addEventListener(MouseEvent.CLICK, viewOptions);
			addChild(fog);
			fog.y = 30;
			fog.x = -fog.width;
		
		}
		
		private function buttonInit():void
		{
			if (!buttonsInitialiazed)
			{
				buttonsInitialiazed = true;
				Main.ambienceConfig.clear();
				addButton("Wickerman", 160, 149);
				addButton("Bromide", 237, 250);
				addButton("To Bromide I", 182, 175);
				addButton("To Bromide II", 206, 203);
				addButton("To Bromide III", 203, 235);
				addButton("Thormund", 306, 197);
				
				addRegionName("Wickerman", 110, 131);
				addRegionName("Bromide", 219, 229);
				addRegionName("Thormund Cave", 306, 205);
				
				assignLevelHandles()
			}
			checkMissions();
		}
		
		private function viewOptions(e:MouseEvent):void
		{
			var optionsWin:OptionScreen = new OptionScreen();
			optionsWin.x = 540 / 2 - optionsWin.width / 2;
			optionsWin.y = 540 / 2 - optionsWin.height / 2;
			overlay.alpha = 0.6;
			addChild(overlay);
			addChild(optionsWin);
			optionsWin.addEventListener(Event.REMOVED_FROM_STAGE, removeOverlay);
		}
		
		private function removeOverlay(e:Event):void
		{
			removeChild(overlay);
		}
		
		private function miniPartyGUI(e:Event):void
		{
			partySpr.setSoldiers(Main.army.getCurrent());
			partySpr.x = 540 / 2 - partySpr.width / 2;
			partySpr.y = 505;
			addChild(partySpr);
		}
		
		private function viewParty(e:MouseEvent):void
		{
			partySpr.clearSoldiers();
			partyGui.addEventListener(Event.REMOVED_FROM_STAGE, miniPartyGUI);
			addChild(partyGui);
		}
		
		public function refreshMissionStruct():void
		{
			RemoveSprite(defMission);
			addChild(defMission);
		}
		
		private function applyBtns(btn:Sprite):void
		{
			btn.addEventListener(MouseEvent.ROLL_OVER, glowBtn);
			btn.addEventListener(MouseEvent.ROLL_OUT, stopGlowBtn);
		}
		
		private function refreshButtons():void
		{
			removeButtons();
			var array:Array = [aBtns["To Bromide I"], aBtns["To Bromide II"], aBtns["To Bromide III"]];
			var currentMission:Object = {};
			var currentBtn:Object = {};
			if (aBtns["Wickerman"].mission.mainMissionsFinished){
				aBtns["To Bromide I"].mission.mission.isInProgress = true; 
			}
			for (var i:* in array)
			{
				currentBtn = array[i];
				currentMission = array[i].mission.mission;
				if (currentMission.tier == 1 || (currentMission.tier == 2 && currentMission.isInProgress))
				{
					addChild(currentBtn.ico);
				}
				else if (currentMission.isInProgress)
				{
					addChild(currentBtn.ico);
				}
				
				if (currentMission.tier == 2 && currentMission.isInProgress)
				{
					MapMissionSelector(currentBtn.ico).showYellowOrb();
					addChild(currentBtn.ico);
				}
				
				if (currentMission.isComplete)
				{
					MapMissionSelector(currentBtn.ico).showGreenOrb();
					addChild(currentBtn.ico);
				}
				
			}
			
			if (aBtns["To Bromide III"].mission.mission.isComplete)
			{
				addChild(aBtns["Bromide"].ico);
			}
			
			if (aBtns["Bromide"].mission.mainMissionsFinished)
			{
				addChild(aBtns["Thormund"].ico);
			}
			
			addChild(aBtns["Wickerman"].ico);
		}
		
		public function saveData():void
		{
			var data:Object = {};
			data["Bromide"] = aBtns["Bromide"].mission.saveData();
			data["Wickerman"] = aBtns["Wickerman"].mission.saveData();
			data["Thormund"] = aBtns["Thormund"].mission.saveData();
			data["To Bromide I"] = aBtns["To Bromide I"].mission.mission.saveData();
			data["To Bromide II"] = aBtns["To Bromide II"].mission.mission.saveData();
			data["To Bromide III"] = aBtns["To Bromide III"].mission.mission.saveData();
			Main.glblPlayer.missionStatuses = data;
			Main.saveGame();
		}
		
		public function loadData(data:Object):void
		{
			buttonInit();
			if (data["Wickerman"] != null)
			{
				aBtns["Bromide"].mission.loadedData = data["Bromide"];
				aBtns["Wickerman"].mission.loadedData = data["Wickerman"];
				aBtns["Thormund"].mission.loadedData = data["Thormund"];
				aBtns["To Bromide I"].mission.mission.loadData(data["To Bromide I"]);
				aBtns["To Bromide II"].mission.mission.loadData(data["To Bromide II"]);
				aBtns["To Bromide III"].mission.mission.loadData(data["To Bromide III"]);
				
				aBtns["Wickerman"].mission.checkIfMainComplete();
			}
		}
		
		private function removeButtons():void
		{
			for (var i:* in aBtns)
			{
				RemoveSprite(aBtns[i].ico);
			}
		}
		
		private function glowBtn(e:MouseEvent):void
		{
			var btn:Sprite = e.currentTarget as Sprite;
			GlowObj(btn, 0xffffff, 3);
		}
		
		private function stopGlowBtn(e:MouseEvent):void
		{
			var btn:Sprite = e.currentTarget as Sprite;
			RemoveFilters(btn);
		}
		
		private function assignLevelHandles():void
		{
			var wickermanLevels:Array = [levels[0], levels[1], levels[2], levels[3], levels[4], levels[18], levels[19], levels[20], levels[21], levels[29], levels[31], levels[32]]
			var bromideLevels:Array = [levels[8], levels[9], levels[10], levels[11], levels[22], levels[23], levels[24], levels[25], levels[26], levels[27], levels[28], levels[30], levels[33]];
			var thormundLevels:Array = [levels[12], levels[13], levels[14], levels[15], levels[16], levels[17], levels[34]]
			assignLevel("Wickerman", new WickermanTown("Wickerman", firstTown, wickermanLevels), true);
			assignLevel("Thormund", new Thormund("Thormund", thormund, thormundLevels), true);
			assignLevel("Bromide", new Bromide("Bromide", bromide, bromideLevels), true);
			assignLevel("To Bromide I", levels[5]);
			assignLevel("To Bromide II", levels[6]);
			assignLevel("To Bromide III", levels[7]);
			MapMissionSelector(aBtns["Wickerman"].ico).showBrownOrb();
			MapMissionSelector(aBtns["Bromide"].ico).showBrownOrb();
			MapMissionSelector(aBtns["Thormund"].ico).showBrownOrb();
		}
		
		private function assignLevel(levelName:String, mission:*, isSubMap:Boolean = false):void
		{
			var currentLevel:Object = aBtns[levelName];
			currentLevel.mission = mission;
			if (isSubMap)
			{
				currentLevel.handle = viewSubMap;
			}
			else
			{
				currentLevel.handle = viewMissionStart;
			}
			currentLevel.ico.addEventListener(MouseEvent.CLICK, currentLevel.handle(currentLevel.mission));
		}
		
		public function loadLevels(data:Object = null):void
		{
			var tf:TextField = DrawText("Loading...", 34, "left", "unzialish");
			tf.x = 540 / 2 - tf.width / 2;
			tf.y = 540 / 2 - tf.height / 2;
			
			overlay.addChild(tf);
			var prizeBox:PrizeBox = new PrizeBox();
			prizeBox.x = 540 / 2 - prizeBox.width / 2;
			prizeBox.y = tf.y - prizeBox.height - 10;
			overlay.addChild(prizeBox);
			addChild(overlay);
			var initTime:int = getTimer();
			tmpFoo = beginLoad(data, initTime + 1000);
			addEventListener(Event.ENTER_FRAME, tmpFoo);
		}
		
		public function beginLoad(data:Object = null, stopTime:int = 0):Function
		{
			var spr:* = this;
			return function(e:Event)
			{
				if (spr.nLoadingTimer < 1)
				{
					processLevels.processLevelData();
				}
				else if (processLevels.isLoaded && getTimer() > stopTime)
				{
					removeEventListener(Event.ENTER_FRAME, tmpFoo);
					loadLevelData(data);
				}
				spr.nLoadingTimer++;
			}
		}
		
		private function loadLevelData(data:Object = null):void
		{
			var lvls:Array = processLevels.aLevels;
			levels = [];
			for (var newLevel:* in lvls)
			{
				levels.push(new Mission(lvls[newLevel]));
			}
			removeChildAt(numChildren - 1);
			
			if (Main.army.getCurrent().length > 0)
			{
				partySpr.setSoldiers(Main.army.getCurrent());
				partySpr.x = 540 / 2 - partySpr.width / 2;
				partySpr.y = 505;
				addChild(partySpr);
			}
			fog.addEventListener(Event.ENTER_FRAME, moveFog);
			loadData(data);
			showPrologue();
		
		}
		
		private function showPrologue():void
		{
			var win:PrologueScreen = new PrologueScreen();
			overlay.alpha = 1;
			addChild(overlay);
			addChild(win);
			win.runText();
			win.addEventListener(Event.REMOVED_FROM_STAGE, renderMap);
		}
		
		private function renderMap(e:Event):void
		{
			renderPart2();
		}
		
		private function renderPart2():void
		{
			buttonInit();
			overlay.alpha = 0.6;
			var tut:TownDescriptionScreen = new TownDescriptionScreen(null, "Missions are accessed through the map. The different orb colors denote the mission type.\n\nBlue = Town\nWhite = General\nYellow = Story\nGreen = Completed");
			tut.x = 540 / 2 - tut.width / 2;
			tut.y = 540 / 2 - tut.height / 2;
			refreshButtons();
			addChild(tut);
			var blueOrb:MapMissionSelector = new MapMissionSelector("");
			blueOrb.showBrownOrb();
			blueOrb.width -= 5;
			blueOrb.height -= 5;
			blueOrb.x = 219;
			blueOrb.y = 249;
			addChild(blueOrb);
			var whiteOrb:MapMissionSelector = new MapMissionSelector("");
			whiteOrb.width -= 5;
			whiteOrb.height -= 5;
			whiteOrb.x = 206;
			whiteOrb.y = 263;
			addChild(whiteOrb);
			var yellowOrb:MapMissionSelector = new MapMissionSelector("");
			yellowOrb.showYellowOrb();
			yellowOrb.width -= 5;
			yellowOrb.height -= 5;
			yellowOrb.x = 213;
			yellowOrb.y = 278;
			addChild(yellowOrb);
			var greenOrb:MapMissionSelector = new MapMissionSelector("");
			greenOrb.showGreenOrb();
			greenOrb.width -= 5;
			greenOrb.height -= 5;
			greenOrb.x = 199;
			greenOrb.y = 290;
			addChild(greenOrb);
			tut.addEventListener(Event.REMOVED_FROM_STAGE, removeOrbs([blueOrb, whiteOrb, yellowOrb, greenOrb]));
		}
		
		private function removeOrbs(orbs:Array):Function
		{
			RemoveSprite(overlay);
			return function(e:Event):void
			{
				for (var i:* in orbs)
				{
					RemoveSprite(orbs[i]);
				}
			}
		}
		
		private function addRegionName(levelName:String, nX:int, nY:int):void
		{
			var label:TextField = DrawText(levelName, 15, "center", "morris_roman");
			label.textColor = 0x000000;
			label.x = nX;
			label.y = nY;
			GlowObj(label, 0xffffff);
			addChild(label);
		}
		
		private function addButton(levelName:String, nX:int, nY:int):void
		{
			aBtns[levelName] = {x: nX, y: nY, ico: new MapMissionSelector(levelName), mission: null, handle: null};
			aBtns[levelName].ico.x = nX;
			aBtns[levelName].ico.y = nY;
			addChild(aBtns[levelName].ico);
		}
		
		private function addTinyButton(levelName:String, nX:int, nY:int):void
		{
			aBtns[levelName] = {x: nX, y: nY, ico: new MapMissionSelector(levelName), mission: null, handle: null};
			aBtns[levelName].ico.width -= 3
			aBtns[levelName].ico.height -= 3;
			aBtns[levelName].ico.x = nX;
			aBtns[levelName].ico.y = nY;
			addChild(aBtns[levelName].ico);
		}
		
		private function viewSubMap(subMap:subMapScreen):Function
		{
			var spr:* = this;
			return function(e:MouseEvent):void
			{
				if (Main.army.getCurrent().length > 0)
				{
					addChild(subMap);
					partySpr.removeListeners();
					subMap.addEventListener(Event.REMOVED_FROM_STAGE, enablePartyGUI);
					if (subMap.title == "Bromide" && aBtns["WickermanTown"].mission.mainMissionsFinished)
					{
						subMapScreen(subMap).unlockMainMisisons();
					}
					else if (subMap.title == "Thormund Cave" && aBtns["Thormund Cave"].mission.misson.mainMissionsFinished)
					{
						subMapScreen(subMap).unlockMainMisisons();
					}
					spr.currentSub = subMap;
				}
				else
				{
					var notify:TownDescriptionScreen = new TownDescriptionScreen(null, "You need at least one party member to proceed!\n\nClick the party icon to select party members.");
					;
					notify.x = 540 / 2 - notify.width / 2;
					notify.y = 540 / 2 - notify.height / 2;
					overlay.alpha = 0.7;
					addChild(overlay);
					addChild(notify);
					notify.addEventListener(Event.REMOVED_FROM_STAGE, removeOverlay);
				}
			}
		}
		
		private function viewMissionStart(currentMission:Mission):Function
		{
			return function(e:MouseEvent):void
			{
				currentMission.x = 540 / 2 - currentMission.width / 2;
				currentMission.y = 540 / 2 - currentMission.height / 2;
				addChild(currentMission);
				currentMission.addEventListener(Event.REMOVED_FROM_STAGE, refresh);
			
			}
		}
		
		private function refresh(e:Event):void
		{
			refreshButtons();
		}
		
		private function enablePartyGUI(e:Event):void
		{
			partySpr.addListener();
		}
		
		public function disable():void
		{
			addChild(overlay);
		}
		
		public function enable():void
		{
				RemoveSprite(overlay);
				saveData();
				currentSub = null;
				fog.addEventListener(Event.ENTER_FRAME, moveFog);
				RemoveSprite(overlay);
				partySpr.setSoldiers(Main.army.getCurrent());
				partySpr.x = 540 / 2 - partySpr.width / 2;
				partySpr.y = 505;
				addChild(partySpr);
				checkMissions();
				refreshButtons();
		}
		
		private function checkMissions():void
		{
			if (aBtns["Wickerman"].mission.mainMissionsFinished)
			{
				aBtns["To Bromide I"].mission.mission.isInProgress = true;
			}
			
			if (aBtns["To Bromide I"].mission.mission.isComplete)
			{
				aBtns["To Bromide II"].mission.mission.isInProgress = true;
			}
			
			if (aBtns["To Bromide III"].mission.mission.isComplete)
			{
				aBtns["To Bromide III"].mission.mission.isInProgress = true;
			}
		}
		
		private function moveFog(e:Event):void
		{
			var maxDist:Number = 576
			var minDist:Number = -fog.width - 10;
			if (fog.x > maxDist)
			{
				fog.x = minDist;
			}
			fog.x += 1
		}
	}

}
import Assets.Utility.BlurObj;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.DrawSquare;
import Assets.Utility.GlowObj;
import Screens.MissionDialog;
import Towns.MissionStruct;
import mobs.Enemies.*;

import flash.display.Sprite;

class Mission extends MissionDialog
{
	public var mission:MissionStruct;
	
	public function Mission(_mission:MissionStruct)
	{
		mission = _mission;
		var enemy:* = new (EnemiesList[mission.missionIcon.toLowerCase()]());
		super(enemy.getIcon(), mission, "boss");
	
	}
}

class Fog extends Sprite
{
	[Embed(source = "pics/fog.png")]
	private var img:Class;
	private var fogImage:Sprite = new Sprite();
	
	public function Fog():void
	{
		fogImage = ConvertEmbedToSprite(img);
		fogImage.width = 540;
		fogImage.height = 480;
		BlurObj(fogImage, 40, 40);
		fogImage.alpha = 0.8
		addChild(fogImage);
	
	}
}