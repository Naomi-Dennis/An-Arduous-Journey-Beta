package Towns
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.GlowObj;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.RemoveSprite;
	import Screens.ScreenBackground;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Assets.Utility.CenterObjRelTo;
	;
	
	/**
	 * ...
	 * @author lk
	 */
	public class subMapScreen extends Sprite
	{
		public var bkgrnd:Sprite = new Sprite();
		public var title:String;
		protected var levels:Array = [];
		protected var aBtns:Object = {};
		public var mainMissionsFinished:Boolean = false;
		private var currentMissionWin:*;
		private var tfTitle:TextField;
		private var overlay:Sprite = DrawSquare(540, 540);
		public var loadedData:Object = null; 
		private var hasLoaded:Boolean = false; 
		private var fog:Fog = new Fog();
		private var closeBtn:Sprite = DrawButton("Close", 25);
		public var onMission:Boolean = false; 
		public function subMapScreen(title:String, bkgrndClass:Class, _levels:Array)
		{
			overlay = DrawSquare(540, 540);
			
			levels = _levels;
		
			var overlay:Sprite = DrawSquare(540, 540);
			overlay.alpha = 0.5;
			
			bkgrnd = ConvertEmbedToSprite(bkgrndClass);
			bkgrnd.width = bkgrnd.width / 2;
			bkgrnd.height = bkgrnd.height / 2;
			bkgrnd.y += 60;
			bkgrnd.x += 3;
			
			fog.y = bkgrnd.y; 
			fog.x = 0; 
			fog.width = bkgrnd.width;
			fog.height = bkgrnd.height; 
			tfTitle = DrawText(title, 36, "center", "unzialish");
			DropShadow(tfTitle);
			tfTitle.x = 540 / 2 - tfTitle.width / 2;
			tfTitle.y = 20;
			
			
			closeBtn.y = 540 - 60;
			closeBtn.x = (bkgrnd.x + bkgrnd.width)/2 - closeBtn.width / 2;
			closeBtn.addEventListener(MouseEvent.CLICK, closeWindow);
			addChild(overlay);
			
			addChild(closeBtn);
			addChild(bkgrnd);
			addChild(tfTitle);
			addEventListener(Event.ADDED_TO_STAGE, addFog); 
			addEventListener(Event.REMOVED_FROM_STAGE, removeFog);
		}
		private function removeFog(e:Event):void{
				RemoveSprite(fog); 
				removeEventListener(Event.ENTER_FRAME, moveFog);
			if(!onMission){
				Map(this.parent).enable(); 
			}
		}
		private function addFog(e:Event):void{
			addChild(fog); 
			addEventListener(Event.ENTER_FRAME, moveFog); 
		}
		public function loadInitData():void{
			if (!hasLoaded){
				loadData();
				hasLoaded = true;
			}
		}
		public function setTownDescription(desc:String):void
		{
			var winBkgrnd:Sprite = new ScreenBackground({width: 250, height: 250}, 0x000000, 0xfffff);
			var txtField:TextField = DrawTextArea(140, 140, 15, "center");
		
		}
		
		public function unlockMainMisisons():void
		{
			//...virtual function
		}
		
		public function loadData():void
		{
			if (loadedData != null)
			{
				
				loadedData.mapCompleted = mapFinished;
				var missionData:Object = loadedData.missionData;
				for (var i:* in missionData)
				{
					MissionStruct(aBtns[i].mission.mission).loadData(missionData[i]);
				}
				
			}
			refreshButtons();
		}
		
		public function saveData():Object
		{
			var saveObj:Object = new Object();
			saveObj.title = title;
			saveObj.mapCompleted = mapFinished;
			saveObj.missionData = new Object();
			for (var i:* in aBtns)
			{
				saveObj.missionData[i] = new Object();
				saveObj.missionData[i] = MissionStruct(aBtns[i].mission.mission).saveData();
			}
			return saveObj;
		}
		
		protected function finishMainMission(missionName:String, nextMissions:Array):Function
		{
			return function(map:Map):void
			{
				for(var i:* in nextMissions){
					if (aBtns[missionName].mission.mission.isComplete)
					{
						aBtns[nextMissions[i]].mission.mission.isInProgress = true;
					}
				}
				refreshButtons();
			}
		}
	
		protected function mapFinished(map:Map):void
		{
			mainMissionsFinished = true;
		}
		
		private function closeWindow(e:MouseEvent):void
		{
			RemoveSprite(this);
		}
		
		protected function addButton(levelName:String, nX:int, nY:int):void
		{
			aBtns[levelName] = {x: nX, y: nY, ico: new MapMissionSelector(levelName), mission: null, handle: null};
			aBtns[levelName].ico.x = nX;
			aBtns[levelName].ico.y = nY;
			//addChild(aBtns[levelName].ico);
		}
		
		protected function refreshButtons():void
		{
			for (var i:* in aBtns)
			{
				RemoveSprite(aBtns[i].ico);
			}
			renderButtons();
		}
		
		protected function renderButtons():void
		{
			var currentMission:Object = {};
			var currentBtn:Object = {};
			for (var i:* in aBtns)
			{
				currentBtn = aBtns[i];
				currentMission = aBtns[i].mission.mission;
				if (currentMission.isInProgress && !currentMission.isComplete)
				{
					addChild(currentBtn.ico);
				}
				else if (currentMission.isComplete)
				{
					MapMissionSelector(currentBtn.ico).showGreenOrb();
					addChild(currentBtn.ico);
				}
				
				if (currentMission.tier == 2 && currentMission.isInProgress)
				{
					MapMissionSelector(currentBtn.ico).showYellowOrb();
					addChild(currentBtn.ico);
				}
				
				if (currentMission.tier == 3)
				{
					MapMissionSelector(currentBtn.ico).showPurpleOrb();
					addChild(currentBtn.ico);
				}
			}
			if (aBtns.hasOwnProperty("Shop"))
			{
				aBtns["Shop"].mission.mission.isComplete = false; 
				MapMissionSelector(aBtns["Shop"].ico).showGrayOrb()
				addChild(aBtns["Shop"].ico);
			}
		}
		
		protected function viewMissionStart(currentMission:*):Function
		{
			var spr:* = this; 
			return function(e:MouseEvent):void
			{
				currentMission.x = 540 / 2 - currentMission.width / 2;
				currentMission.y = 540 / 2 - currentMission.height / 2;
				currentMissionWin = currentMission;
				addChild(currentMission);
			}
		}
		private function checkAllComplete(missionData:Object):void{
			var currentData:Object = null
			for (var i:* in missionData){
				currentData = missionData[i]
				if (!currentData.isComplete){
					mainMissionsFinished = false;
				}
			}
			mainMissionsFinished = true; 
		}
		private function applyBtns(btn:Sprite):void
		{
			btn.addEventListener(MouseEvent.ROLL_OVER, glowBtn);
			btn.addEventListener(MouseEvent.ROLL_OUT, stopGlowBtn);
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
		
		protected function assignLevelHandles(missionName:String, missionIndex:int):void
		{
			var currentTarget:Object = aBtns[missionName];
			currentTarget.mission = levels[missionIndex]
			MissionStruct(currentTarget.mission.mission).partOfSubMap = true; 
			currentTarget.handle = viewMissionStart;
			currentTarget.ico.addEventListener(MouseEvent.CLICK, currentTarget.handle(currentTarget.mission));
		}
		
		public function disable():void
		{
			//RemoveSprite(currentMissionWin); 
			//RemoveSprite(tfTitle); 
			for (var i:* in aBtns)
			{
				RemoveSprite(aBtns[i].ico);
			}
			RemoveSprite(fog); 
			RemoveSprite(bkgrnd);
			tfTitle.alpha = 0; 
		}
		
		public function enable():void
		{
			bkgrnd.alpha = 1;
			overlay.alpha = 0.7; 
			RemoveSprite(currentMissionWin);
			addChild(bkgrnd);
			addChild(tfTitle);
			addChild(fog);
			addChild(closeBtn);
			refreshButtons();
		
		}
		
		public function showScreen(icon:Sprite, desc:String):void
		{
			var win:TownDescriptionScreen = new TownDescriptionScreen(icon, desc);
			CenterObjRelTo(win, bkgrnd);
			win.y = 540 / 2 - win.height / 2;
			overlay.alpha = 0.6;
			addChild(overlay);
			addChild(win);
			win.addEventListener(Event.REMOVED_FROM_STAGE, removeOverlay);
		}
		
		private function removeOverlay(e:Event):void
		{
			RemoveSprite(overlay);
		}
		private function moveFog(e:Event):void{
			var maxDist:Number = 576
			var minDist:Number = -fog.width - 10; 
			if (fog.x > maxDist){
				fog.x = minDist; 
			}
			fog.x += 1 
		}
	
	}

}
import Screens.ScreenBackground;
import flash.display.Sprite;
import Assets.Utility.*;
import flash.events.MouseEvent;
import flash.text.TextField;

