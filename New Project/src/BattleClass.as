package
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveFromArray;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Screens.InBattleRewardScreen;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class BattleClass extends Sprite
	{
		private var gui:BattleGUI;
		private var field:Field;
		private var player:Mob = null; // current player
		private var enemy:Enemy = null; // current enemy
		private var playerIndex:int = 0;
		private var enemyIndex:int = 0;
		private var aPlayers:Array = [];
		private var aEnemies:Array = [];
		private var playerTurn:Boolean = true;
		private var overshadow:Sprite = DrawSquare(540, 540);
		private var prompt:TextField = DrawTextArea(200, 27, 25, "center");
		private var promptDesc:TextField = DrawTextArea(200, 300, 16, "center");
		private var enemyStartPoints:Array = [new Point(3, 3), new Point(6, 3), new Point(9, 3), new Point(12, 3), new Point(3, 5), new Point(6, 5), new Point(9, 5), new Point(12, 5)];
		private var playerStartPoints:Array = [new Point(3, 11), new Point(6, 11), new Point(9, 11), new Point(12, 11), new Point(3, 13), new Point(6, 13), new Point(9, 13), new Point(12, 13)];
		private var nextFoo:Function;
		private var loseFoo:Function = null;
		[Embed(source = "snd/Battke Begin.mp3")]
		private var battleSound:Class;
		
		private var contestantScreen:ContestantScreen = null;
		private var reward:int = 0;
		private var expReward:int = 0;
		private var enemyTurnNum:int = 0;
		private var playerTurnNum:int = 0;
		private var isTut:Boolean = false;
		private var numPlayers:int = 0;
		private var numEnemies:int = 0;
		private var mobs:Array = []; 
		public var turnSwitching:Boolean = false;
		public var turnSwitchFlag:Boolean = false; 
		private var initialTimer:int = 0; 
		private var delayTime:int = 0; 
		private var allTurnsOver:Boolean = false; 
		private var enemyTurnStarted:Boolean = false; 
		public function BattleClass(_field:Field, _players:Array, _enemies:Array, background:Class, tut:Boolean = false)
		{
			
			var bkgrnd:Sprite = ConvertEmbedToSprite(background);
			bkgrnd.width = 540;
			bkgrnd.height = 540
			bkgrnd.alpha = 0.6
			field = _field;
			//player = _player;
			//enemy = _enemy;
			aPlayers = _players;
			aEnemies = _enemies;
			var buffer:Sprite = DrawSquare(540, 540);
			addChild(buffer); 
			
			for (var i:* in aEnemies)
			{
				reward += Enemy(aEnemies[i]).sumStats();
			}
			expReward = reward;
			expReward = Math.floor(expReward * (Math.log(aEnemies.length))) * 2;
			
			reward = ((Math.ceil(reward/5) * Math.sqrt(reward))/aPlayers.length)
			field.renderField();
			field.x = 40;
			field.y = 52;
			
			overshadow.alpha = 0.7;
			
			prompt.x = 540 / 2 - prompt.width / 2;
			prompt.y = 70;
			
			promptDesc.x = 540 / 2 - promptDesc.width / 2;
			PlaceObjBelowRel(promptDesc, prompt, 80);
			
			enemyStartPoints = field.checkCells(enemyStartPoints);
			playerStartPoints = field.checkCells(playerStartPoints);
			
			player = aPlayers[0];
			enemy = aEnemies[0];
			
			for (var i:* in aPlayers)
			{
				aPlayers[i].setInitialState();
				aPlayers[i].getBattlePiece().x = 0;
				aPlayers[i].getBattlePiece().y = 0;
			}
			for (var j:* in aEnemies)
			{
				aEnemies[j].setInitialState();
				aEnemies[j].getBattlePiece().x = 0;
				aEnemies[j].getBattlePiece().y = 0;
			}
			gui = new BattleGUI(field, player, tut);
			numEnemies = aEnemies.length;
			numPlayers = aPlayers.length;
			gui.setEndFoo(setturnSwitchingToFalse);
			addChild(bkgrnd);
			addChild(field);
			addChild(gui);
			mobs = mobs.concat(aPlayers);
			mobs = mobs.concat(aEnemies);
		}
		private function setturnSwitchingToFalse():void{
			player.myTurn = false; 
			turnDelayFoo();
		}
		public function signalFight():void
		{
			Main.ambienceConfig.clear();
			Main.sndConfig.playSound(battleSound);
			darkenScreen("Battle Begin!", "");
			var arry:Array = [];
			for (var i:* in aPlayers)
			{
				var newMob:Mob = new Mob();
				newMob.loadMob((aPlayers[i].saveMob()));
				arry.push(newMob);
			}
			contestantScreen = new ContestantScreen(arry, aEnemies);
			contestantScreen.x = 540 / 2 - contestantScreen.width / 2;
			var backToTown:Sprite = DrawButton("Go back to Town", 36);
			contestantScreen.y = 150
			addChild(contestantScreen);
			
			var fightBtn:Sprite = DrawButton("Fight", 36);
			fightBtn.y = 350
			addChild(fightBtn);
			CenterObjRelTo(fightBtn, overshadow);
			PlaceObjBelowRel(backToTown, fightBtn);
			CenterObjRelTo(backToTown, overshadow);
			//addChild(backToTown);
			fightBtn.addEventListener(MouseEvent.CLICK, fightBegin(backToTown));
			backToTown.addEventListener(MouseEvent.CLICK, goBackToTownFoo);
			
		
		}
		
		public function showFightSignal(num:int, lvlPrompt:String = ""):void
		{
			
			darkenScreen("Challenge " + num.toString() + "", lvlPrompt);
			var fightBtn:Sprite = DrawButton("Fight", 36);
			addChild(fightBtn);
			CenterObjRelTo(fightBtn, overshadow);
			if (lvlPrompt.length == 0)
			{
				fightBtn.y = 200;
			}
			else
			{
				fightBtn.y = 350
			}
			addChild(fightBtn);
			fightBtn.addEventListener(MouseEvent.CLICK, fightBegin);
		}
		
		private function fightBegin(townBtn:Sprite):Function
		{
			var spr:* = this; 
			return function(e:MouseEvent):void
			{
				RemoveSprite(contestantScreen);
				setPieces(aPlayers, playerStartPoints);
				setPieces(aEnemies, enemyStartPoints);
				var btn:Sprite = e.currentTarget as Sprite;
				RemoveSprite(btn);
				RemoveSprite(townBtn);
				removeDarkenScreen();
				turnSwitching = false; 
				playerIndex = 1;
				player.getBattlePiece().getCellLocation().highlightCellAsTurn();
				gui.updatePlayer(aPlayers[0]);
				addEventListener(Event.ENTER_FRAME, resetBattlePieceDims);
			}
		}
		private function resetBattlePieceDims(e:Event):void{
			for (var i:* in aPlayers){
				if (aPlayers[i].getBattlePiece().height < 44){
					FlashConnect.trace("A");
				}
				//aPlayers[i].getBattlePiece().resetDimensions();
			}
		}
		public function setNextFoo(foo:Function):void
		{
			nextFoo = foo;
		}
		
		private function setPieces(array:Array, points:Array, mode:String = ""):void
		{
			mode = mode.toString();
			var rand:int = 0;
			var currentPiece:* = null;
			var i:* = 0;
			var chosenPoint:Point = new Point();
			var currentCell:Cell = null;
			var tmpList:Array = []; 
			var maxLocLength:int = points.length;
			for (i in array)
			{
				currentPiece = array[i];
				rand = RandomNumber(points.length - 1, 0);
				chosenPoint = points[rand]
				currentCell = field.getTileAt(chosenPoint.y - 1, chosenPoint.x - 1);
				if(!field.setPieceAt(currentPiece.getBattlePiece(), currentCell)){ tmpList.push(currentPiece)  } 
				else{ RemoveFromArray(points, chosenPoint) }
			}
			
			if (tmpList.length > 0){
				setPieces(tmpList, points, mode); 
			}
		}
		
		private function areAllDead(aFighters:Array):Boolean
		{
			var allDead:Boolean = true;
			for (var i:* in aFighters)
			{
				if (aFighters[i].getHp() > 0)
				{
					allDead = false;
				}
				else
				{
				}
			}
			return allDead;
		}
		
		private function switchTurns():void
		{
			if (checkStatus())
			{
				turnSwitching = false; 
				turnSwitch();
			}
			else if (player.getHp() <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, enemyTurnPhases);
				lose();
				
			}
			else if (enemy.getHp() <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, enemyTurnPhases);
				win();
			}
		}
		private function turnDelayFoo():void{
			if (playerIndex >= numPlayers && enemyIndex >= numEnemies){
				playerIndex = 0;
				enemyIndex = 0;
			}
			setTimeout(switchTurns, 1000); 

		}
		private function turnSwitch():void
		{
			if (playerIndex < numPlayers)
			{
				for (var i:int = playerIndex; i < numPlayers; i++)
				{
					player = aPlayers[i];
					player.resetMp();
					player.resetAp();
					player.processCooldowns();
					player.processAfflictions();
					if (player.getHp() > 0 && !player.skipTurn())
					{
						initatePlayerTurn();
						if (i > playerIndex)
						{
							playerIndex = i;
						}
						playerIndex++;
						break;
					}	
				}
				if (i > playerIndex)
				{
					playerIndex = i;
				}
				(playerIndex >= numPlayers && (aPlayers[numPlayers - 1].skipTurn() || aPlayers[numPlayers - 1].getHp() < 0)) ? turnDelayFoo() : null;
			}
			else if (enemyIndex < numEnemies)
			{
				var manuallyTurn:Boolean = false; 
				for (var j:int = enemyIndex; j < numEnemies; j++)
				{
					enemy = aEnemies[j];
					enemy.processCooldowns();
					enemy.resetMp();
					enemy.resetAp();
					enemy.processAfflictions();
					enemyIndex++;
					if (enemy.getHp() > 0 && !enemy.skipTurn())
					{
						initateEnemyTurn();
						break;
					}
					else if (enemy.getHp() <= 0 || enemy.skipTurn()){
						if (j > enemyIndex)
						{
							enemyIndex = j;
						}
						manuallyTurn = true;
						break; 
					}
				}
				if (manuallyTurn){
					turnDelayFoo();
				}
			}
			else{
				enemyIndex = 0;
				playerIndex = 0;
				turnDelayFoo();
			}
		}
		
		private function initatePlayerTurn():void
		{
			player.myTurn = true; 
			gui.updatePlayer(player);
			gui.enable();
		}
		
		private function initateEnemyTurn():void
		{
			enemy.turnComplete = false; 
			enemy.hasMoved = false
			enemy.fooActivated = false; 
			enemy.shouldAttack = true;
			enemy.shouldMove = true;
			enemyTurnStarted = true;
			enemy.brainTick(player, field, aEnemies);
			turnDelayFoo();
		}
		private function enemyTurnPhases(e:Event):void{
			if(enemyTurnStarted){
				if (enemy.turnComplete){
					enemy.turnComplete = false; 
					enemyTurnStarted = false;
					turnDelayFoo();
				}
			}
		}
		
		private function checkStatus():Boolean
		{
			if (areAllDead(aPlayers))
			{
				return false;
			}
			else if (areAllDead(aEnemies))
			{
				//win
				return false;
			}
			else
			{
				return true;
					//switch turns
			}
			return false;
		}
		
		private function win():void
		{
			SndLib.winBattleSnd();
			Main.glblPlayer.changeGold(reward); 
			var tmpPlayers:Array = [];
			var cpyMob:Mob;
			var levelUps:Array = [];
			var currentMob:Mob; 
			expReward = expReward / aPlayers.length; 
			var army:Array = Main.army.getCurrent();
			for (var i:* in aPlayers)
			{
				currentMob = aPlayers[i];
				currentMob.resetStatus();
				if (currentMob.gainExperience(expReward)){
					levelUps.push(currentMob); 
				}
				currentMob.setInitialState();
				cpyMob = new Mob();
				cpyMob.loadMob(currentMob.saveMob());
				tmpPlayers.push(cpyMob);
			}
			if (!isTut)
			{
				addChild(new InBattleRewardScreen(tmpPlayers, reward, expReward, nextFoo));
				if (levelUps.length > 0){
					i = "0";
					for (i in levelUps){
						addChild(Mob(levelUps[i]).levelUp());
					}
				}
			}
			else
			{
				nextFoo();
			}
		}
		
		private function contHandle(e:MouseEvent):void
		{
			nextFoo();
			RemoveSprite(this);
		}
		
		public function setLoseFoo(foo:Function):void
		{
			loseFoo = foo;
		}
		
		private function lose():void
		{
			if (loseFoo == null)
			{
				SndLib.loseBattleSnd();
				darkenScreen("You Lost!", "All your teammates have been wiped out!");
				var tryAgain:Sprite = DrawButton("Try Again", 36);
				var townBtn:Sprite = DrawButton("Back to Battle", 36);
				CenterObjRelTo(tryAgain, overshadow);
				PlaceObjBelowRel(townBtn, townBtn, 20);
				CenterObjRelTo(townBtn, overshadow);
				tryAgain.y = 350;
				addChild(tryAgain);
				if(!tryAgain.hasEventListener(MouseEvent.CLICK)){
					tryAgain.addEventListener(MouseEvent.CLICK, resetBattle(tryAgain, townBtn));
				}
			}
			else
			{
				loseFoo();
			}
		
		}
		
		private function goBackToTownFoo(e:MouseEvent):void
		{
			for (var i:* in aPlayers)
			{
				aPlayers[i].resetMob();
			}
			this.parent.parent.removeChild(this.parent);
		}
		
		private function resetBattle(townBtn:Sprite, tryAgainBtn:Sprite):Function
		{
			return function(e:MouseEvent):void{
				removeDarkenScreen();
				RemoveSprite(tryAgainBtn);
				RemoveSprite(townBtn);
				Main.sndConfig.playSound(battleSound);
				gui.disable();
				RemoveSprite(Sprite(e.currentTarget));
				for (var i:* in aPlayers)
				{
					Mob(aPlayers[i]).resetStatus();
				}
				for (var j:* in aEnemies)
				{
					Enemy(aEnemies[j]).resetStatus();
				}
				enemyStartPoints = [new Point(3, 3), new Point(6, 3), new Point(9, 3), new Point(12, 3), new Point(3, 5), new Point(6, 5), new Point(9, 5), new Point(12, 5)];
				playerStartPoints = [new Point(3, 11), new Point(6, 11), new Point(9, 11), new Point(12, 11), new Point(3, 13), new Point(6, 13), new Point(9, 13), new Point(12, 13)];
				setPieces(aPlayers, playerStartPoints);
				setPieces(aEnemies, enemyStartPoints);
				field.restoreField();
				playerIndex = 0;
				enemyIndex = 0;
				playerTurn = true;
				switchTurns();
			}
		}
		
		private function darkenScreen(header:String, msg:String):void
		{
			addChild(overshadow);
			addChild(prompt);
			addChild(promptDesc);
			
			prompt.text = header;
			promptDesc.text = msg;
		
		}
		
		private function removeDarkenScreen():void
		{
			prompt.text = "";
			promptDesc.text = "";
			RemoveSprite(overshadow);
			RemoveSprite(prompt);
			RemoveSprite(promptDesc);
		}
		
		private function showContestants():void
		{
			var playerIcons:Array = [];
		
		}
	
	}
}
import Assets.Item;
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.DrawBorder;
import Assets.Utility.DrawSquare;
import Assets.Utility.DrawText;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.events.Event;
import Assets.Utility.ConvertEmbedToSprite;
import flash.geom.Point;
import Assets.Utility.RemoveSprite;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import Assets.Utility.PlaceObjNextTo;
import Assets.Utility.DrawBorder;
import Assets.Utility.DrawSquare;
import Assets.Utility.DrawText;
import Assets.Utility.DrawTextArea;
import Assets.Utility.StandardTextFormat;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.text.TextField;
import Assets.Effects.DropShadow;
import flash.events.Event;
import Screens.*;
import flash.display.Sprite;
import Assets.Utility.RemoveSprite;
import flash.text.TextField;
import Assets.Utility.DrawText;
import Assets.Utility.*;
import flash.events.MouseEvent;
import flash.geom.Point;

