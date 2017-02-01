package Towns
{
	import Assets.Utility.DrawSquare;
	import Assets.Utility.RemoveSprite;
	import Screens.InBattleRewardScreen;
	import flash.display.Sprite;
	import Screens.TownScreen;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lk
	 */
	public class MissionStruct extends Sprite
	{
		public var missionName:String;
		public var description:String;
		public var aEvents:Array = [];
		public var nEvents:int = 0;
		public var missionIcon:String;
		public var currentEvent:*;
		public var tier:Number = 0;
		public var isComplete:Boolean = false;
		public var isInProgress:Boolean = false;
		public var finishCondition:Function = null;
		public var isTut:Boolean = false;
		public var rewards:Array = []
		public var map:Map;
		public var partOfSubMap:Boolean = false;
		
		public function MissionStruct(_name:String, _description:String, _events:Array, _missionIco:String, _missionTier:String)
		{
			missionName = _name;
			description = _description;
			aEvents = _events;
			missionIcon = _missionIco;
			tier = parseInt(_missionTier)
			addEventListener(Event.ADDED_TO_STAGE, addBackground);
		
		}
		
		private function addBackground(e:Event):void
		{
			addChild(DrawSquare(540, 540));
		}
		
		public function loadData(data:Object):void
		{
			isComplete = data.isComplete;
			isInProgress = data.isInProgress;
		}
		
		public function saveData():Object
		{
			var data:Object = {};
			data.isComplete = isComplete;
			data.isInProgress = isInProgress;
			return data;
		}
		
		public function reset():void
		{
			isComplete = false;
			isInProgress = false;
		}
		
		public function setAsComplete():void
		{
			isComplete = true;
		}
		
		public function setAsInProgress():void
		{
			isInProgress = true;
		}
		
		public function begin():void
		{
			var currentArmy:Array = Main.army.getCurrent();
			for (var i:* in currentArmy)
			{
				Mob(currentArmy[i]).setPotentialExperience();
			}
			aEvents[0].render();
			aEvents[0].myPar = this;
			addChild(aEvents[0]);
		}
		
		private function finishMission():void
		{
			setAsComplete();
			var rewardsWin:RewardWin = new RewardWin();
			var army:Array = Main.army.getCurrent();
			
			var currentMob:Mob;
			if (!isTut)
			{
				rewardsWin.findRewards((aEvents[aEvents.length - 1]).aActions);
				
				this.parent.addChild(map);
				
				if (map.currentSub != null)
				{
					map.currentSub.enable();
				}
				if (finishCondition != null)
				{
					finishCondition(map);
				}
				if (rewardsWin.hasRewards())
				{
					this.parent.addChild(rewardsWin);
					if(partOfSubMap){
						map.currentSub.onMission = false;
					}
				}
				for (var i:* in army)
				{
					Mob(army[i]).storeExpPoints();
				}
				map.enable();

			}
			RemoveSprite(this);
		}
		
		public function nextFoo():void
		{
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			nEvents++
			if (nEvents < aEvents.length)
			{
				aEvents[nEvents].myPar = this;
				aEvents[nEvents].render();
				RemoveSprite(aEvents[nEvents - 1]);
				addChild(aEvents[nEvents]);
				
			}
			else
			{
				//callback();
				finishMission();
			}
		
		}
	
	}

}

import Assets.Utility.CenterObjRelTo;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.DrawBorder;
import Assets.Utility.DrawButton;
import Assets.Utility.DrawSquare;
import Assets.Utility.DrawText;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveSprite;
import flash.display.Sprite;
import Assets.Utility.DrawTextArea;
import Assets.Utility.DrawTextArea;
import flash.events.MouseEvent;
import flash.text.TextField;

class RewardWin extends Sprite
{
	private var bkgrnd:Sprite = DrawSquare(540, 540);
	private var txtBox:TextField = DrawTextArea(200, 280, 15, "center");
	private var closeBtn:Sprite = DrawButton("Close");
	private var rewards:Array = [];
	[Embed(source = "../pics/gold_pile.png")]
	private var icoClass:Class;
	private var ico:Sprite = new Sprite();
	
	public function RewarWin():void
	{
		bkgrnd.alpha = 0.7;
		addChild(bkgrnd);
		
		addChild(txtBox);
	
	}
	
