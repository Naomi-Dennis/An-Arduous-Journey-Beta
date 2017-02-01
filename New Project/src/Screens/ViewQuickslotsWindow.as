package Screens 
{
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	 
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class ViewQuickslotsWindow extends Sprite
	{
		/*
		 * You can only see 7!!
		 * 
		 * bkgrnd  - overcast 
		 * 
		 * slots(1) for inventory 
		 * slots(2) for quickslots
		 * */
		public var overshadow:Sprite = new Sprite();
		public var aQuickslots:Array = [new Slot(), new Slot(), new Slot(), new Slot(), new Slot(), new Slot(), new Slot()];
		public var aInventorySlots:Array = []; 
		public var player:Mob; 
		public var currentInventorySlot:Slot = null;
		public var currentQuickslotSlot:Slot = null;
		public var tempQuickSlots:Array = []; 
		public var quickslotHeader:TextField  = DrawText("Quickslot", 30, "center"); 
		public var inventorySlotHeader:TextField  = DrawText("Inventory", 30, "center"); 
		public var notifyTf:TextField = DrawTextArea(500, 200, 15, "center");
		public var saveBtn:Sprite = DrawButton("Save", 40);
		public var removeItemBtn:Sprite = DrawButton("Remove", 20);
		public var cancelBtn:Sprite = DrawButton("close", 20);
		public function ViewQuickslotsWindow(_player:Mob) 
		{
			player = _player; 
			overshadow = DrawSquare(540, 540);
			overshadow.alpha = 0.8; 
			addChild(overshadow);
			createInventorySlots();
			createQuickSlots();
			setInventorySlots();
			setQuickSlots();
			var horLine:Sprite = new Sprite();
			horLine.graphics.lineStyle(0.1, 0xffffff); 
			horLine.graphics.moveTo(0, 0);
			horLine.graphics.lineTo(510, 0); 
			
			horLine.x = 15;
			horLine.y = 250
			addChild(horLine);
			
			CenterObjRelTo(inventorySlotHeader, overshadow);
			CenterObjRelTo(quickslotHeader, overshadow);
			CenterObjRelTo(notifyTf, overshadow);
			
			inventorySlotHeader.y = 5;
			quickslotHeader.y = 250;
			notifyTf.y = 500
			
			addChild(inventorySlotHeader);
			addChild(quickslotHeader);
			
			addChild(notifyTf);
			
			notifyTf.text = "Click an inventory item then a quickslot slot, to add it to your quickslots.";
			
			CenterObjRelTo(saveBtn, overshadow);
			saveBtn.y = 400;
			
			cancelBtn.x = saveBtn.width + saveBtn.x + 50; 
			cancelBtn.y = saveBtn.y + (saveBtn.height/2 - cancelBtn.height/2); 
			
			removeItemBtn.x = saveBtn.x - 50 - removeItemBtn.width ;
			removeItemBtn.y = cancelBtn.y; 
			
			addChild(removeItemBtn);
			addChild(saveBtn);
			addChild(cancelBtn);
			
			cancelBtn.addEventListener(MouseEvent.CLICK, cancel);
			saveBtn.addEventListener(MouseEvent.CLICK, saveSlots);
			removeItemBtn.alpha = 0.5;
		}
		public function disableRemove():void {
			removeItemBtn.alpha = 0.5;
			removeItemBtn.removeEventListener(MouseEvent.CLICK, removeItemFromQuickslot);
		}
		public function enableRemove():void {
			removeItemBtn.alpha = 1;
			removeItemBtn.addEventListener(MouseEvent.CLICK, removeItemFromQuickslot);
		}
		public function createInventorySlots():void {
			var currentSlot:Slot = null; 
			var maxSlots:int = player.inventory.getsize();
			var originY:int = 10;
			var originX:int = (32 * maxSlots + (10 * maxSlots))/2  - 540 /2 ; 
			var maxRow:int = 11; 
			for (var i:int = 0; i < maxSlots; i++) {
					currentSlot = new Slot(); 
					if (i % maxRow == 0) {
						originY += currentSlot.height + 10;
						originX = 40;
					}
					else {
						originX += currentSlot.width + 10 ;
					}
					currentSlot.x = originX;
					currentSlot.y = originY;
					aInventorySlots.push(currentSlot);
					addChild(currentSlot); 
			}
		}
		public function createQuickSlots():void {
			var currentSlot:Slot = null; 
			var originY:int = 320;
			var originX:int = Math.abs(((32 * 7) / 2) - (540 / 2)); 
			for (var i:* in aQuickslots) {
				currentSlot = aQuickslots[i];
				currentSlot.x = originX + (i * currentSlot.width);
				currentSlot.y = originY;
				addChild(currentSlot);
			}
		}
		public function setInventorySlots():void {
			var currentSlot:Slot = null;
			var aContents:Array = player.inventory.getItems();
			var nUsedSlots:int =player.inventory.getsize();
			for (var i:int = 0; i < nUsedSlots; i++ ) {
				currentSlot = aInventorySlots[i]; 
				if(aContents[i] != null){
					currentSlot.setObject(aContents[i]); 
				}
				currentSlot.addEventListener(MouseEvent.CLICK, selectInventorySlot);
			}
		}
		public function setQuickSlots():void {
			var currentSlot:Slot = null;
			var playerQuickslots:Array = player.getQuickSlots();
			tempQuickSlots = DeepCopy(playerQuickslots, Array, "Array");
			for (var i:* in playerQuickslots) {
				currentSlot = aQuickslots[i];
				//currentSlot.addEventListener(MouseEvent.CLICK, addToQuickslot);
				//currentSlot.addEventListener(MouseEvent.CLICK, selectQuickSlot);
				if(playerQuickslots[i] != null){
					currentSlot.setObject( playerQuickslots[i] );
				}
				else {
					currentSlot.clearObject();
				}
			}
		}
		public function selectInventorySlot(e:MouseEvent):void {
			var slot:Slot = e.currentTarget as Slot; 
			deselectInventorySlots();
			slot.select();
			currentInventorySlot = slot; 
			for (var i:* in aQuickslots) {
				aQuickslots[i].addEventListener(MouseEvent.CLICK, addToQuickslot);
			}
		}
		public function selectQuickSlot(e:MouseEvent):void {
			var slot:Slot = e.currentTarget as Slot; 
			deselectQuickslots();
			slot.select();
			currentQuickslotSlot = slot; 
			if(currentQuickslotSlot.hasObject()){
				enableRemove();
			}
			notifyTf.text = "Click an inventory item to add to your quick slot, or press remove item to remove it from your quickslot."; 
		}
		public function deselectInventorySlots():void {
			for (var i:* in aInventorySlots) {
				aInventorySlots[i].deselect(); 
			}
		}
		public function deselectQuickslots():void {
			for (var i:* in aQuickslots) {
				aQuickslots[i].deselect();
			}
			if(removeItemBtn.alpha == 1){
				disableRemove();
			}
		}
		
		public function addToQuickslot(e:MouseEvent):void {
			if (currentInventorySlot != null && currentInventorySlot.hasObject()) {
				var inventoryItem:* = currentInventorySlot.getObject();
				deselectQuickslots();
				currentQuickslotSlot = e.currentTarget as Slot; 
				currentQuickslotSlot.setObject(inventoryItem);
				deselectInventorySlots();
				deselectQuickslots();
				
				for (var i:* in aQuickslots) {
					aQuickslots[i].removeEventListener(MouseEvent.CLICK, addToQuickslot);
				}
			}
		}
		public function saveSlots(e:MouseEvent):void {
			var currentSlot:Slot = null;
			for (var i:* in aQuickslots) {
				currentSlot = aQuickslots[i];
				if(currentSlot.hasObject()) {
					tempQuickSlots[i] = currentSlot.getObject();
				}
			}
			player.setQuickslot(tempQuickSlots);
		}
		public function cancel(e:MouseEvent):void {
			RemoveSprite(this); 
		}
		public function removeItemFromQuickslot(e:MouseEvent):void {
			var index:int = 0;
			for (var i:* in aQuickslots) {
				if (currentQuickslotSlot == aQuickslots[i]) {
					index = i; 
				}
			}
			
			aQuickslots[index].clearObject();
		}
		
	}

}