class ContestantScreen extends Sprite
{
	private var playerIcons:Array = [];
	private var enemyIcons:Array = [];
	private var playerSpr:Sprite = new Sprite();
	private var enemySpr:Sprite = new Sprite();
	private var bkgrnd:Sprite = DrawSquare(400, 150);
	private var versusTag:TextField = DrawText("Vs", 36);
	private var leftRule:Sprite = DrawSquare(150, 1, 0xffffff);
	private var rightRule:Sprite = DrawSquare(150, 1, 0xffffff);
	[Embed(source = "pics/EquipmentWindow.png")]
	private var img:Class;
	private var viewedItemWindow:EquipmentWindow;
	private var selectedItemWindow:Sprite = new Sprite();
	private var inventoryItemWindow:InventoryWindow = new InventoryWindow();
	private var statsWindow:Sprite = new Sprite();
	private var viewItemPos:Point = new Point();
	private var selectedItemPos:Point = new Point();
	private var inventoryItemPos:Point = new Point();
	private var mainPlayer:Mob = new Mob();
	private var overshadow:Sprite = DrawSquare(540, 540);
	
	public function ContestantScreen(players:Array, enemies:Array)
	{
		mainPlayer = players[0];
		DrawBorder(bkgrnd, 1, 0xffffff);
		var playerY:int = bkgrnd.height - 36 - 10;
		var enemyY:int = 10;
		var versusY:int = (bkgrnd.height / 2 - versusTag.height / 2);
		CenterObjRelTo(versusTag, bkgrnd);
		leftRule.y = versusY + versusTag.height / 2;
		rightRule.y = versusY + versusTag.height / 2;
		leftRule.x = 5;
		rightRule.x = bkgrnd.width - rightRule.width - 5;
		var i:*;
		var currentIcon:BattlePiece;
		
		for (i in players)
		{
			currentIcon = Mob(players[i]).getBattlePiece();
			currentIcon.addEventListener(MouseEvent.ROLL_OVER, showEquipmentWin);
			currentIcon.y = playerY;
			if (i > 0)
			{
				PlaceObjNextTo(currentIcon, Mob(players[i - 1]).getBattlePiece(), 0);
			}
			else
			{
				currentIcon.x = 10;
			}
			currentIcon.addEventListener(MouseEvent.CLICK, editUnit);
			playerIcons.push(currentIcon)
			playerSpr.addChild(currentIcon);
		}
		currentIcon = null;
		for (i in enemies)
		{
			currentIcon = enemies[i].getBattlePiece();
			currentIcon.y = enemyY;
			if (i > 0)
			{
				currentIcon.x = (enemies[i - 1].getBattlePiece().x) - currentIcon.width
			}
			else
			{
				currentIcon.x = (bkgrnd.width - currentIcon.width);
			}
			enemyIcons.push(currentIcon);
			enemySpr.addChild(currentIcon);
		}
		bkgrnd.alpha = 0.7;
		addChild(bkgrnd);
		//CenterObjRelTo(playerSpr, bkgrnd);
		//CenterObjRelTo(enemySpr, bkgrnd);
		CenterObjRelTo(versusTag, bkgrnd);
		enemySpr.x += 15;
		playerSpr.x = enemySpr.x;
		versusTag.y = versusY;
		addChild(playerSpr)
		addChild(enemySpr);
		addChild(versusTag);
		addChild(leftRule);
		addChild(rightRule);
		addEventListener(Event.REMOVED_FROM_STAGE, restoreBattlePieces);
		addEventListener(Event.REMOVED_FROM_STAGE, closeHandle);
	}
	
