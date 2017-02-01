package 
{
	import BattleStruct;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import items.Antidote;
	import Towns.*;
	import org.flashdevelop.utils.FlashConnect;

	/**
	 * ...
	 * @author lk
	 */
	public class ProcessLevel 
	{
		public var aLevels:Array = [];
		public var aEvents:Array = [];
		private var LOADER:URLLoader = new URLLoader();
		private var REQUEST:URLRequest = new URLRequest();
		public var isLoaded:Boolean = false; 
		public function ProcessLevel() 
		{
			
		}
		public function processLevelData():void {
			
			//	REQUEST.url = "Levels.json"; 
			REQUEST.url = "../src/Levels.json";
				LOADER.load(REQUEST);
				LOADER.addEventListener(Event.COMPLETE, processLevel);
				//LOADER.addEventListener(IOErrorEvent.IO_ERROR, foundError);
		}
		private function foundError(e:IOErrorEvent):void{

		}
		
		private function processLevel(e:Event):void {
			var data:Object = JSON.parse(e.currentTarget.data); 
			var levels:Array = data["levels"]; 
			var nLevels:int = levels.length; 
			var currentLevel:Array = []; 
			var newLevel:Array = [];
			var levelName:String = ""; 
			for (var i:int = 0; i < nLevels; ++i) {
				levelName = (i + 1).toString(); 
				currentLevel = levels[i][levelName];
				newLevel = processing(currentLevel);
				aEvents = []; 
			}
		}
		private function processing(data:Array):Array {
			aEvents = []; 
			var nLength:int = data.length;
			var currentEvent:Object = { };
			var eventType:String = "";
			var properties:Object = data[0]["properties"][0]["args"];
			var missionDesc:String = properties[1]["desc"]; 
			var missionName:String = properties[0]["title"]; 
			var missionIcon:String = properties[2]["icoName"]; 
			var missionTier:String = properties[3]["tier"];
			for (var i:int = 1; i < nLength; ++i) {
				currentEvent = data[i]["event"];
				eventType = currentEvent[0]["args"][0]["type"].toLowerCase(); 
				if (eventType == "battle") {
					createBattle(currentEvent);
				}
				else if (eventType == "shop") {
					createShop(currentEvent);
				}
				else if (eventType == "setting") {
					createSetting(currentEvent);
				}
			}
			
			var missionStruct:MissionStruct = new MissionStruct(missionName, missionDesc, aEvents, missionIcon, missionTier ); 
			aLevels.push(missionStruct);
			isLoaded = true;
			return aLevels; 
		}
		public function createBattle(data:Object):void {
			var props:Object = data[0]["args"]; 
			var aEnemies:Array = props[3]["aEnemies"]; 
			var background:String = props[1]["background"]; 
			var nEnemies:String = props[2]["nEnemies"]; 
			var aEnemyTypes:Array = [];
			var len:int = aEnemies.length; 
			for (var i:int = 0; i < len ; i++) {
				aEnemyTypes.push( aEnemies[i]["Mob"] ); 
			}
			var battle:BattleStruct = new BattleStruct(nEnemies, background, aEnemyTypes);
			aEvents.push(battle);
		}
		public function createSetting(data:Object):void {
			var props:Object = data[0]["args"]; 
			var background:String  = props[1]["background"];
			var prompt:String = props[2]["prompt"]; 
			var aAction:Array = props[4]["actions"]; 
			var finishMission:String = props[3]["finishMission"]; 
			var object:Object = { };
			var objAction:Array = [];
			var currentAction:Object = { } 
			if(aAction.length > 0){
				for (var i:int = 0; i < aAction.length; i++) {
					object = { }; 
					currentAction = aAction[i]; 
					for (var j:* in currentAction){
						object.action = j; 
						object.value = currentAction[j]; 
					}
					objAction.push(object); 
				}		
			}
			var setting:SettingStruct = new SettingStruct(prompt, background, objAction);
			aEvents.push(setting); 
		}
		
		public function createShop(data:Object):void {
			var props:Object = data[0]["args"]; 
			var gold:String = props[1]["Gold"]; 
			var background:String = props[2]["background"]; 
			var aItems:Array = props[3]["items"]; 
			var len:int = aItems.length; 
			var object:Object = { };
			var objItems:Array = [];
			for (var i:int = 0; i < len; ++i) {
				for (var j:* in aItems[i]){
					object = new Object(); 
					object.name = j; 
					object.type = aItems[i][j][1]["Type"];
					object.value = aItems[i][j][0]["Value"]; 
					objItems.push(object); 
				}
			}
			var shop:ShopStruct = new ShopStruct(gold, objItems, background);
			aEvents.push(shop);
		}
		
		
		
		
	}

}