	public function closeWin(e:MouseEvent):void
	{
		RemoveSprite(this);
	}
	
	private function setText(txt:String):void
	{
		txtBox.text = txt;
		RemoveSprite(txtBox);
		addChild(txtBox);
	}
	
	public function hasRewards():Boolean
	{
		return rewards.length > 0;
	}
	
	public function findRewards(actions:Array):void
	{
		var currentAction:String = "";
		var actionVal:String = "";
		var msg:String = "You've earned:\n";
		var goldTf:TextField = new TextField();
		var expTf:TextField = new TextField();
		var title:TextField = DrawText("You've earned", 44, "center");
		title.x = 540 / 2 - title.width / 2;
		title.y = 40;
		ico = ConvertEmbedToSprite(icoClass);
		ico.width = 52;
		ico.height = 48;
		addChild(bkgrnd);
		addChild(title);
		var tfItem:TextField = new TextField();
		var maxY:int = 0;
		var tfArmyPersonnel:TextField = new TextField();
		var expGained:Number = 0;
		for (var i:* in actions)
		{
			
			currentAction = actions[i].action;
			actionVal = actions[i].value;
			if (currentAction == "Give_Gold")
			{
				goldTf = DrawText(actionVal.toString() + "gp", 24, "center");
				goldTf.x = ico.x + ico.width + 10;
				ico.addChild(goldTf);
				ico.x = (540 / 2 - ico.width / 2)
				ico.y = title.y + title.height + 60;
				addChild(ico);
				maxY = ico.y + ico.height;
			}
			else if (currentAction == "Give_Exp")
			{
				expTf = DrawText("Exp Earned: " + actionVal.toString(), 24, "center");
				if (maxY == 0)
				{
					expTf.y = title.y + title.height + 60;
					expTf.x = 540 / 2 - expTf.width / 2;
				}
				else
				{
					expTf.x = 540 / 2 - expTf.width / 2;
					expTf.y = maxY + 10;
				}
				GlowObj(expTf, 0xffffff);
				addChild(expTf);
				maxY = expTf.y + expTf.height;
				var army:Array = Main.army.getCurrent();
				var levelUps:Array = [];
				expGained = parseInt(actionVal) / army.length;
				
			}
			else if (currentAction == "Give_Item")
			{
				tfItem = DrawText("You've received " + actionVal + "\n");
				tfItem.x = 540 / 2 - tfItem.width / 2;
				if (maxY == 0)
				{
					tfItem.y = maxY + 10;
				}
				else
				{
					tfItem.y = title.y + title.height + 60;
				}
				GlowObj(tfItem, 0xffffff);
				addChild(tfItem);
				maxY += tfItem.y + tfItem.height;
			}
			else if (currentAction == "Add_Army")
			{
				tfArmyPersonnel = DrawText(actionVal + " has joined your group!\n");
				tfArmyPersonnel.x = 540 / 2 - tfArmyPersonnel.width / 2;
				if (maxY == 0)
				{
					tfArmyPersonnel.y = maxY + 10;
				}
				else
				{
					tfArmyPersonnel.y = title.y + title.height + 60;
				}
				GlowObj(tfArmyPersonnel, 0xffffff);
				addChild(tfArmyPersonnel);
				maxY += tfArmyPersonnel.y + tfArmyPersonnel.height;
					//increase ico
			}
			rewards.push(currentAction);
		}
		
		var congratsTf:TextField = DrawText("Mission Complete!", 34, "center");
		congratsTf.x = 540 / 2 - congratsTf.width / 2;
		congratsTf.y = maxY + 30;
		addChild(congratsTf);
		GlowObj(congratsTf, 0xffffff);
		GlowObj(title, 0xffffff);
		var closeMe:Sprite = DrawButton("Retrieve Reward", 24);
		closeMe.x = 540 / 2 - closeMe.width / 2;
		closeMe.y = 500;
		addChild(closeMe);
		closeMe.addEventListener(MouseEvent.CLICK, closeWin);
		for (var j:* in army)
		{
			if (Mob(army[j]).gainExperience(expGained))
			{
				addChild(Mob(army[j]).levelUp());
			}
		}
	}
}