	private function showInventory(player:Mob):void
	{
		addChild(inventoryItemWindow);
		inventoryItemWindow.setMob(player);
		inventoryItemWindow.x = (540 / 2 - inventoryItemWindow.width / 2) - 60;
		inventoryItemWindow.y = -150;
	}
	
	private function showEquipmentWin(e:MouseEvent):void
	{
		var tgt:BattlePiece = e.currentTarget as BattlePiece;
		var mob:Mob = tgt.mob;
		viewedItemWindow = new EquipmentWindow(mob);
		viewedItemWindow.x = bkgrnd.width / 2 - viewedItemWindow.width / 2;
		viewedItemWindow.y = tgt.y + tgt.height + 5;
		addChild(viewedItemWindow);
		//e.currentTarget.addEventListener(MouseEvent.ROLL_OUT, removeEquipmentWin(viewedItemWindow))
	}
	
	private function editUnit(e:MouseEvent):void
	{
		var bp:BattlePiece = e.currentTarget as BattlePiece;
		overshadow.alpha = 0.85;
		var cpyMob:Mob = new Mob();
		cpyMob.loadMob(bp.mob.saveMob());
		var equipWin:EquipSoldier = new EquipSoldier(cpyMob);
		equipWin.addEventListener(Event.REMOVED_FROM_STAGE, stopEditingUnit);
		this.parent.addChild(overshadow);
		this.parent.addChild(equipWin);
	}
	
