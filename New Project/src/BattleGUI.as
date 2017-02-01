package
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.CheckBox;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.RemoveSprite;
	import Screens.NotifyMessage;
	import Screens.TownDescriptionScreen;
	import Towns.MissionStruct;
	import Towns.subMapScreen;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import Assets.Utility.PlaceObjNextTo;
	import Assets.Utility.UtilButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Screens.HelpScreen;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	   Graphic User Interface - Battle Only
	 */
	public class BattleGUI extends Sprite
	{
		//player // 
		private var player:Mob = null;
		private var currentLocation:Cell = null;
		
		//utility // 
		private var btnSize:int = 35;
		private var field:Field = null;
		private var endFoo:Function = null;
		
		// phenetics // 
		private var hpBar:Sprite = new Sprite();
		private var manaBar:Sprite = new Sprite();
		private var sprSkillSlots:QuickSlots;
		private var runBtn:UtilButton = new UtilButton("Run", btnSize);
		private var endTurnBtn:UtilButton = new UtilButton("End Turn", btnSize);
		private var lbl_ap:TextField = DrawText("AP  ", 20, "center", "unzialish");
		private var df_ap:TextField = DrawText("0", 20, "center", "unzialish");
		private var cancelBtn:UtilButton = new UtilButton("Cancel", 20)
		private var df_mp:TextField = DrawText("0", 20, "center", "unzialish");
		private var lbl_mp:TextField = DrawText("MP  ", 20, "center", "unzialish");
		private var lbl_hp:TextField = DrawText("HP  ", 20, "center", "unzialish");
		private var df_hp:TextField = DrawText("000%", 20, "center", "unzialish");
		public var moving:Boolean = false;
		private var helpBtn:Sprite = DrawButton("?", 20);
		[Embed(source = "pics/barBackground.png")]
		private var barBackground:Class;
		[Embed(source = "pics/manaBar.png")]
		private var manaBarPic:Class;
		[Embed(source = "pics/healthBar.png")]
		private var healthBarPic:Class;
		private var checkHasMovedHandle:Function;
		private var animationTimer:int = 80;
		[Embed(source = "pics/skills icon/bleeding heart.png")]
		private var bleedigHeart:Class;
		[Embed(source = "pics/skills icon/fire strike.png")]
		private var fireStrike:Class;
		[Embed(source = "pics/skills icon/ice attack.png")]
		private var iceAttack:Class;
		[Embed(source = "pics/skills icon/poison.png")]
		private var poison:Class;
		[Embed(source = "pics/strengthUpIcon.png")]
		private var strengthUpIcon:Class;
		[Embed(source = "pics/wisdomUpIcon.png")]
		private var wisdomUpIcon:Class;
		[Embed(source = "pics/defenseDownIcon.png")]
		private var defenseDownIcon:Class;
		[Embed(source = "pics/defenseUpIcon.png")]
		private var defenseUpIcon:Class;
		[Embed(source = "pics/dexterityUpIcon.png")]
		private var dexterityUpIcon:Class;
		[Embed(source = "pics/constitutionDownIcon.png")]
		private var constitutionDownIcon:Class;
		[Embed(source = "pics/consitutionUpIcon.png")]
		private var constitutionUpIcon:Class;
		[Embed(source = "pics/skills icon/stun strike.png")]
		private var stunStrike:Class;
		[Embed(source = "pics/skills icon/rage.png")]
		private var rage:Class;
		[Embed(source = "pics/skills icon/fear.png")]
		private var fearIcon:Class; 
		private var effectsList:Object = {"fear":fearIcon, "wisdom up": wisdomUpIcon, "rage": rage, "strength up": strengthUpIcon, "consitution up": constitutionUpIcon, "consitution down": constitutionDownIcon, "defense up": defenseUpIcon, "defense down": defenseDownIcon, "poisoned": poison, "dexterity up": dexterityUpIcon, "bleeding": bleedigHeart, "frozen": iceAttack, "burning": fireStrike, "stunned": stunStrike};
		private var tfName:TextField = DrawTextArea(60, 15, 12, "center");
		private var aEffects:Object = {};
		private var effectsSprite:Sprite = new Sprite();
		private var tfturnAnncounce:TextField;
		private var turnAnnounceTimer:Timer = new Timer(1500);
		
		private var runWarning:Boolean = false;
		
		public function BattleGUI(_field:Field, _player:Mob, tut:Boolean = false)
		{
			//*************** assign variables ***************/
			field = _field;
			player = _player;
			sprSkillSlots = new QuickSlots(player, field);
			var hpBackground:Sprite = ConvertEmbedToSprite(barBackground);
			var manaBackground:Sprite = ConvertEmbedToSprite(barBackground);
			hpBar = ConvertEmbedToSprite(healthBarPic);
			hpBar.width = field.width;
			hpBar.height = 15;
			hpBackground.width = field.width;
			hpBackground.height = 15;
			manaBar = ConvertEmbedToSprite(manaBarPic);
			manaBar.width = field.width;
			manaBar.height = 15;
			manaBackground.width = field.width;
			manaBackground.height = manaBar.height;
			//*************** configure children  ***************/
			// ap label //
			PlaceObjNextTo(lbl_ap, field, 27);
			lbl_ap.x -= 20
			lbl_ap.y = 139;
			
			// place ap text box // 
			lbl_mp.x = 5;
			lbl_mp.y = lbl_ap.y;
			
			// ap text box // 
			PlaceObjBelowRel(df_ap, lbl_ap);
			CenterObjRelTo(df_ap, lbl_ap);
			
			//place mp text box //
			CenterObjRelTo(df_mp, lbl_mp);
			PlaceObjBelowRel(df_mp, lbl_mp);
			
			// hp bar // 
			hpBar.y = 20;
			hpBar.x = field.x;
			hpBackground.y = hpBar.y;
			hpBackground.x = hpBar.x;
			
			// mana bar // 
			manaBar.x = hpBar.x;
			manaBar.y = hpBar.y + hpBar.height;
			manaBackground.y = manaBar.y;
			manaBackground.x = manaBar.x;
			
			// move button //
			runBtn.x = 5;
			runBtn.y = 510;
			
			// end turn button //
			endTurnBtn.x = 540 - endTurnBtn.width - 10;
			endTurnBtn.y = runBtn.y;
			
			// skill slots // 
			sprSkillSlots.x = Math.abs(540 / 2 - sprSkillSlots.width / 2) - 30;
			sprSkillSlots.y = (540 - sprSkillSlots.height);
			
			// cancel button //
			CenterObjRelTo(cancelBtn, sprSkillSlots);
			cancelBtn.y = runBtn.y - cancelBtn.height - 7;
			
			cancelBtn.disable();
			
			PlaceObjNextTo(helpBtn, hpBar, 10);
			helpBtn.y += 17;
			tfturnAnncounce = new TextField();
			tfturnAnncounce.x = 540 / 2 - tfturnAnncounce.width / 2;
			tfturnAnncounce.y = 540/2 - tfturnAnncounce.height/2;
			//******************* Add Cancel Handle on all Tiles ******************/
			for (var row:int = 0; row < 13; ++row)
			{
				for (var col:int = 0; col < 14; ++col)
				{
					field.getTileAt(row, col).addEventListener(MouseEvent.CLICK, cellActions);
				}
			}
			//*************** add children ***************/
			//addChild(cancelBtn);
			addChild(sprSkillSlots);
			addChild(runBtn); //*********** THIS IS THE RUN BUTTON ***************///
			addChild(endTurnBtn);
			//addChild(hpBar);
			addChild(helpBtn);
			
			(tut) ? addChild(new HelpScreen()) : null;
			//*************** add handles & initial state ***************/
			
			sprSkillSlots.addEventListener(Event.ENTER_FRAME, checkIsAttacking);
			hpBar.addEventListener(Event.ENTER_FRAME, updateHpBar);
			helpBtn.addEventListener(MouseEvent.CLICK, showHelpImage);
			helpBtn.addEventListener(MouseEvent.MOUSE_OVER, changeHelpBtnOver);
			helpBtn.addEventListener(MouseEvent.MOUSE_OUT, changeHelpBtnOut);
			
			GlowObj(helpBtn, 0xffffff);
			GlowObj(hpBar, 0xff0000, 10);
			addChild(effectsSprite);
			
			///** Effects Icons ** // 

			runBtn.addEventListener(MouseEvent.CLICK, runHandle);
			
			df_hp.textColor = 0xff0000;
			lbl_hp.textColor = 0xff0000;
			
			df_mp.textColor = 0x00ff00;
			lbl_mp.textColor = 0x00ff00;
			
			df_ap.textColor = 0x81DAF5;
			lbl_ap.textColor = 0x81DAF5;
			
			GlowObj(df_hp, 0xff0000)
			GlowObj(lbl_hp, 0xff0000)
			
			GlowObj(df_mp, 0x00ff00)
			GlowObj(lbl_mp, 0x00ff00)
			
			GlowObj(df_ap, 0x00BFFF)
			GlowObj(lbl_ap, 0x00BFFF)
			
			var lbl_y:int = 20;
			df_hp.x = 0;
			df_hp.y = lbl_y;
			
			df_mp.x = 0
			df_mp.y = lbl_y
			
			df_ap.x = 0;
			df_ap.y = lbl_y;
			
			lbl_hp.x = 0;
			lbl_hp.y = lbl_y;
			
			lbl_mp.x = 0;
			lbl_mp.y = lbl_y;
			
			lbl_ap.x = 0;
			lbl_ap.y = lbl_y;
			
			PlaceObjNextTo(df_hp, lbl_hp);
			PlaceObjNextTo(lbl_mp, df_hp);
			PlaceObjNextTo(df_mp, lbl_mp);
			PlaceObjNextTo(lbl_ap, df_mp);
			PlaceObjNextTo(df_ap, lbl_ap);
			
			var lbls:Sprite = new Sprite();
			lbls.addChild(df_hp)
			lbls.addChild(df_mp)
			lbls.addChild(df_ap)
			lbls.addChild(lbl_hp)
			lbls.addChild(lbl_ap)
			lbls.addChild(lbl_mp)
			
			lbls.x = 540 / 2 - lbls.width / 2;
			
			addChild(lbls);
			endTurnBtn.addEventListener(MouseEvent.CLICK, endTurn);
			addEventListener(Event.ENTER_FRAME, showIndicator);
			showEffects();
		
		}
		private function showEffects():void{
			var currentSpr:Sprite = new Sprite();
			var origX:int = sprSkillSlots.x + 5;;
			var origY:int = (sprSkillSlots.y - 15)
			var n:int = 1;
			var maxWidth:int = 0;
			for (var i:* in effectsList)
			{
				currentSpr = new EffectsIco(effectsList[i], i);
				currentSpr.x = origX + (15 * n);
				currentSpr.y = origY - 1.5
				aEffects[i] = currentSpr;
				addChild(aEffects[i]);
				aEffects[i].alpha = 0.0;
				maxWidth += currentSpr.width;
				n++;
			}
		}
		private function clearListeners(e:Event):void
		{
			sprSkillSlots.removeEventListener(Event.ENTER_FRAME, checkIsAttacking);
			hpBar.removeEventListener(Event.ENTER_FRAME, updateHpBar)
		}
		
		private function showIndicator(e:Event):void
		{
			
			if (player != null)
			{
				if (player.getBattlePiece().getCellLocation() != null)
				{
					player.getBattlePiece().getCellLocation().flashCellHighlight();
				}
			}
		}
		private function refreshCells():void{
			for (var row:int = 0; row < 13; ++row)
			{
				for (var col:int = 0; col < 12; ++col)
				{
					if (field.getTileAt(row, col).hasEventListener(MouseEvent.CLICK)){
						field.getTileAt(row, col).removeEventListener(MouseEvent.CLICK, cellActions);
					}
					field.getTileAt(row, col).addEventListener(MouseEvent.CLICK, cellActions);
				}
			}
		}
		private function cellActions(e:MouseEvent):void
		{
			var cell:Cell = e.currentTarget as Cell;
			var currentPiece:BattlePiece = cell.getPiece(); 
			if (cell.hasPiece() && currentPiece == player.getBattlePiece())
			{
				player.getBattlePiece().resetDimensions();
				if (!sprSkillSlots.isAttacking && cell.getPiece() == player.getBattlePiece() && player.getMp() > 0)
				{
					move();
				}
				else if (!moving && sprSkillSlots.isAttacking && Mob(cell.getPiece().mob).mobType.toLowerCase() == "player")
				{
					cancelFoo();
				}
			}
			else
			{
				if (moving)
				{
					if (!cell.isMoveable())
					{
						cancelFoo();
					}
				}
				else if (sprSkillSlots.isAttacking)
				{
					if (!cell.isAttackable())
					{
						cancelFoo();
					}
				}
			}
			if (currentPiece != player.getBattlePiece() && currentPiece != null){ 
				currentPiece.alpha = 1; 
			}
		}
		
		private function secondaryCancel(e:MouseEvent):void
		{
			var cell:Cell = e.currentTarget as Cell;
			if (!cell.isMoveable() && !cell.isAttackable())
			{
				cancelFoo();
			}
		}
		
		private function changeHelpBtnOver(e:MouseEvent):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			RemoveFilters(spr);
			GlowObj(spr, 0x00ff00);
		}
		
		private function changeHelpBtnOut(e:MouseEvent):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			RemoveFilters(spr);
			GlowObj(spr, 0xffffff);
		}
		
		private function showHelpImage(e:MouseEvent):void
		{
			addChild(new HelpScreen());
		}
		
		private function updateHpBar(e:Event):void
		{
			/*
			 * Self Explanatory
			 * */
			df_ap.text = player.getAp().toString();
			df_mp.text = player.getMp().toString();
			var percentage:Number = Math.floor(player.getHp() / player.getMaxHp() * 100);
			df_hp.text = percentage.toString() + "%"
		}
		
		public function updatePlayer(_player:Mob):void
		{
			/*
			 * Self Explanatory
			 * * Updates the skill slots to point to the new player, changes the current player object
			 * */
			enable();
			refreshCells();
			addChild(endTurnBtn);
			var cellState:String = (player.getBattlePiece().getCellLocation().getCellState().toLowerCase());
			if (cellState != "")
			{
				if (cellState == "poison")
				{
					player.changeHp(-3);
					player.getBattlePiece().showDamage(3);
				}
				else if (cellState == "fire")
				{
					player.changeHp(-3);
					player.getBattlePiece().showDamage(3);
				}
			}
			sprSkillSlots.clear();
			player = _player;
			RemoveSprite(tfturnAnncounce);
			announceTurn();
			player.getBattlePiece().getCellLocation().highlightCellAsTurn();
			sprSkillSlots.updatePlayer(player);
			sprSkillSlots.refresh();
			addEventListener(Event.REMOVED_FROM_STAGE, clearListeners);
		}
		
		public function announceTurn():void
		{
			tfturnAnncounce = DrawText(player.getName() + "'s Turn", 24, "center", "unzialish");
			DropShadow(tfturnAnncounce);
			tfturnAnncounce.x = 540 / 2 - tfturnAnncounce.width / 2;
			tfturnAnncounce.y = 540/2 + tfturnAnncounce.height/2- 100 ;
			addChild(tfturnAnncounce);
			setTimeout(removeAnnounceSpr, 1000);
		}
		
		private function removeAnnounceSpr():void
		{
			
			RemoveSprite(tfturnAnncounce);
		}
		
		public function setEndFoo(foo:Function):void
		{
			/*
			 * The End Function represents the "Switch Turn"() function in the Battle Class.
			 * */
			endFoo = foo;
		}
		
		private function runHandle(e:MouseEvent):void
		{
			if (!runWarning)
			{
				var notifyWin:TownDescriptionScreen = new TownDescriptionScreen(null, "If you run from the battle you will have to restart the mission and you will lose all experience gained during the mission.\n\nPress 'Run' again if you want to run.");
				notifyWin.x = 540 / 2 - notifyWin.width / 2;
				notifyWin.y = 540 / 2 - notifyWin.height / 2;
				addChild(notifyWin);
				runWarning = true;
				
			}
			else
			{
				var abandonWin:TownDescriptionScreen = new TownDescriptionScreen(null, "You've abandoned the mission!");
				abandonWin.x = 540 / 2 - abandonWin.width / 2;
				abandonWin.y = 520 / 2 - abandonWin.height / 2;
				this.parent.parent.addChild(abandonWin);
				var map:Map = MissionStruct(this.parent.parent.parent).map
				map.currentSub.onMission = false;
				map.currentSub.enable();
				(this.parent.parent.parent.parent).addChild(map);
				
				RemoveSprite(this.parent.parent.parent);
				
			}
		}
		
		private function endTurn(e:MouseEvent):void
		{
			/*
			 * Disables the gui
			 *
			 * */
			if (!moving && !sprSkillSlots.isAttacking)
			{
				cancelFoo();
				player.getBattlePiece().getCellLocation().clearIndicator();
				RemoveSprite(tfturnAnncounce);
				sprSkillSlots.clear();
				disable();
				RemoveSprite(endTurnBtn);
				endFoo();
				
				field.setCellAtTop(player.getBattlePiece().getCellLocation());
			}
			//	setTimeout(function():void { }, 1000);
		}
		
		private function move():void
		{
			/*
			 * Move Button handle
			 */
			if (!moving && !sprSkillSlots.isAttacking && endFoo != null)
			{
				moving = true;
				//record the player's location
				// show the movement range
				//field.refreshField();
				var movementTiles:Array = field.showAvailableMovement(player.getBattlePiece());
				// check if the player's location is different
				checkHasMovedHandle = checkHasMoved(movementTiles);
				this.addEventListener(Event.ENTER_FRAME, checkHasMovedHandle);
			}
		}
		
		private function checkIsAttacking(e:Event):void
		{
			
			// if the player is attacking, activate the cancel button
			if (sprSkillSlots.isAttacking || moving)
			{
				runBtn.disable();
				sprSkillSlots.disable();
				endTurnBtn.disable();
			}
			else
			{
				cancelBtn.disable();
				cancelBtn.removeEventListener(MouseEvent.CLICK, cancelHandle);
				sprSkillSlots.enable();
				runBtn.enable();
				endTurnBtn.enable();
			}
		}
		
		private function activateCancelButton():void
		{
			// enables the cancel button 
			endTurnBtn.alpha = 0.5;
		}
		
		private function checkHasMoved(movementTiles:Array):Function
		{
			var spr:* = this;
			return function(e:Event):void
			{
				// if the player's primary location is different than the new location, stop the event listener
				var battlePiece:BattlePiece = player.getBattlePiece();
				if ((player.hasMoved || !moving) && !player.movementBegun)
				{
					for (var i:* in movementTiles)
					{
						movementTiles[i].obj.removeEventListener(MouseEvent.CLICK, movementTiles[i].foo);
						Cell(movementTiles[i].obj).transform.colorTransform = new ColorTransform();
					}
					player.hasMoved = false;
					moving = false;
					endTurnBtn.enable();
					runBtn.enable();
					sprSkillSlots.enable();
					// stop the event listener
					spr.removeEventListener(Event.ENTER_FRAME, checkHasMovedHandle);
					spr.removeEventListener(Event.ENTER_FRAME, checkHasMoved);
					
					removeEventListener(Event.ENTER_FRAME, checkHasMovedHandle);
					removeEventListener(Event.ENTER_FRAME, checkHasMoved);
					//update the location
					currentLocation = battlePiece.getCellLocation();
					battlePiece.getCellLocation().highlightCellAsTurn();
					field.resetFieldCells();
						// disable the move button 
					
				}
				else
				{
					sprSkillSlots.disable();
				}
			};
		}
		
		private function cancelHandle(e:MouseEvent):void
		{
			cancelFoo();
		}
		
		public function cancelFoo():void
		{
			// cancel movement 
			if (moving)
			{
				
				field.resetFieldCells();
				sprSkillSlots.enable();
				moving = false;
				endTurnBtn.alpha = 1;
				player.getBattlePiece().getCellLocation().isIndicator = false;
				
			}
			// cancel the current attack
			else if (sprSkillSlots.isAttacking)
			{
				sprSkillSlots.isAttacking = false;
				sprSkillSlots.resetBattleFieldWithoutHandle();
			}
			
			field.resetFieldCells();
			//disable the cancel button 
			cancelBtn.alpha = 0.5; //indicate the cancel button is off
			cancelBtn.disable();
			cancelBtn.removeEventListener(MouseEvent.CLICK, cancelHandle);
		}
		
		public function disable():void
		{
			//disable the gui 
			runBtn.alpha = 0.5;
			endTurnBtn.alpha = 0.5;
			moving = false;
			runBtn.disable();
			endTurnBtn.disable();
			//remove end turn event listeners 
			// disable the skill shots
			sprSkillSlots.disable();
			//	sprSkillSlots.removeEventListener(Event.ENTER_FRAME, checkIsAttacking);
			// remove the gui's event listeners
			this.removeEventListener(Event.ENTER_FRAME, checkHasMoved);
			// if the cancel button is activated, remove its listeners
			cancelBtn.hasEventListener(MouseEvent.CLICK) ? cancelBtn.addEventListener(MouseEvent.CLICK, cancelHandle) : null;
			cancelBtn.disable(); //disable the cancel button 
			//remove the check for the player attacking
		
		}
		
		public function enable():void
		{
			moving = false;
			//enable the gui  
			runBtn.alpha = 1;
			endTurnBtn.alpha = 1;
			runBtn.enable();
			endTurnBtn.enable();
			// restore the event listeners to the end turn button 
			
			//enable the skill slot 
			sprSkillSlots.enable();
			// activate teh "check is attacking" event listener 
			if (!sprSkillSlots.hasEventListener(Event.ENTER_FRAME))
			{
				//	sprSkillSlots.addEventListener(Event.ENTER_FRAME, checkIsAttacking);
			}
		
		}
	}
}

