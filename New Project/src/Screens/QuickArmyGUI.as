package Screens
{
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Assets.Utility.DrawSquare;
	import org.flashdevelop.utils.FlashConnect;
	
	import Assets.Utility.DeepCopy;
	;
	
	/**
	 * ...
	 * @author lk
	 */
	public class QuickArmyGUI extends Sprite
	{
		private var currentSoldiers:Array = [];
		private var overshadow:Sprite = DrawSquare(540, 540);
		private var goodies:Array = [];
		
		public function QuickArmyGUI()
		{
			addEventListener(Event.REMOVED_FROM_STAGE, off_stage); 
		}
		private function off_stage(e:Event):void{
			removeListeners();
		}
		public function getNumSoldieres():int
		{
			return currentSoldiers.length;
		}
		
		public function setSoldiers(soldiers:Array):void
		{
			var index:BattlePiece;
			for (var i:* in soldiers)
			{
				currentSoldiers.push(soldiers[i]);
				index = Mob(currentSoldiers[i]).getBattlePiece();
				
				index.resetBattlePiece();
				index.x = ((index.width + 10) * i)
				index.addEventListener(MouseEvent.ROLL_OVER, viewInfo);
				index.addEventListener(MouseEvent.CLICK, viewPartyScreen);
				goodies.push(index);
				addChild(index);
			}
		}
		
		public function removeListeners():void
		{
			for (var i:* in goodies)
			{
				goodies[i].removeEventListener(MouseEvent.CLICK, viewPartyScreen);
				goodies[i].removeEventListener(MouseEvent.CLICK, viewInfo);
			}
			goodies = [];
		}
		
		public function addListener():void
		{
			for (var i:* in currentSoldiers)
			{
				//Mob(currentSoldiers[i]).getBattlePiece().addEventListener(MouseEvent.CLICK, viewPartyScreen);
				//Mob(currentSoldiers[i]).getBattlePiece().addEventListener(MouseEvent.CLICK, viewInfo);
			}
		}
		
		private function viewPartyScreen(e:MouseEvent):void
		{
			var bp:BattlePiece = e.currentTarget as BattlePiece;
			var cpyMob:Mob = new Mob();
			var origMobData:Object = Mob(bp.mob).saveMob();
			cpyMob.loadMob(origMobData);
			var equipWin:EquipSoldier = new EquipSoldier(cpyMob);
			equipWin.addEventListener(Event.REMOVED_FROM_STAGE, removeOvershadow);
			this.parent.addChild(equipWin);
		}
		
		private function removeOvershadow(e:Event):void
		{
			var equipWin:EquipSoldier = e.currentTarget as EquipSoldier;
			var index:BattlePiece;
			var mob:Mob = equipWin.mob;
			for (var i:* in currentSoldiers)
			{
				index = Mob(currentSoldiers[i]).getBattlePiece();
				if (index.mob.getName() == mob.getName())
				{
					var saveData:Object = mob.saveMob();
					index.mob.loadMob(saveData, false);
				}
				else
				{
					index.resetBattlePiece();
				}
				index.x = ((index.width + 10) * i)
				
				addChild(index);
			}
		}
		
		public function clearSoldiers():void
		{
			for (var i:* in currentSoldiers)
			{
				RemoveSprite(currentSoldiers[i].getBattlePiece());
				Mob(currentSoldiers[i]).getBattlePiece().resetBattlePiece();
				Mob(currentSoldiers[i]).getBattlePiece().removeEventListener(MouseEvent.CLICK, viewPartyScreen);
			}
			currentSoldiers = [];
		}
		
		public function viewInfo(e:MouseEvent):void
		{
			
			var tgt:BattlePiece = e.currentTarget as BattlePiece;
			var win:InfoScreen = new InfoScreen(tgt);
			win.y = tgt.y - (tgt.height + win.height) + 10
			win.x = (tgt.x + tgt.width / 2) - (win.width / 2);
			addChild(win);
			tgt.addEventListener(MouseEvent.ROLL_OUT, removeInfoScreen(win));
		}
		
		public function removeInfoScreen(win:InfoScreen):Function
		{
			return function(e:MouseEvent):void
			{
				RemoveSprite(win);
			}
		}
	}
}

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

class InfoScreen extends Sprite
{
	private var tgt:BattlePiece;
	private var tf:TextField = DrawTextArea(170, 170);
	
	public function InfoScreen(_tgt:BattlePiece)
	{
		alpha = 0.8;
		tgt = _tgt;
		var bkgrnd:Sprite = DrawSquare(200, 200);
		tf.x = 15;
		tf.y = 15;
		DrawBorder(bkgrnd, 0.1);
		addChild(bkgrnd);
		addChild(tf);
		tf.defaultTextFormat = StandardTextFormat(13, "center");
		var mob:Mob = tgt.mob;
		var stats:Object = mob.getStatus();
		tf.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
		for (var i:* in stats)
		{
			tf.appendText(i + ": " + stats[i].toString() + "\n");
		}
		tf.appendText("Level: " + mob.getLevel().toString() + " Exp: " + Math.round(mob.getExperiencePercentage() * 100).toString() + "%");
		tf.appendText("\nClick to edit unit");
	}

}

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
		overshadow.alpha = 0.2
		addChild(overshadow);
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
		var stats:Object = mob.getStatus();
		tfStats.text = "";
		tfStats.appendText(mob.getName() + "\n\nHp: " + mob.getMaxHp().toString() + "\n");
		for (var i:* in stats)
		{
			tfStats.appendText(i + ": " + stats[i].toString() + "\n");
		}
	}
	
	private function closeWindow(e:MouseEvent):void
	{
		RemoveSprite(this);
	}
}