	private function stopEditingUnit(e:Event):void
	{
		var equipWin:EquipSoldier = e.currentTarget as EquipSoldier;
		var equipMob:Mob = equipWin.mob;
		var currentIcon:BattlePiece;
		RemoveSprite(overshadow);
		for (var i:* in playerIcons)
		{
			currentIcon = playerIcons[i];
			currentIcon.resetBattlePiece();
			if (currentIcon.mob.getName() == equipMob.getName())
			{
				currentIcon.mob.loadMob(equipMob.saveMob());
			}
			currentIcon.y = bkgrnd.height - 36 - 10;
			if (i > 0)
			{
				PlaceObjNextTo(currentIcon, BattlePiece(playerIcons[i - 1]), 0);
			}
			else
			{
				currentIcon.x = 10;
			}
			addChild(currentIcon);
		}
	}
	
	private function restoreBattlePieces(e:Event):void
	{
		while (playerSpr.numChildren > 0)
		{
			playerSpr.getChildAt(0).y = 0;
			playerSpr.getChildAt(0).x = 0;
			playerSpr.removeChildAt(0);
		}
		
		while (enemySpr.numChildren > 0)
		{
			enemySpr.getChildAt(0).y = 0;
			enemySpr.getChildAt(0).x = 0;
			enemySpr.removeChildAt(0);
		}
	}
	