import Assets.Item;
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.DrawText;
import Assets.Utility.DrawSquare;
import Assets.Utility.DrawBorder;
import Assets.Utility.DrawTextArea;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import Assets.Utility.RemoveFromArray;
import Assets.Utility.RemoveSprite;
import flash.display.Sprite;
import flash.events.MouseEvent;
import org.flashdevelop.utils.FlashConnect;

import flash.events.Event;

class EffectsIco extends Sprite
{
	private var bkgrnd:Sprite = new Sprite();
	private var tf:TextField;
	
	public function EffectsIco(imgClass:Class, tip:String)
	{
		bkgrnd = ConvertEmbedToSprite(imgClass);
		bkgrnd.width = 16;
		bkgrnd.height = 16;
		addChild(bkgrnd);
		tf = DrawText(tip, 12, "center");
		tf.x -= (tf.width / 2 - bkgrnd.width / 2);
		tf.y = (-tf.height) + 2
		addEventListener(MouseEvent.MOUSE_OVER, showTip);
		addEventListener(MouseEvent.MOUSE_OUT, removeTip);
	}
	
	private function showTip(e:MouseEvent):void
	{
		addChild(tf);
	}
	
	private function removeTip(e:MouseEvent):void
	{
		RemoveSprite(tf);
	}
}