import Assets.Item;
import Assets.Utility.ChangeColor;
import Assets.Utility.DrawBorderStandalone;
import Assets.Utility.DrawSquare;
import Assets.Utility.RemoveSprite;
import flash.display.Sprite;
import flash.events.MouseEvent;
class Slot extends Sprite {
	/* 
	 * Used to show the player what items that can buy. 
	 * Functions:
		 * Get Item
		 * Set item
		 * Clear Item
		 * Has Item
		 * Highlight on Roll Over
		 * UnHighlight on Roll Over
		 * Return Item Description (getCompleteDesc())
	 * */
	public var obj:* = null;
	public var bkgrnd:Sprite = DrawSquare(32, 32);
	public var objIcon:Sprite = new Sprite();
	public var border:Sprite = DrawBorderStandalone(bkgrnd, 0.1); 
	public var selected:Boolean = false; 
	public function Slot() {
		addChild(bkgrnd); 
		addChild(border); 
		addEventListener(MouseEvent.ROLL_OVER, highlight);
		addEventListener(MouseEvent.ROLL_OUT, unHighlight); 
	}
	public function setObject(newObject:*):void {
		obj = newObject; 
		objIcon = obj.getIcon();
		objIcon.width = bkgrnd.width - 2;
		objIcon.height = bkgrnd.height - 2;
		objIcon.x = bkgrnd.width / 2 - objIcon.width / 2; 
		objIcon.y = bkgrnd.height / 2 - objIcon.height / 2; 
		RemoveSprite(bkgrnd);
		RemoveSprite(objIcon);
		RemoveSprite(border);
		addChild(bkgrnd);
		addChild(objIcon);
		addChild(border); 
	}
	public function getObject():*{
		return obj;
	}
	public function clearObject():void {
		obj = null; 
	}
	public function hasObject():Boolean {
		return obj != null;
	}
	public function getDescription():String {
		if (hasObject()) {
			return obj.getCompleteDesc(); 
		}
		return "ERROR - SLOT - GET DESC ()"; 
	}
	public function highlight(e:MouseEvent):void {
		(selected) ? null : ChangeColor(border, 0xffdd00);
	}
	public function unHighlight(e:MouseEvent):void {
		(selected) ? null : ChangeColor(border, 0xffffff); 
	}
	public function deselect():void {
		selected = false;
		ChangeColor(border, 0xffffff);
	}
	public function select():void {
		selected = true; 
		ChangeColor(border, 0x00ff00);
	}
}