	private function showWind(e:Event):void
	{
		viewedItemWindow.x = viewItemPos.x;
		viewedItemWindow.y = viewItemPos.y;
		addChild(viewedItemWindow);
	}
	
	private function closeHandle(e:Event):void
	{
		var currentIco:BattlePiece;
		for (var i:* in playerIcons)
		{
			currentIco = playerIcons[i];
			;
			currentIco.removeEventListener(MouseEvent.CLICK, showEquipmentWin);
			currentIco.removeEventListener(MouseEvent.CLICK, editUnit);
		}
	}
}

class EquipSoldier extends Sprite
{
	private var inventorywin:InventoryWindow;
	private var mobEquipWindow:EquipmentWindow;
	private var soldierName:TextField;
	private var mobIconWindow:Sprite = new Sprite();
	private var closeBtn:Sprite = DrawButton("Close", 24);
	private var overshadow:Sprite = DrawSquare(540, 540);
	;
	public var soldierStartPos:Point = new Point();
	public var soldierDim:Object = {width: 0, height: 0};
	private var statsWin:ScreenBackground = new ScreenBackground({width: 200, height: 200}, 0xffffff, 0xfffff);
	private var tfStats:TextField = DrawTextArea(200, 200, 20, "center");
	public var mob:Mob;
	private var quickslotWin:QuickslotWindow;
	private var tfQuickslot:TextField = DrawText("Quickslots", 15);
	