class QuickSlots extends Sprite
{
	/*
	 * The QuickSlot Component
	 */
	// gui
	private var aQuickSlot:Array = [];
	// utility // 
	private var currentPage:int = 1;
	private var field:Field = null;
	private var player:Mob = null;
	public var isAttacking:Boolean = false;
	private var playerAp:int = 0;
	private var desc:QuickSlotDescWin = new QuickSlotDescWin();
	private var checkAp:Function;
	private var attkField:Array = [];
	private var arrayOfEffect:Array = [];
	private var currentSkill:Skill;
	
	public function QuickSlots(_player:Mob, _field:Field)
	{
		// *********** set variables **********/ 
		field = _field;
		player = _player;
		playerAp = player.getAp();
		// *********** set up the gui **********/ 
		var maxQuickSlots:int = 7; // The # of slots per page should not exceed 7
		var slots:Array = player.getQuickSlots();
		var currentSlot:QuickSlot = null;
		for (var i:int = 0; i < maxQuickSlots; i++)
		{
			currentSlot = new QuickSlot();
			currentSlot.x = (currentSlot.width * (i));
			aQuickSlot.push(currentSlot); // add it to the overall list of slots
			currentSlot.addEventListener(MouseEvent.MOUSE_OVER, btnGlow);
			currentSlot.addEventListener(MouseEvent.MOUSE_OUT, stopGlow);
			currentSlot.addEventListener(MouseEvent.MOUSE_DOWN, useQuickSlot);
			//add the gui 
			addChild(currentSlot);
		}
		
		i = 0;
		//assign the objects (skills / items ) to the quickslots
		for (i = 0; i < slots.length; i++)
		{
			currentSlot = aQuickSlot[i];
			if (slots[i] != null && currentSlot != null)
			{
				currentSlot.setObject(slots[i]);
			}
		}
	
	}
	