class TownDescriptionScreen extends Sprite
{
	private var bkgrnd:ScreenBackground = new ScreenBackground({width: 250, height: 250}, 0x000000, 0xffffff);
	private var txtField:TextField = DrawTextArea(240, 240, 15, "center");
	private var icon:Sprite = new Sprite();
	private var closeBtn:Sprite = DrawButton("Close", 15);
	public function TownDescriptionScreen(_icon:Sprite, desc:String)
	{
		
		icon = _icon;
		icon.width *= 2;
		icon.height *= 2;
		txtField.text = desc;
		
		CenterObjRelTo(txtField, bkgrnd);
		PlaceObjBelowRel(txtField, icon, 30);
		txtField.y += 3;
		txtField.text = desc;
		
		CenterObjRelTo(icon, bkgrnd);
		icon.y = 20;
		
		
		CenterObjRelTo(closeBtn, bkgrnd);
		closeBtn.y = (bkgrnd.y + bkgrnd.height) - closeBtn.height - 10;
		
		addChild(bkgrnd);
		addChild(txtField);
		addChild(icon);
		addChild(closeBtn);
		
		closeBtn.addEventListener(MouseEvent.CLICK, closeWin);
	
	}
	
	private function closeWin(e:MouseEvent):void
	{
		RemoveSprite(this);
	}
}

class Fog extends Sprite{
	[Embed(source="../pics/fog.png")]
	private var img:Class;
	private var fogImage:Sprite = new Sprite();
	public function Fog():void{
		fogImage = ConvertEmbedToSprite(img); 
		fogImage.width = 540;
		fogImage.height = 480;
		BlurObj(fogImage, 40, 40);
		fogImage.alpha = 0.8
		addChild(fogImage); 
		
	}
}