	public function EquipSoldier(soldier:Mob)
	{
		
		mob = soldier;
		quickslotWin = new QuickslotWindow(mob);
		var stats:Object = mob.getStatus();
		DropShadow(statsWin);
		statsWin.addChild(tfStats);
		tfStats.text = "";
		tfStats.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
		for (var i:* in stats)
		{
			tfStats.appendText(i + ": " + stats[i].toString() + "\n");
		}
		soldierDim.width = soldier.getBattlePiece().width;
		soldierDim.height = soldier.getBattlePiece().height;
		soldierStartPos.x = soldier.getBattlePiece().x;
		soldierStartPos.y = soldier.getBattlePiece().y;
		overshadow.alpha = 0;
		//add an overshadow over the tank hanger so you can't click any other soldier
		
		mobEquipWindow = new EquipmentWindow(soldier);
		RemoveSprite(soldier.getBattlePiece());
		mobIconWindow = soldier.getBattlePiece();
		mobIconWindow.width = 120;
		mobIconWindow.height = 100;
		inventorywin = new InventoryWindow()
		inventorywin.width = 220 + 70;
		inventorywin.height = 90 + 30;
		soldierName = DrawText("Outfit Soldier", 36);
		DropShadow(soldierName);
		/*
		   position them
		 */
		mobIconWindow.x = 80;
		mobIconWindow.y = 80;
		
		PlaceObjBelowRel(mobEquipWindow, mobIconWindow);
		CenterObjRelTo(mobEquipWindow, mobIconWindow);
		mobEquipWindow.x -= 25
		PlaceObjNextTo(inventorywin, mobEquipWindow, 60);
		inventorywin.y = mobIconWindow.y;
		PlaceObjBelowRel(statsWin, inventorywin);
		CenterObjRelTo(statsWin, inventorywin);
		statsWin.x += 30;
		closeBtn.x = 540 / 2 - closeBtn.width / 2;
		closeBtn.y = 420;
		closeBtn.addEventListener(MouseEvent.CLICK, closeWindow);
		soldierName.x = 540 / 2 - soldierName.width / 2;
		soldierName.y = 30;
		DropShadow(mobIconWindow);
		inventorywin.setInventory(Main.glblPlayer.inventory);
		inventorywin.setEquipWin(mobEquipWindow);
		CenterObjRelTo(quickslotWin, mobIconWindow);
		
		quickslotWin.x -= 90;
		PlaceObjBelowRel(quickslotWin, mobEquipWindow, 20);
		CenterObjRelTo(tfQuickslot, quickslotWin);
		tfQuickslot.y = quickslotWin.y - tfQuickslot.height;
		quickslotWin.setInventoryWin(inventorywin);
		inventorywin.setQuickslotWin(quickslotWin);
		/* add them */
		
		addChild(mobEquipWindow);
		
		addChild(soldierName);
		addChild(closeBtn);
		addChild(statsWin);
		addChild(quickslotWin);
		addChild(tfQuickslot);
		addChild(inventorywin);
		addChild(mobIconWindow);
		mobIconWindow.addEventListener(MouseEvent.CLICK, closeWindow);
		statsWin.addEventListener(Event.ENTER_FRAME, updateStats);
	}
	
	private function updateStats(e:Event):void
	{
		var hoveredItem:*; 
		if (inventorywin.hoveredItem != null){
			
			hoveredItem = inventorywin.hoveredItem ;
			tfStats.text = hoveredItem.getCompleteDesc();
		}
		else if (quickslotWin.hoveredItem != null){
			tfStats.text = "";
			hoveredItem = quickslotWin.hoveredItem;
			tfStats.text = hoveredItem.getCompleteDesc()
		}
		else{
			var stats:Object = mob.getStatus();
			tfStats.text = "";
			tfStats.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
			for (var i:* in stats)
			{
				tfStats.appendText(i + ": " + stats[i].toString() + "\n");
			}
		}
	}
	
	private function closeWindow(e:MouseEvent):void
	{
		statsWin.removeEventListener(Event.ENTER_FRAME, updateStats);
		RemoveSprite(this);
	}
}