	public function resetBattleFieldWithoutHandle():void
	{
		var spr:* = this;
		var currentCell:* = null;
		isAttacking = false;
		for (var i:* in arrayOfEffect)
		{
			currentCell = arrayOfEffect[i];
			if (currentCell.hasOwnProperty("obj"))
			{
				currentCell = arrayOfEffect[i].obj;
				if (currentCell.hasEventListener(MouseEvent.CLICK))
				{
					currentCell.removeEventListener(MouseEvent.CLICK, arrayOfEffect[i].foo);
				}
				
				if (currentCell.hasEventListener(MouseEvent.MOUSE_OVER))
				{
					currentCell.removeEventListener(MouseEvent.MOUSE_OVER, field.showVonAttackRange);
					currentCell.removeEventListener(MouseEvent.MOUSE_OUT, field.clearVonAttackRange);
				}
				currentCell.restoreCell();
			}
		}
		refresh();
	
	}
	
	private function resetBattleField(e:Event):void
	{
		if (playerAp != player.getAp() || !isAttacking)
		{
			resetBattleFieldWithoutHandle()
			removeEventListener(Event.ENTER_FRAME, resetBattleField);
		}
	}
	
	private function btnGlow(e:MouseEvent):void
	{
		// self explanatory 
		var obj:Sprite = e.currentTarget as Sprite;
		var topChild:* = this.getChildAt(numChildren - 1);
		this.swapChildren(topChild, obj);
		GlowObj(obj, 0xffdd00, 10);
	
	}
	
