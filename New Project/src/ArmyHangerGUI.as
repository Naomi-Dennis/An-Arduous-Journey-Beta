package
{
	import Screens.TownDescriptionScreen;
	;
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawBorder;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	import mobs.CampaignEnemies.SerYorkNaked;
	import mobs.Players.Beserker_Tristan;
	import mobs.Players.Frank;
	import mobs.Players.Jack;
	import mobs.Players.Knight_Dillon;
	import mobs.Players.SerYork;
	import mobs.Players.Timothy;
	import org.flashdevelop.utils.FlashConnect;
	
	import Screens.ScreenBackground;
	import Screens.SettingBackground;
	import Assets.Utility.DrawText;
	import Assets.Utility.GlowObj
	import Assets.Utility.RemoveFilters;
	import Screens.TownScreen;
	import Screens.ArmyHangerWindows;
	import Assets.Utility.PlaceObjBelowRel;
	import Screens.TutorialMessage;
	/**
	 *
	 * ...
	 * @author lk
	 */
	import mobs.PlayersLibrary;
	
	public class ArmyHangerGUI extends Sprite
	{
		[Embed(source = "pics/backgrounds/Heavy Forest Battle.png")]
		private var img:Class;
		private var bkgrnd:Sprite = new Sprite();
		private var soldiers:Array = [];
		private var currentArmy:Array = [];
		private var selectedArmyPos:Point = new Point(300, 100);
		private var contBtn:Sprite = DrawButton("Continue", 36);
		private var equipBtn:Sprite = DrawButton("Outfit Soldiers", 24);
		private var notifyTf:TextField = DrawTextArea(540, 40, 30, "center", "unzialish");
		private var chooseSoldierLbl:TextField = DrawText("Choose a soldier to equip", 32);
		private var cancelBtn:Sprite = DrawButton("Back", 20);
		private var finishBtn:Sprite = DrawButton("Finish", 20);
		private var overshadow:Sprite = DrawSquare(540, 540);
		private var statsWin:ScreenBackground = new ScreenBackground({width: 200, height: 200}, 0xffffff, 0xfffff);
		private var tfStats:TextField = DrawTextArea(200, 200, 20, "center");
		private var not_in_use_army_slots:ArmyHangerWindows = new ArmyHangerWindows(25, 5, 5);
		private var in_use_army_slots:ArmyHangerWindows = new ArmyHangerWindows(7, 7, 1);
		private var editUnitBtn:Sprite = DrawButton("Edit Unit", 24);
		private var addUnitBtn:Sprite = DrawButton("Add Unit", 24);
		private var removeUnitBtn:Sprite = DrawButton("Remove Unit", 24);
		private var mapbtn:Sprite = DrawButton("To Map", 24);
		private var selectedPiece:BattlePiece;
		private var lbl_army:TextField = DrawText("Party", 20, "center");
		private var tutorialHandle:Function;
		public function ArmyHangerGUI(lockArmy:Boolean = false, bkgrndClass:Class = null)
		{
			DropShadow(chooseSoldierLbl);
			if (bkgrndClass == null)
			{
				bkgrnd = ConvertEmbedToSprite(img);
			}
			else
			{
				bkgrnd = ConvertEmbedToSprite(bkgrndClass);
			}
			bkgrnd.width = 540;
			bkgrnd.height = 490;
			bkgrnd.y = 25
			bkgrnd.alpha = 0.8;
			contBtn.y = 410
			notifyTf.y = 30
			notifyTf.text = "Select A Unit"
			notifyTf.x += 40;
			DropShadow(notifyTf);
			DropShadow(mapbtn);
			CenterObjRelTo(contBtn, bkgrnd);
			equipBtn.y = contBtn.y - 35;
			equipBtn.x = (contBtn.width / 2 - equipBtn.width / 2) + contBtn.x;
			chooseSoldierLbl.y = 10;
			CenterObjRelTo(chooseSoldierLbl, bkgrnd);
			cancelBtn.y = equipBtn.y;
			CenterObjRelTo(cancelBtn, bkgrnd);
			editUnitBtn.x = 24
			editUnitBtn.y = 195;
			addUnitBtn.y = editUnitBtn.y + editUnitBtn.height + 5;
			removeUnitBtn.y = addUnitBtn.y + addUnitBtn.height + 5;
			CenterObjRelTo(addUnitBtn, editUnitBtn);
			removeUnitBtn.x = -addUnitBtn.width / 2 + removeUnitBtn.width / 2;
			removeUnitBtn.x -= 6;
			mapbtn.x = (removeUnitBtn.x + removeUnitBtn.width / 2) - mapbtn.width / 2;
			mapbtn.y = removeUnitBtn.y + removeUnitBtn.height + 5;
			not_in_use_army_slots.x = bkgrnd.width / 2 - not_in_use_army_slots.width / 2;
			not_in_use_army_slots.y = bkgrnd.height / 2 - not_in_use_army_slots.height / 2;
			not_in_use_army_slots.x += 45;
			in_use_army_slots.x = bkgrnd.width / 2 - in_use_army_slots.width / 2;
			in_use_army_slots.y = not_in_use_army_slots.y + not_in_use_army_slots.height + 30;
			in_use_army_slots.x += 30;
			mapbtn.x -= 7;
			lbl_army.x = (not_in_use_army_slots.x + not_in_use_army_slots.width / 2) - lbl_army.width / 2;
			lbl_army.y = not_in_use_army_slots.y + not_in_use_army_slots.height + 3;
			GlowObj(lbl_army, 0xffffff, 20, 20, 20);
			addChild(DrawSquare(540, 540));
			addChild(bkgrnd);
			addChild(notifyTf);
			addChild(not_in_use_army_slots);
			addChild(in_use_army_slots);
			addChild(editUnitBtn);
			addChild(addUnitBtn);
			addChild(removeUnitBtn);
			addChild(mapbtn);
			addChild(lbl_army);
			//	addChild(equipBtn);
			addEventListener(Event.ENTER_FRAME, getSelectedPiece);
			soldiers = Main.army.getArmy();
			//	soldiers.push(PlayersLibrary.createJack(), PlayersLibrary.createReggie(), PlayersLibrary.createKahn(), PlayersLibrary.createArnold(), PlayersLibrary.createKevin(), PlayersLibrary.createAlice(), PlayersLibrary.createTim(), PlayersLibrary.createTristan(), PlayersLibrary.createArthur(), PlayersLibrary.createJohn(), PlayersLibrary.createTyler(), PlayersLibrary.createBrandon(), PlayersLibrary.createAstor());
			statsWin.addChild(tfStats);
			addEventListener(Event.ADDED_TO_STAGE, redrawSoldiers);
			
			if (lockArmy)
			{
				lockHanger();
			}
			addEventListener(Event.REMOVED_FROM_STAGE, removeHandle);
			deactivateAllWindows()
			in_use_army_slots.addEventListener(MouseEvent.CLICK, activateInUseOptions);
			not_in_use_army_slots.addEventListener(MouseEvent.CLICK, activateNotInUseOptions);
			mapbtn.addEventListener(MouseEvent.CLICK, beginLevel);
			tutorial();
		}
		
		private function tutorial():void
		{
			var unclickable:Sprite = DrawSquare(540, 540);
			unclickable.alpha = 0;
			addChild(unclickable);
			if (Main.glblPlayer.tutOn)
			{
				var selectAUnitHelp1:TutorialMessage = new TutorialMessage("All your heroes are placed here.")
				var selectAUnitHelp2:TutorialMessage = new TutorialMessage("Choose one or several for your party.");
				selectAUnitHelp1.x = 177
				selectAUnitHelp1.y = 205;
				PlaceObjBelowRel(selectAUnitHelp2, selectAUnitHelp1);
				selectAUnitHelp2.x = selectAUnitHelp1.x - 30;
				addChild(selectAUnitHelp1);
				addChild(selectAUnitHelp2);
				var partyHelp:TutorialMessage = new TutorialMessage("This is your current selected party.");
				partyHelp.x = 100;
				partyHelp.y = 460;
				addChild(partyHelp);
				tutorialHandle = removeTutorial([unclickable, selectAUnitHelp1, selectAUnitHelp2, partyHelp]);
				addEventListener(MouseEvent.CLICK, tutorialHandle);
				
			}
		}
		
		private function removeTutorial(helpSprites:Array):Function
		{
			return function(e:MouseEvent):void
			{
				for (var i:* in helpSprites)
				{
					RemoveSprite(helpSprites[i]);
				}
				e.currentTarget.removeEventListener(MouseEvent.CLICK, tutorialHandle);
				FlashConnect.trace("TUTORIAL");
			}
		
		}
		
		private function getSelectedPiece(e:Event):void
		{
			if (selectedPiece == null)
			{
				if (not_in_use_army_slots.currentPiece != null)
				{
					selectedPiece = not_in_use_army_slots.currentPiece;
				}
				else if (in_use_army_slots.currentPiece != null)
				{
					selectedPiece = in_use_army_slots.currentPiece;
				}
			}
		}
		
		private function deactivateAllWindows():void
		{
			selectedPiece = null;
			not_in_use_army_slots.deselectAll();
			in_use_army_slots.deselectAll();
			deactivateAddUnitBtn();
			deactivateEditBtn();
			deactivateRemoveUnitBtn();
		}
		
		private function activateEditBtn():void
		{
			editUnitBtn.addEventListener(MouseEvent.CLICK, editUnit);
			editUnitBtn.alpha = 1;
		}
		
		private function activateAddUnitBtn():void
		{
			addUnitBtn.addEventListener(MouseEvent.CLICK, addUnit);
			addUnitBtn.alpha = 1;
		}
		
		private function activateRemoveUnitBtn():void
		{
			removeUnitBtn.addEventListener(MouseEvent.CLICK, removeUnit);
			removeUnitBtn.alpha = 1;
		}
		
		private function deactivateEditBtn():void
		{
			if (editUnitBtn.hasEventListener(MouseEvent.CLICK))
			{
				editUnitBtn.removeEventListener(MouseEvent.CLICK, editUnit);
				
			}
			editUnitBtn.alpha = 0.7;
		}
		
		private function deactivateAddUnitBtn():void
		{
			if (addUnitBtn.hasEventListener(MouseEvent.CLICK))
			{
				addUnitBtn.removeEventListener(MouseEvent.CLICK, addUnit);
				
			}
			addUnitBtn.alpha = 0.7;
		}
		
		private function deactivateRemoveUnitBtn():void
		{
			if (removeUnitBtn.hasEventListener(MouseEvent.CLICK))
			{
				removeUnitBtn.removeEventListener(MouseEvent.CLICK, removeUnit);
			}
			removeUnitBtn.alpha = 0.7;
		}
		
		private function editUnit(e:MouseEvent):void
		{
			var piece:BattlePiece = BattlePiece(selectedPiece);
			if (piece != null)
			{
				selectSoldierToEquip(piece);
			}
		}
		
		private function addUnit(e:MouseEvent):void
		{
			var piece:BattlePiece = BattlePiece(selectedPiece);
			currentArmy.push(piece.mob);
			deactivateAllWindows();
			showSoldiers();
		}
		
		private function removeUnit(e:MouseEvent):void
		{
			var piece:BattlePiece = BattlePiece(selectedPiece);
			unselectSoldier(piece);
			deactivateAllWindows();
			showSoldiers();
		}
		
		private function activateInUseOptions(e:MouseEvent):void
		{
			not_in_use_army_slots.deselectAll();
			selectedPiece = null;
			activateEditBtn();
			activateRemoveUnitBtn();
		}
		
		private function activateNotInUseOptions(e:MouseEvent):void
		{
			in_use_army_slots.deselectAll();
			selectedPiece = null;
			if (currentArmy.length < 7)
			{
				activateAddUnitBtn();
			}
			else
			{
				var notify:TownDescriptionScreen = new TownDescriptionScreen(null, "Your party is full!");
				notify.x = 540 / 2 - notify.width / 2;
				notify.y = 540 / 2 - notify.height / 2;
				overshadow.alpha = 0.4;
				addChild(overshadow);
				addChild(notify);
				
			}
			activateEditBtn();
		}
		
		private function notifyRemoveHandle(e:Event):void
		{
			RemoveSprite(overshadow);
		}
		
		private function removeHandle(e:Event):void
		{
			for (var i:* in soldiers)
			{
				soldiers[i].getBattlePiece().removeEventListener(MouseEvent.CLICK, selectSoldierToEquip);
			}
		}
		
		private function lockHanger():void
		{
			var currentSoldier:Mob = null;
			
			for (var j:* in currentArmy)
			{
				currentArmy[j].getBattlePiece().alpha = 1;
			}
		}
		
		private function redrawSoldiers(e:Event):void
		{
			showSoldiers(false);
		}
		
		private function cancelHandle(e:MouseEvent):void
		{
			var currentSoldier:BattlePiece = null;
			for (var i:* in soldiers)
			{
				currentSoldier = soldiers[i].getBattlePiece();
				currentSoldier.addEventListener(MouseEvent.ROLL_OVER, showSoldierStats);
				currentSoldier.addEventListener(MouseEvent.CLICK, selectSoldier);
				currentSoldier.removeEventListener(MouseEvent.ROLL_OVER, showSquareAroundSoldier);
				currentSoldier.removeEventListener(MouseEvent.ROLL_OUT, hideSquareAroundSoldier);
				currentSoldier.removeEventListener(MouseEvent.CLICK, selectSoldierToEquip);
			}
			RemoveSprite(chooseSoldierLbl);
			RemoveSprite(cancelBtn);
		}
		
		private function showEquipScreen(e:MouseEvent):void
		{
			notifyTf.text = "Editing Soilder";
			RemoveSprite(notifyTf);
			addChild(notifyTf);
			var currentSoldier:BattlePiece = null;
			for (var i:* in soldiers)
			{
				currentSoldier = soldiers[i].getBattlePiece();
				currentSoldier.removeEventListener(MouseEvent.ROLL_OVER, showSoldierStats);
				currentSoldier.removeEventListener(MouseEvent.CLICK, selectSoldier);
				currentSoldier.addEventListener(MouseEvent.ROLL_OVER, showSquareAroundSoldier);
				currentSoldier.addEventListener(MouseEvent.ROLL_OUT, hideSquareAroundSoldier);
				currentSoldier.addEventListener(MouseEvent.CLICK, selectSoldierToEquip);
			}
			RemoveSprite(contBtn);
			RemoveSprite(equipBtn);
			addChild(chooseSoldierLbl);
			addChild(cancelBtn);
		}
		
		private function equipRemoveHandle(e:Event):void
		{
			var win:EquipSoldier = e.currentTarget as EquipSoldier;
			var currentSoldier:BattlePiece = null;
			addChild(not_in_use_army_slots)
			addChild(in_use_army_slots);
			addChild(editUnitBtn);
			addChild(removeUnitBtn);
			addChild(addUnitBtn);
			addChild(mapbtn);
			addChild(lbl_army);
		}
		
		private function selectSoldierToEquip(piece:BattlePiece):void
		{
			notifyTf.text = "Select A Unit";
			var tgt:BattlePiece = piece;
			var currentSoldier:BattlePiece = null;
			var mob:Mob = BattlePiece(tgt).mob;
			var win:EquipSoldier = new EquipSoldier(mob);
			win.addEventListener(Event.REMOVED_FROM_STAGE, redrawSoldiers);
			RemoveSprite(not_in_use_army_slots);
			RemoveSprite(in_use_army_slots);
			RemoveSprite(editUnitBtn);
			RemoveSprite(removeUnitBtn);
			RemoveSprite(addUnitBtn);
			RemoveSprite(mapbtn);
			RemoveSprite(lbl_army);
			overshadow.alpha = 0.3;
			addChild(win);
			win.addEventListener(Event.REMOVED_FROM_STAGE, equipRemoveHandle);
		}
		
		private function showSquareAroundSoldier(e:MouseEvent):void
		{
			var spr:BattlePiece = e.currentTarget as BattlePiece;
			GlowObj(spr, 0xffffff, 10);
		}
		
		private function hideSquareAroundSoldier(e:MouseEvent):void
		{
			var spr:BattlePiece = e.currentTarget as BattlePiece;
			RemoveFilters(spr);
		}
		
		private function checkIsCurrent(soldier:Mob, index:int = 0):Boolean
		{
			if (index < currentArmy.length)
			{
				if (currentArmy[index] == soldier)
				{
					return true;
				}
				else
				{
					checkIsCurrent(soldier, index + 1);
				}
			}
			return false;
		}
		
		private function showSoldiers(redraw:Boolean = false):void
		{
			
			soldiers = Main.army.getArmy();
			var currentSoldier:Mob = new Mob();
			var currentImg:BattlePiece;
			var currentIndex:int = 0;
			not_in_use_army_slots.removePieces();
			in_use_army_slots.removePieces();
			for (var i:int = 0; i < 5; i++)
			{
				for (var j:int = 0; j < 4; j++)
				{
					if (currentIndex < soldiers.length)
					{
						currentSoldier = soldiers[currentIndex];
						currentImg = currentSoldier.getBattlePiece();
						if (!checkIsCurrent(currentSoldier))
						{
							not_in_use_army_slots.addPiece(currentSoldier);
							DropShadow(currentImg);
						}
						currentIndex++;
						
					}
					else
					{
						break;
					}
				}
			}
			redrawCurrentSoldiers();
		
		}
		
		private function showSoldierStats(e:MouseEvent):void
		{
			var bp:BattlePiece = e.currentTarget as BattlePiece;
			var mob:Mob = bp.mob;
			var stats:Object = mob.getStatus();
			DropShadow(statsWin);
			statsWin.y = bp.y - 5;
			statsWin.x = bp.x + 40
			if (bp.x >= 400)
			{
				statsWin.x = 400 - statsWin.width - 40
			}
			addChild(statsWin);
			tfStats.text = "\n"
			tfStats.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
			for (var i:* in stats)
			{
				tfStats.appendText(i + ": " + stats[i].toString() + "\n");
			}
			tfStats.appendText("Level: " + mob.getLevel().toString() + " Exp: " + mob.getExperiencePercentage().toString() + "%");
			bp.addEventListener(MouseEvent.ROLL_OUT, hideSoldierStats);
		}
		
		private function hideSoldierStats(e:MouseEvent):void
		{
			var bp:BattlePiece = e.currentTarget as BattlePiece;
			RemoveSprite(statsWin);
			bp.removeEventListener(MouseEvent.ROLL_OUT, hideSoldierStats);
		}
		
		private function selectSoldier(e:MouseEvent):void
		{
			var bp:BattlePiece = e.currentTarget as BattlePiece;
			bp.removeEventListener(MouseEvent.CLICK, selectSoldier);
			currentArmy.push(bp.mob);
			redrawCurrentSoldiers();
		}
		
		private function redrawCurrentSoldiers():void
		{
			currentArmy = Main.army.getCurrent();
			var nX:int = 400;
			var nY:int = 120;
			var currentPiece:BattlePiece;
			var maxLength:int = currentArmy.length;
			for (var i:int = 0; i < maxLength; ++i)
			{
				currentPiece = Mob(currentArmy[i]).getBattlePiece();
				in_use_army_slots.addPiece(currentArmy[i]);
			}
		}
		
		private function unselectSoldier(piece:BattlePiece):void
		{
			var bp:BattlePiece = piece;
			for (var i:* in currentArmy)
			{
				if (currentArmy[i].getName() == BattlePiece(bp).mob.getName())
				{
					currentArmy.splice(i, 1);
				}
			}
		
		}
		
		private function beginLevel(e:MouseEvent):void
		{
			var army:Array = Main.army.getArmy();
			var maxLength:int = army.length;
			Main.army.setCurrent([]);
			var currentSoldier:BattlePiece;
			for (var j:int = 0; j < currentArmy.length; j++)
			{
				Mob(currentArmy[j]).resetMob();
				Main.army.addToCurrent(currentArmy[j]);
				
			}
			
			Main.saveGame();
			RemoveSprite(this);
		}
	}

}
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
;

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
	private var tfStats:TextField = DrawTextArea(200, 200, 18, "center");
	private var mob:Mob;
	private var quickslotWin:QuickslotWindow;
	private var tfQuickslot:TextField = DrawText("Quickslots", 15);
	private var tutorialHandle:Function; 
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
		addChild(mobIconWindow);
		addChild(mobEquipWindow);
		
		addChild(closeBtn);
		addChild(statsWin);
		addChild(quickslotWin);
		addChild(tfQuickslot);
		addChild(inventorywin);
		statsWin.addEventListener(Event.ENTER_FRAME, updateStats);
		addEventListener(Event.ADDED_TO_STAGE, showNotification);
		showTutorial();
	}
	
	private function showNotification(e:Event):void
	{

	}
	
	private function removeOvershadow(e:Event):void
	{
		
		RemoveSprite(overshadow);
		
		
	}
	
	private function showTutorial():void
	{
		if (Main.glblPlayer.tutOn)
		{
			var unclickable:Sprite = DrawSquare(540, 540);
			unclickable.alpha = 0;
			addChild(unclickable);
			
			var inventoryHelp:TutorialMessage = new TutorialMessage("This is your inventory.");
			var inventoryHelp2:TutorialMessage = new TutorialMessage("Every hero has the same items.");
			var quickslotHelp:TutorialMessage = new TutorialMessage("This is your hero's quickslots.");
			var quickslotHelp2:TutorialMessage = new TutorialMessage("These items or skills can be used in battle.");
			inventoryHelp.x = 230;
			inventoryHelp.y = 108;
			quickslotHelp.x = 56;
			quickslotHelp.y = 249;
			PlaceObjBelowRel(quickslotHelp2, quickslotHelp);
			quickslotHelp2.x = quickslotHelp.x; 
			
			PlaceObjBelowRel(inventoryHelp2, inventoryHelp);
			inventoryHelp2.x = inventoryHelp.x;
			addChild(inventoryHelp);
			addChild(quickslotHelp);
			addChild(inventoryHelp2);
			addChild(quickslotHelp2);
			tutorialHandle = removeTutorial([unclickable, inventoryHelp, quickslotHelp, inventoryHelp2, quickslotHelp2])
			addEventListener(MouseEvent.CLICK, tutorialHandle);
		}
	}
	
	private function removeTutorial(tutSprites:Array):Function
	{
	
		return function(e:MouseEvent):void
		{
			for (var i:* in tutSprites)
			{
				RemoveSprite(tutSprites[i]);
			}
			e.currentTarget.removeEventListener(MouseEvent.CLICK, tutorialHandle);
		}
	}
	
	private function updateStats(e:Event):void
	{
		var hoveredItem:*;
		if (inventorywin.hoveredItem != null)
		{
			
			hoveredItem = inventorywin.hoveredItem;
			tfStats.text = hoveredItem.getCompleteDesc();
		}
		else if (quickslotWin.hoveredItem != null)
		{
			tfStats.text = "";
			hoveredItem = quickslotWin.hoveredItem;
			tfStats.text = hoveredItem.getCompleteDesc()
		}
		else if (mobEquipWindow.hoveredItem != null)
		{
			tfStats.text = "";
			hoveredItem = mobEquipWindow.hoveredItem;
			tfStats.text = hoveredItem.getCompleteDesc();
			
		}
		else
		{
			var stats:Object = mob.getStatus();
			tfStats.text = "";
			tfStats.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
			for (var i:* in stats)
			{
				tfStats.appendText(i + ": " + stats[i].toString() + "\n");
			}
		}
		mob.getBattlePiece().replaceBitmapData( MobIcon(mob.getIcon()).getBitmapData() );
	}
	
	private function closeWindow(e:MouseEvent):void
	{
		RemoveSprite(this);
	}
}