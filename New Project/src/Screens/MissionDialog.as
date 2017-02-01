
package Screens 
{
	import adobe.utils.CustomActions;
	import Assets.Effects.DropShadow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Assets.Utility.*;
	import Towns.MissionStruct;
	import Towns.MissionTemplate;
	/**
	 * ...
	 * @author lk
	 */
	public class MissionDialog extends Sprite 
	{
		public var mode:String = ""
		public var aMissions:MissionStruct;
		public var icon:Sprite = new Sprite();
		public var tfDesc:TextField;
		public var tfTitle:TextField;
		public var bkgrnd:ScreenBackground;
		public var closeBtn:Sprite = DrawButton("Close", 15); 
		public var beginCampaignBtn:Sprite = new Sprite();
		private var btn:Sprite = new Sprite();
		public function MissionDialog(ico:Sprite, missions:MissionStruct, mode:String="boss") 
		{
			aMissions = missions;
			icon = ico;
			icon.width = 60;
			var _title:String = missions.missionName;
			var _desc:String = missions.description;
			icon.height = 64;
			
			closeBtn.addEventListener(MouseEvent.CLICK, closeWindow);
			if (mode == "boss") {
				setUpEnemyScreen(_desc, _title);
			}
			else if (mode == "unknown") {
				setUpUnknownScreen(_desc, _title);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, doRefresh);
		}
		private function doRefresh(e:Event):void{
			refresh(); 
		}
		public function setUpUnknownScreen(desc:String, title:String):void {
			bkgrnd = new ScreenBackground( { width: 200, height:100 }, 0xffffff, 0xffffff); 
			tfTitle = DrawTextArea(100, 30, 25, "center", "UnZialish"); 
			CenterObjRelTo(tfTitle, bkgrnd);
			tfTitle.y = 10;

			tfDesc = DrawTextArea(180, 20, 15, "center"); 
			CenterObjRelTo(tfDesc, bkgrnd)
			PlaceObjBelowRel(tfDesc, tfTitle);
			
			CenterObjRelTo(closeBtn, bkgrnd);
			PlaceObjBelowRel(closeBtn, tfDesc);
			tfDesc.text = desc;
			
			addChild(bkgrnd);
			addChild(tfDesc);
			addChild(tfTitle);
			addChild(closeBtn);
		}
		public function setUpEnemyScreen(desc:String, title:String):void {
			bkgrnd = new ScreenBackground( { width: 200, height:300 }, 0xffffff, 0xffffff); 
			tfTitle = DrawTextArea(200, 30, 17, "center", "UnZialish"); 
			CenterObjRelTo(tfTitle, bkgrnd);
			tfTitle.y = 10;
			
			PlaceObjBelowRel(icon, tfTitle); 
			CenterObjRelTo(icon, bkgrnd); 
			
			tfDesc = DrawTextArea(180, 110, 15, "center"); 
			CenterObjRelTo(tfDesc, bkgrnd)
			PlaceObjBelowRel(tfDesc, icon);
			
			CenterObjRelTo(closeBtn, bkgrnd);
			PlaceObjBelowRel(closeBtn, tfDesc, 35);
		
			tfTitle.text = title;
			tfDesc.text = desc;
			
			addChild(bkgrnd);
			addChild(beginCampaignBtn);
			addChild(tfDesc);
			addChild(icon);
			addChild(tfTitle);
			addChild(closeBtn);
			
			
		}
		public function refresh():void {
			RemoveSprite(beginCampaignBtn);
			RemoveSprite(btn);
			if(!aMissions.isComplete){
				if (Main.glblPlayer.currentRoom == "settingIntro") {
					btn =	DrawButton("Begin Campaign", 15); 
				}
				else {
					btn = DrawButton("Continue Campaign", 15);
				}
				
				btn.addEventListener(MouseEvent.CLICK, beginMission(aMissions)); 
			}
			else{
				btn = DrawButton("MISSION COMPLETE", 15); 
			}
			CenterObjRelTo(btn, bkgrnd); 
			PlaceObjBelowRel(btn, tfDesc, 10); 
			addChild(btn);
		}
		public function loadLevel(lvl:String):void {
			this[lvl](); 
		}
	
		public function missionAlreadyComplete(mission:MissionStruct):Function {
			return function(e:MouseEvent):void {
			
			}
		}
		public function resetDesc(desc:String):Function {
			return function(e:MouseEvent):void {
				tfDesc.text = desc;	
			}
		}
		public function beginMission(mission:MissionStruct):Function {
			var spr:* = this; 
			return function(e:MouseEvent):void {
				if (mission.partOfSubMap){
					mission.map = Map(spr.parent.parent);
					mission.map.currentSub.onMission = true; 
					Sprite(spr.parent.parent.parent).addChild(mission);
					RemoveSprite(spr.parent.parent); 
				}
				else{
					mission.map = spr.parent;
					Sprite(spr.parent.parent).addChild(mission);
					RemoveSprite(spr.parent); 
				}
				spr.parent.disable();
				RemoveSprite(spr);
				mission.begin();
				mission.addEventListener(Event.REMOVED_FROM_STAGE, enableParent(spr.parent));
			}
		}
		public function enableParent(par:*):Function {
			var spr:* = this;
			return function(e:Event):void {
			}
		}
		public function closeWindow(e:MouseEvent):void {
			RemoveSprite(this); 
		}
	
		
	}

}