	private function stopGlow(e:MouseEvent):void
	{
		//self explanatory 
		var obj:Sprite = e.currentTarget as Sprite;
		RemoveFilters(obj);
	}
	
	public function updatePlayer(newPlayer:Mob):void
	{
		//self explanatory 
		player = newPlayer;
		resetBattleFieldWithoutHandle()
		arrayOfEffect = [];
	}
	
	private function useQuickSlot(e:MouseEvent):void
	{
		// use the object in the quick slot // 
		
		// set the current slot 
		var currentSlot:QuickSlot = e.currentTarget as QuickSlot;
		// get the object in the slot 
		var slotUsage:* = currentSlot.getObject();
		// get the type of object
		
		if (slotUsage != null)
		{
			var objType:String = currentSlot.getObject().getType().toLowerCase();
			
			if (objType == "skill" && !slotUsage.onCooldown() && currentSlot.getObject().getAp() <= player.getAp())
			{
				currentSkill = slotUsage
				var skillName:String = currentSkill.getName();
				playerAp = player.getAp();
				isAttacking = true; //denote using a skill, it doesn't have to be an attack 
				if (slotUsage.getRangeShape() == "allies"  && slotUsage.getRangeShape() != "self")
				{
					arrayOfEffect = field.showAvailableAttackRange(player.getBattlePiece(), slotUsage, "player", null, useSkillOnMisc);
				}
				else if (slotUsage.getRange() != "allies" && slotUsage.getRangeShape() != "self")
				{
					if (slotUsage.getRangeShape() == "all_allies"){
						useOnAllAliies();
					}
					skillName = skillName.toLowerCase();
					if (skillName == "nail arrow" || skillName == "poison arrow" || skillName == "fire arrow")
					{
						arrayOfEffect = field.showAvailableAttackRange(player.getBattlePiece(), slotUsage, "player", null, playerAttackAtGoalVon);
					}

					else
					{
						arrayOfEffect = field.showAvailableAttackRange(player.getBattlePiece(), slotUsage, "player", null, playerAttackAtGoal);
					}
				}
				else
				{
					currentSkill.perform(player);
					resetBattleFieldWithoutHandle();
					currentSkill = null;
					isAttacking = false;
				}
				
			}
			else if (objType == "item")
			{
				Item(slotUsage).setOwner(player);
				Item(slotUsage).useItem();
				player.removeFromQuickSLot(slotUsage);
				refresh();
			}
		}
	}
	
