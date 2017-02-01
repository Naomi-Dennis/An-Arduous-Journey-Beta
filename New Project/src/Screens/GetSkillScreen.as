package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawText;
	import Assets.Utility.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.PlaceObjNextTo;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class GetSkillScreen extends SettingBackground
	{
		public var skills:Array = []
		public var skillsSpr:Sprite = new Sprite();
		public var msg:String = "";
		public var player:Mob;
		public var fontSize:int = 16; 
		public var tfStrength:TextField = DrawText("Strength", fontSize, "center");
		public var tfDexterity:TextField  = DrawText("Dexterity", fontSize, "center");
		public var tfWisdom:TextField  = DrawText("Wisdom", fontSize, "center");
		public var tfDefense:TextField  = DrawText("Defense", fontSize, "center");
		public var tfConstitution:TextField  = DrawText("Constitution", fontSize, "center");
		
		public var dfStrength:TextField = DrawText("00", fontSize, "center");
		public var dfDexterity:TextField = DrawText("00", fontSize, "center");
		public var dfWisdom:TextField = DrawText("00", fontSize, "center");
		public var dfDefense:TextField = DrawText("00", fontSize, "center");
		public var dfConstitution:TextField = DrawText("00", fontSize, "center");
		
		public var incDex:PlusMinusButton = new PlusMinusButton("plus");
		public var incStr:PlusMinusButton = new PlusMinusButton("plus");
		public var incWis:PlusMinusButton = new PlusMinusButton("plus");
		public var incDef:PlusMinusButton = new PlusMinusButton("plus");
		public var incCons:PlusMinusButton = new PlusMinusButton("plus");
		
		public var decDex:PlusMinusButton = new PlusMinusButton("minus");
		public var decStr:PlusMinusButton = new PlusMinusButton("minus");
		public var decWis:PlusMinusButton = new PlusMinusButton("minus") ;
		public var decDef:PlusMinusButton = new PlusMinusButton("minus");
		public var decCons:PlusMinusButton = new PlusMinusButton("minus");		
		public var dfSkillPoints:TextField = DrawText("0", fontSize, "center");
		public var tfSkillPoints:TextField = DrawText("Available Skill Points", fontSize, "center"); 
		public var skillPoints:int = 3
		public var sprStatsGUI:Sprite = new Sprite();
		public var skillChosen:Boolean = false; 
		
		
		private var statsObj:Object = {"Strength":0, "Dexterity":0, "Wisdom":0, "Defense":0, "Const":0  };
		
		/* skills = [{ico:new Sprite(), skill:new Skill() }] */
		
		public function GetSkillScreen(_player:Mob, _skills:Array, bkgrnd:Class, _msg:String, _callback:Function) 
		{
			player = _player; 
			msg = _msg; 
			super(bkgrnd, msg, _callback);
			skills = _skills; 
			if (skills.length == 0){
				skillChosen = true; 
			}
			addSkills();
			addStatsGUI(200, 200);
			var mobCpy:Mob = new Mob();
			mobCpy.loadMob( player.saveMob() );
		
			var mobAvatar:BattlePiece = mobCpy.getBattlePiece();
			mobAvatar.width *= 2;
			mobAvatar.height *= 2; 
			mobAvatar.x = 540 / 2 - mobAvatar.width / 2; 
			mobAvatar.x += 25; 
			mobAvatar.y = 40; 
			addChild(mobAvatar);
			var stats:Object = player.getStatus();
			dfStrength.text = stats.strength.toString();
			dfDefense.text = stats.defense.toString();
			dfWisdom.text = stats.wisdom.toString();
			dfConstitution.text = stats.constitution.toString();
			dfDexterity.text = stats.dexterity.toString();
		}
		public function addStatsGUI(oX:Number, oY:Number):void {
			var originY:int = oY;
			var originX:int = oX;
			
			var offsetY:int = 10;
			var offsetX:int = 10;
			
			CenterObjRelTo(tfSkillPoints, overshadow); 
			tfSkillPoints.y = originY;
			
			PlaceObjNextTo(dfSkillPoints, tfSkillPoints); 
			tfSkillPoints.y = dfSkillPoints.y;
			
			/* Place Labels */
			tfStrength.x = originX,
			tfStrength.y = originY; 
			
			PlaceObjBelowRel(tfDefense, tfStrength, offsetY);
			tfDefense.x = tfStrength.x; 
			
			PlaceObjBelowRel(tfDexterity, tfDefense, offsetY);
			tfDexterity.x = tfStrength.x; 
			
			PlaceObjBelowRel(tfWisdom, tfDexterity, offsetY);
			tfWisdom.x = tfStrength.x; 
			
			PlaceObjBelowRel(tfConstitution, tfWisdom, offsetY);
			tfConstitution.x = tfStrength.x; 
			/////////////////////
			/* Place + Buttons */
			/////////////////////
			PlaceObjNextTo(incCons, tfConstitution, offsetX);
			incCons.y = tfConstitution.y;
			
			incStr.x = incCons.x; 
			incStr.y = tfStrength.y;
			
			incDef.x = incCons.x;
			incDef.y = tfDefense.y;
			
			incWis.x = incCons.x; 
			incWis.y = tfWisdom.y;
		
			incDex.x = incCons.x;  
			incDex.y = tfDexterity.y; 
			
			
			///////////////////////////
			/* Place Dy. TextFields */ 
			//////////////////////////
			PlaceObjNextTo(dfStrength, incStr, offsetX);
			dfStrength.y = tfStrength.y;
			
			
			 PlaceObjNextTo(dfDefense, incDef, offsetX);
			dfDefense.y = tfDefense.y;
			
			PlaceObjNextTo(dfWisdom, incWis, offsetX);
			dfWisdom.y = tfWisdom.y;
		
			 PlaceObjNextTo(dfConstitution, incCons, offsetX);
			dfConstitution.y = tfConstitution.y;
			
			PlaceObjNextTo(dfDexterity, incDex, offsetX);
			dfDexterity.y = tfDexterity.y; 
			/////////////////////
			/* Place - Buttons */
			/////////////////////
			PlaceObjNextTo(decStr, dfStrength, offsetX);
			decStr.y = dfStrength.y;
			
			decDef.x = decStr.x; 
			decDef.y = dfDefense.y;
			
			decWis.x = decStr.x; 
			decWis.y = dfWisdom.y;
		
			decCons.x = decStr.x; 
			decCons.y = dfConstitution.y;
			
			decDex.x = decStr.x; 
			decDex.y = dfDexterity.y; 
			
			
			
			sprStatsGUI.addChild(dfStrength);
			sprStatsGUI.addChild(dfDefense);
			sprStatsGUI.addChild(dfDexterity);
			sprStatsGUI.addChild(dfWisdom);
			sprStatsGUI.addChild(dfConstitution);
			
			
			sprStatsGUI.addChild(tfStrength);
			sprStatsGUI.addChild(tfDefense);
			sprStatsGUI.addChild(tfDexterity);
			sprStatsGUI.addChild(tfWisdom);
			sprStatsGUI.addChild(tfConstitution);
			
			sprStatsGUI.addChild(incStr);
			sprStatsGUI.addChild(incDef);
			sprStatsGUI.addChild(incWis);
			sprStatsGUI.addChild(incCons);
			sprStatsGUI.addChild(incDex); 
			
			sprStatsGUI.addChild(decDef);
			sprStatsGUI.addChild(decStr);
			sprStatsGUI.addChild(decWis);
			sprStatsGUI.addChild(decCons);
			sprStatsGUI.addChild(decDex);
			
			addChild(sprStatsGUI);
			addChild(dfSkillPoints);
			addChild(tfSkillPoints);
			
			dfSkillPoints.text = skillPoints.toString();
			var glowStrength:int = 3;
			GlowObj(tfStrength, 0xffffff, glowStrength)
			GlowObj(tfDefense, 0xffffff, glowStrength)
			GlowObj(tfWisdom, 0xffffff, glowStrength)
			GlowObj(tfDexterity, 0xffffff, glowStrength)
			GlowObj(tfConstitution, 0xffffff, glowStrength)
			
			GlowObj(dfStrength, 0xffffff, glowStrength)
			GlowObj(dfDefense, 0xffffff, glowStrength)
			GlowObj(dfWisdom, 0xffffff, glowStrength)
			GlowObj(dfDexterity, 0xffffff, glowStrength)
			GlowObj(dfConstitution, 0xffffff, glowStrength)
			
			incStr.addEventListener(MouseEvent.CLICK, increaseVal(dfStrength, "Strength"))
			incDef.addEventListener(MouseEvent.CLICK, increaseVal(dfDefense, "Defense"))
			incDex.addEventListener(MouseEvent.CLICK, increaseVal(dfDexterity, "Dexterity"))
			incWis.addEventListener(MouseEvent.CLICK, increaseVal(dfWisdom, "Wisdom"))
			incCons.addEventListener(MouseEvent.CLICK, increaseVal(dfConstitution, "Const"))
			
			decStr.addEventListener(MouseEvent.CLICK, decreaseVal(dfStrength, "Strength"));
			decDef.addEventListener(MouseEvent.CLICK, decreaseVal(dfDefense, "Defense"));
			decDex.addEventListener(MouseEvent.CLICK, decreaseVal(dfDexterity, "Dexterity"));
			decWis.addEventListener(MouseEvent.CLICK, decreaseVal(dfWisdom, "Wisdom"));
			decCons.addEventListener(MouseEvent.CLICK, decreaseVal(dfConstitution, "Const"));
			disableContinueBtn();
			continueBtn.addEventListener(MouseEvent.CLICK, continueBtnHandle);
		}
		public function continueBtnHandle(e:MouseEvent):void {
			/* Raise the stats by the numbers on the table*/
			if(skillChosen && skillPoints == 0){
				RemoveSprite(this);
				player.setStatByN("strength", parseInt(dfStrength.text))
				player.setStatByN("defense", parseInt(dfDefense.text))
				player.setStatByN("dexterity", parseInt(dfDexterity.text))
				player.setStatByN("constitution", parseInt(dfConstitution.text))
				player.setStatByN("wisdom", parseInt(dfWisdom.text))
				player.setInitialState();//set the player's new "default" state to include the new stats
			}
			else {
				if (!skillChosen && skills.length > 0) {
					tfMsg.text = "You need to choose a skill!";
				}
				else if(skillPoints > 0){
					tfMsg.text = "You need to spend your skill points!"; 
				}
				else if(skillPoints > 0 && (!skillChosen && skills.length > 0)){
					tfMsg.text = "You need to choose a skill and spend your skill points!"; 
				}
			}
		}
		public function increaseVal(tfBox:TextField, stat:String):Function {
			return function(e:MouseEvent):void {
				var val:int = statsObj[stat]
			
				var oldVal:int = 0;
				if (skillPoints > 0) {
					val++;
					statsObj[stat] = val; 
					skillPoints--;
					oldVal = parseInt(tfBox.text) + 1; 
					tfBox.text = oldVal.toString();
				}
				
				
				dfSkillPoints.text = skillPoints.toString();
				
			}
		}
		
		public function decreaseVal(tfBox:TextField, stat:String):Function {
			return function(e:MouseEvent):void {
				var val:int = statsObj[stat]
				
				var oldVal:int = 0;
				if (val > 0) {
					val--;
					statsObj[stat] = val; 
					skillPoints++;
					oldVal = parseInt(tfBox.text) - 1; 
					tfBox.text = oldVal.toString();
				}
				
				dfSkillPoints.text = skillPoints.toString();
			
			}
		}
		public function addSkills():void {
			var size:Object = { width:32, height:32 }; 
			var c:int = 0;
			var currentSkill:Sprite = new Sprite();
			for (var i:* in skills) {
				if(skills[i].hasOwnProperty("skill") != null){
					currentSkill = skills[i].ico; 
					currentSkill.width = size.width;
					currentSkill.height = size.height; 
					currentSkill.x = (i * size.width) + c;
					c += 10; 
					currentSkill.addEventListener(MouseEvent.ROLL_OVER, showDescription(skills[i].skill));
					currentSkill.addEventListener(MouseEvent.ROLL_OUT, hideDescription);
					currentSkill.addEventListener(MouseEvent.CLICK, learnSkill(skills[i].skill));
					skillsSpr.addChild(currentSkill);
				}
			}
			var upperBound:int = tfMsg.y + tfMsg.height;
			skillsSpr.y = continueBtn.y - skillsSpr.height - 50; 
			skillsSpr.x = 540 / 2 - skillsSpr.width / 2
			addChild(skillsSpr); 
		}
		public function showDescription(skill:Skill):Function {
			return function(e:MouseEvent):void {
				sprStatsGUI.alpha = 0; 
				tfMsg.text = skill.getCompleteDesc();
				var spr:Sprite = e.currentTarget as Sprite;
				GlowObj(spr, 0xffffff, 3); 
			}
		}
		public function hideDescription(e:MouseEvent):void {
			if(contains(skillsSpr)){
				tfMsg.text = msg;
				sprStatsGUI.alpha = 1; 
				var spr:Sprite = e.currentTarget as Sprite;
				spr.filters = [];
			}
		}
		public function learnSkill(skill:Skill):Function {
			return function(e:MouseEvent):void {
				skillChosen = true; 
				SndLib.winBattleSnd();
				skill.setOwner(player);
				if(!player.checkQuickslotFull()){
					player.addToQuickSlot(skill); 
				}
				else{
					if(!Main.glblPlayer.inventory.isFull()){
						var notify:TownDescriptionScreen = new TownDescriptionScreen(null, "Your quickslots are full, " + skill.getName() + " book has been added to your inventory!"); 
						notify.x = 540 / 2 - notify.width / 2;
						notify.y = 540 / 2 - notify.height / 2; 
						addChild(notify); 
						Main.glblPlayer.inventory.addItem(skill);
					}
				}
				RemoveSprite(skillsSpr);
				sprStatsGUI.alpha = 1; 
				tfMsg.text = "You've learned " + skill.getName() + "!";
			}
		}
	}


}
import Assets.Utility.DrawText;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

class PlusMinusButton extends Sprite {
	public var tf:TextField;
	public function PlusMinusButton(mode:String):void {
		if (mode == "plus") {
			tf = DrawText("+", 15)
		}
		else if (mode == "minus") {
			tf = DrawText("-", 15); 
		}
		addEventListener(MouseEvent.ROLL_OVER, onHover);
		addEventListener(MouseEvent.ROLL_OUT, onOut); 
		addChild(tf); 
	}
	public function onHover(e:MouseEvent):void {
		GlowObj(tf, 0xffffff, 3)
	}
	public function onOut(e:MouseEvent):void {
		RemoveFilters(tf); 
	}
}