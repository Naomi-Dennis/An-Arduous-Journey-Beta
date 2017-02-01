package Screens 
{
	import flash.display.Sprite; 
	import Assets.Utility.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 
	 */
	public class InBattleRewardScreen extends Sprite
	{
		private var bkgrnd:Sprite = DrawSquare(540, 540);
		private var tfWinMsg:TextField = DrawText("You've won and your journey continues!", 24);
		private var tfReward:TextField = DrawTextArea(50, 50, 28, "center"); 
		private var tfExp:TextField = DrawTextArea(50, 50, 34, "center"); 
		private var expIco:Sprite = new Sprite();
		private var goldIco:Sprite = new Sprite();
		[Embed(source = "../pics/i-experience.png")]
		private var expClass:Class; 
		[Embed(source = "../pics/gold_pile.png")]
		private var goldClass:Class;
		private var continueBtn:Sprite = DrawButton("Continue", 22); 
		private var nextFoo:Function = null; 
		private var animationHandle:Function = null;
		private var txtFieldNum:int = 0;
		/**
		 * The actual mobs aren't changed here, they must be changed outside of the class. 
		 * This is purely for aesthetics, showing the rewards the player has earned. 
		 * 
		 * @param	playerIcos temporary mobs 
		 * @param	reward gold recieved
		 * @param	exp experience recieved (total)
		 * @param	_nextFoo callback
		 */
		public function InBattleRewardScreen(playerIcos:Array, reward:int, exp:Number, _nextFoo:Function=null) 
		{
			nextFoo = _nextFoo; 
			goldIco = ConvertEmbedToSprite(goldClass);
			goldIco.width = 52;
			goldIco.height = 48;
			tfWinMsg.x = 540 / 2 - tfWinMsg.width / 2; 
			tfWinMsg.y = 80; 
			var tfGold:TextField = DrawText("Gold Earned", 28, "center");
			PlaceObjNextTo(tfGold, goldIco);
			tfGold.x -= 35
			goldIco.addChild(tfGold);
			CenterObjRelTo(goldIco, bkgrnd);
			PlaceObjBelowRel(goldIco, tfWinMsg, 30);
			CenterObjRelTo(tfReward, goldIco);
			PlaceObjBelowRel(tfReward, goldIco);
			tfReward.text = reward.toString() + "gp";
			tfExp = DrawText("Experience Earned", 34, "center");
			CenterObjRelTo(tfExp, bkgrnd); 
			PlaceObjBelowRel(tfExp, tfReward);
			continueBtn.y = 540 - continueBtn.height - 30; 
			CenterObjRelTo(continueBtn, bkgrnd); 
			addChild(bkgrnd);
			addChild(goldIco);
			addChild(tfReward);
			addChild(tfWinMsg);
			addChild(tfExp);
			addChild(continueBtn);
			continueBtn.addEventListener(MouseEvent.CLICK, continueHandle);
			var currentIco:BattlePiece; 
			var currentExpIco:Sprite; 
			var levelUpTf:TextField = DrawText("Level Up!", 22, "center", "unzialish"); 
			var tfIncrease:TextField = DrawText("     ", 22, "center");
			var queueLevelUp:Boolean = false; 
			for (var i:* in playerIcos){
				currentIco = playerIcos[i].getBattlePiece();
				//queueLevelUp = currentIco.mob.gainExperience(exp);
				currentIco.x = 35;
				currentIco.y = 0;
				currentExpIco = ConvertEmbedToSprite(expClass);
				currentExpIco.x = currentIco.x + 13;
				var expStr:String = Math.round( Mob(currentIco.mob).getPotentialExperience() * 100).toString() + "%"; 
				tfIncrease = DrawText( expStr + " +" + exp.toString(), 22, "center");
				PlaceObjNextTo(tfIncrease, currentIco, 3);
				tfIncrease.x -= 40
				FlashConnect.trace("Mob: " + currentIco.mob.getName() + " " + Mob(currentIco.mob).getExp() + " " + Mob(currentIco.mob).getMaxExpNum() + " " + Mob(currentIco.mob).getPotentialExperience()); 
				if (i > 0){
					PlaceObjBelowRel(currentIco, playerIcos[i - 1].getBattlePiece()); 
				}
				else{
					PlaceObjBelowRel(currentIco, tfExp);
				}
				CenterObjRelTo(currentIco, bkgrnd);
				currentIco.addChild(tfIncrease);
				addChild(currentIco);
				if (queueLevelUp){
					levelUpTf = DrawText("Level Up!", 22, "center", "unzialish"); 
					levelUpTf.x = currentIco.x - levelUpTf.width - 10;
					levelUpTf.y = currentIco.y; 
					addChild(levelUpTf);
				}
			
			}
			
		}
		private function assignIncreaseAnimation(txtField:TextField, maxNum:Number):void{
			var initTime:int = getTimer(); 
			animationHandle = animationTimer(txtField, initTime, maxNum);
			addEventListener(Event.ENTER_FRAME, animationHandle);
		}
		private function animationTimer(txtField:TextField, initTime:int, maxNum:int):Function{
			var spr:InBattleRewardScreen  = this; 
			return function(e:Event):void{
				if (txtFieldNum < maxNum){
					if (getTimer() % 5 == 0){
						txtFieldNum++;
						txtField.text = txtFieldNum.toString();
					}
				}
				else{
					spr.removeEventListener(Event.ENTER_FRAME, animationHandle);
				}
			}
		}
		private function continueHandle(e:MouseEvent):void{
			nextFoo();
		}
		
	}

}