	public function refresh():void
	{
		// update the objects in the slots 
		// if a slot is empty, set that object to null 
		var slots:Array = player.getQuickSlots().slice(0, 7);
		var slotsLength:int = slots.length;
		var currentSlot:QuickSlot = null;
		//they are not the same length, do not confuse the two
		//clear all the objects
		for (var i:* in aQuickSlot)
		{
			currentSlot = aQuickSlot[i];
			if (slots[i] != null)
			{
				currentSlot.clearObject();
				RemoveSprite(currentSlot);
				currentSlot.setObject(slots[i]);
			}
			addChild(currentSlot);
		}
		// set the object
	}
	
	public function disable():void
	{
		//disable the quick slot
		var currentSlot:QuickSlot = null;
		for (var i:* in aQuickSlot)
		{
			currentSlot = aQuickSlot[i];
			currentSlot.disable();
			currentSlot.removeEventListener(MouseEvent.CLICK, useQuickSlot);
			currentSlot.removeEventListener(MouseEvent.ROLL_OVER, btnGlow);
			currentSlot.removeEventListener(MouseEvent.ROLL_OUT, stopGlow);
		}
	
	}
	
	public function enable():void
	{
		//enable the quick slots
		var currentSlot:QuickSlot = null;
		for (var i:* in aQuickSlot)
		{
			currentSlot = aQuickSlot[i];
			currentSlot.enable();
			currentSlot.addEventListener(MouseEvent.CLICK, useQuickSlot);
			currentSlot.addEventListener(MouseEvent.ROLL_OVER, btnGlow);
			currentSlot.addEventListener(MouseEvent.ROLL_OUT, stopGlow);
		}
	}
	
	public function clear():void
	{
		var currentSlot:QuickSlot = null;
		for (var i:* in aQuickSlot)
		{
			currentSlot = aQuickSlot[i];
			currentSlot.clearObject();
		}
	}
	
	public function playerAttackAtGoal(e:MouseEvent):void
	{
		var enemyCell:Cell = e.currentTarget as Cell;
		var attkProcessed:Boolean = false; 
		var currentSkillName:Array = currentSkill.getName().split(" "); 
		if (enemyCell.isAttackable() && (!enemyCell.hasPiece()))
		{
			player.changeAp(currentSkill.getAp() * -1);
			currentSkill.triggerCooldown();
			player.getBattlePiece().showAttackCry("Missed!", 0xffffff); ;
			attkProcessed = true; 
		}
		else if (enemyCell.hasPiece() && enemyCell.getPiece().mob.mobType.toLowerCase() == "enemy" && enemyCell.isAttackable())
		{
			if (currentSkillName[0] == "Double" || currentSkillName[0] == "Triple"){
				attkProcessed = false; 
				currentSkill.callback = multipleAttackCallback; 
			}
			else{
				attkProcessed = true; 
			}
			resetBattleFieldWithoutHandle()
			currentSkill.perform(enemyCell.getPiece().mob);
		}
		if(attkProcessed){
			field.resetFieldCells();
		}
		else{
			isAttacking = true; 
		}
		enemyCell.removeEventListener(MouseEvent.CLICK, playerAttackAtGoal);
		//end return function //
	}
	private function multipleAttackCallback():void{
		isAttacking = false;
		field.resetFieldCells();
		
	}
	
	public function playerAttackAtGoalVon(e:MouseEvent):void
	{
		var cell:Cell = e.currentTarget as Cell;
		var neighbors:Object = field.getVonNeighbors(cell);
		var currentCell:Cell = null;
		var tgt:Array = [];
		var skillName:String = currentSkill.getName().toLowerCase();
		if (skillName == "fire arrow")
		{
			cell.setFireState();
		}
		else if (skillName == "poison arrow")
		{
			cell.setPoisonState();
		}
		for (var i:* in neighbors)
		{
			if (neighbors[i] != null)
			{
				currentCell = neighbors[i];
				
				if (currentCell.hasPiece())
				{
					tgt.push(currentCell.getPiece().mob);
				}
				if (skillName == "fire arrow")
				{
					currentCell.setFireState();
				}
				else if (skillName == "poison arrow")
				{
					currentCell.setPoisonState();
				}
			}
		}
		

		if (cell.hasPiece() && cell.getPiece().mob.mobType.toLowerCase() == "enemy")
		{
			tgt.push(cell.getPiece().mob);
		}
		for (var j:* in tgt)
		{
			if (tgt != null)
			{
				currentSkill.perform(tgt[j]);
			}
		}
		currentSkill.getOwner().changeAp(currentSkill.getAp() * -1);
		currentSkill.triggerCooldown();
		resetBattleFieldWithoutHandle()
		cell.removeEventListener(MouseEvent.CLICK, playerAttackAtGoalVon);
		field.resetFieldCells();
	}
	
	private function useSkillOnMisc(e:MouseEvent):void
	{
		var cell:Cell = Cell(e.currentTarget);
		if (cell.hasPiece())
		{
			currentSkill.perform(cell.getPiece().mob);
		}
		resetBattleFieldWithoutHandle()
		cell.removeEventListener(MouseEvent.CLICK, useSkillOnMisc);
		field.resetFieldCells();
	}

	private function useOnAllAliies():void{
		
		arrayOfEffect = field.getPieceLocations([])[0];
		for (var i:* in arrayOfEffect){
			currentSkill.perform(arrayOfEffect[i].mob); 
		}
		player.changeAp( currentSkill.getAp() * - 1); 
		resetBattleFieldWithoutHandle()
		field.resetFieldCells();
	}
}
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.RemoveSprite;
import Assets.Utility.ConvertEmbedToSprite;
import flash.text.TextField;

class QuickSlot extends Sprite
{
	// ********* The Slot of the Quickslot *************/ 
	
	//utility // 
	private var field:Field = null;
	private var obj:* = null;
	//gui // 
	private var bkgrnd:Sprite = DrawSquare(40, 40, 0x0030aa);
	private var objIco:Sprite = new Sprite();
	[Embed(source = "pics/tab_unselected.png")]
	private var imgClass:Class;
	[Embed(source = "pics/tab_mouseover.png")]
	private var imgClass2:Class;
	private var descWin:QuickSlotDescWin = new QuickSlotDescWin();
	private var cooldownTxt:TextField = DrawText("000", 20, "center");
	
	public function QuickSlot():void
	{
		
		bkgrnd = ConvertEmbedToSprite(imgClass);
		bkgrnd.height = 40;
		bkgrnd.width = 40;
		descWin.y = -descWin.height - 5;
		descWin.x = bkgrnd.width / 2 - descWin.width / 2;
		
		cooldownTxt.x = bkgrnd.width / 2 - cooldownTxt.width / 2;
		cooldownTxt.y = 5 + (bkgrnd.height / 2 - cooldownTxt.height / 2);
		addChild(bkgrnd);
		addEventListener(MouseEvent.ROLL_OVER, onHover);
		addEventListener(MouseEvent.ROLL_OUT, onOut);
		addEventListener(MouseEvent.CLICK, inUse);
		//addEventListener(Event.ENTER_FRAME, updateCooldown);
	}
	
	public function enable():void
	{
		alpha = 1;
	}
	
	public function disable():void
	{
		alpha = 0.5;
	}
	
	private function inUse(e:MouseEvent):void
	{
		RemoveSprite(descWin);
	}
	
	private function onHover(e:MouseEvent):void
	{
		RemoveSprite(bkgrnd);
		RemoveSprite(objIco);
		RemoveSprite(descWin);
		RemoveSprite(cooldownTxt);
		bkgrnd = ConvertEmbedToSprite(imgClass2);
		bkgrnd.height = 40;
		bkgrnd.width = 40;
		
		addChild(bkgrnd);
		addChild(objIco);
		addChild(cooldownTxt);
		
		(obj != null) ? addChild(descWin) : null;
		if (obj == null)
		{
			cooldownTxt.alpha = 0;
		}
	
	}
	
	private function onOut(e:MouseEvent):void
	{
		RemoveSprite(bkgrnd);
		RemoveSprite(objIco);
		RemoveSprite(descWin);
		RemoveSprite(cooldownTxt);
		bkgrnd = ConvertEmbedToSprite(imgClass);
		bkgrnd.height = 40;
		bkgrnd.width = 40;
		addChild(bkgrnd);
		addChild(objIco);
		addChild(cooldownTxt);
		if (obj == null)
		{
			cooldownTxt.alpha = 0;
		}
	}
	
	private function updateCooldown():void
	{
		var owner:Mob;
		if (obj != null && obj.getType().toLowerCase() == "skill")
		{
			owner = obj.getOwner();
		}
		if (obj != null && obj.getType().toLowerCase() == "skill" && obj.onCooldown())
		{
			cooldownTxt.text = obj.getCooldown();
			cooldownTxt.alpha = 1;
			objIco.alpha = 0.5;
		}
		else if (owner != null && owner.getAp() < obj.getAp())
		{
			cooldownTxt.text = obj.getCooldown();
			objIco.alpha = 0.5;
		}
		else if (obj != null)
		{
			cooldownTxt.alpha = 0;
			objIco.alpha = 1;
		}
		else if (obj == null)
		{
			(contains(objIco)) ? RemoveSprite(objIco) : null
			cooldownTxt.alpha = 0;
		}
		
		if (obj != null)
		{
			if (objIco.alpha <= 0)
			{
				refresh();
			}
		}
	
	}
	
	public function setObject(newObj:*):void
	{
		obj = newObj;
		RemoveSprite(bkgrnd);
		RemoveSprite(objIco);
		RemoveSprite(descWin);
		RemoveSprite(cooldownTxt);
		objIco = obj.getIcon();
		objIco.width = 35;
		objIco.height = 35;
		CenterObjRelTo(objIco, bkgrnd);
		objIco.y = bkgrnd.height - objIco.height - 1;
		descWin.setText(obj.getCompleteDesc());
		if (newObj.getType().toLowerCase() == "skill")
		{
			if (newObj.onCooldown())
			{
				objIco.alpha = 0.5;
				cooldownTxt.alpha = 1;
			}
			
		}
		
		bkgrnd = ConvertEmbedToSprite(imgClass);
		bkgrnd.height = 40;
		bkgrnd.width = 40;
		addChild(bkgrnd);
		addChild(objIco);
		addChild(cooldownTxt);
		updateCooldown();
	}
	
	private function refresh():void
	{
		RemoveSprite(bkgrnd);
		RemoveSprite(objIco);
		RemoveSprite(descWin);
		RemoveSprite(cooldownTxt);
		addChild(bkgrnd);
		addChild(objIco);
		addChild(descWin);
		addChild(cooldownTxt);
		if (obj == null)
		{
			cooldownTxt.alpha = 0;
		}
	}
	
	public function getObject():*
	{
		return obj;
	}
	
	public function clearObject():void
	{
		obj = null;
		objIco = new Sprite();
		RemoveSprite(bkgrnd);
		RemoveSprite(objIco);
		RemoveSprite(descWin);
		RemoveSprite(cooldownTxt);
		addChild(bkgrnd);
	}

}

class QuickSlotDescWin extends Sprite
{
	private var bkgrnd:Sprite = new Sprite();
	private var txt:TextField = new TextField();
	
	public function QuickSlotDescWin()
	{
		bkgrnd = DrawSquare(150, 150);
		txt = DrawTextArea(150, 150, 14, "center", "rainyhearts");
		addChild(bkgrnd);
		addChild(txt);
	}
	
	public function setText(string:String):void
	{
		var breaks:String = "";
		var i:int = 0;
		var diff:Number = 0;
		if (string.length <= 50)
		{
			diff = Math.floor((100 - string.length) / 3);
			for (i = 0; i < diff; i += 10)
			{
				breaks += "\n";
			}
		}
		else if (string.length <= 90 && string.length > 50)
		{
			diff = Math.floor((100 - string.length) / 4);
			for (i = 0; i < diff; i += 10)
			{
				breaks += "\n";
			}
		}
		txt.text = breaks + string;
	}
	
	private function onHover(e:MouseEvent):void
	{
		addChild(bkgrnd);
		addChild(txt);
	}
	
	private function onOut(e:MouseEvent):void
	{
		RemoveSprite(bkgrnd);
		RemoveSprite(txt);
	}
}