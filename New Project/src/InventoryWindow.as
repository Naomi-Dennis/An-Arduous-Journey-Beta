package
{
	import Assets.Inventory;
	import Assets.Utility.ChangeColor;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import items.weapon.Club;
	import Assets.Item;
	
	/**
	 * ...
	 * @author kljjlk
	 */
	public class InventoryWindow extends Sprite
	{
		[Embed(source = "InventoryBkgrnd.png")]
		private var img:Class;
		private var bkgrnd:Sprite = new Sprite();
		private var aSlots:Array = [];
		private var equipWin:EquipmentWindow;
		private var mob:Mob;
		private var inventory:Inventory;
		private var quickslot:QuickslotWindow;
		public var currentItem:*;
		public var hoveredItem:*; 
		public function InventoryWindow()
		{
			bkgrnd = ConvertEmbedToSprite(img);
			addChild(bkgrnd);
			setSlots();
			for (var i:* in aSlots)
			{
				aSlots[i].addEventListener(MouseEvent.MOUSE_DOWN, dragTo);
			}
			addEventListener(Event.REMOVED_FROM_STAGE, saveVars);
		}
		private function saveVars(e:Event):void{
			var currentItems:Array = [];
			for (var i:* in aSlots){
					if (aSlots[i].hasItem()){
						currentItems.push(aSlots[i].getItem());
				}
			}
			Main.glblPlayer.inventory.setItems(currentItems);
		}
		public function setMob(_mob:Mob):void
		{
			mob = _mob;
			setSlotItems();
		}
		
		public function setInventory(_inven:Inventory):void
		{
			inventory = _inven;
			setSlotItems();
		}
		
		public function setQuickslotWin(win:QuickslotWindow):void
		{
			quickslot = win;
		}
		
		public function setEquipWin(win:EquipmentWindow):void
		{
			equipWin = win;
		}
		public function addToInventory(item:*):Boolean {
			if (!inventory.isFull()) {
				inventory.addItem(item);
				return true; 
			}
			else {
				return false;
			}
		}
		public function removeFromInventory(item:*):void {
			inventory.removeItem(item);
		}
		public function setSlotItems():void
		{
			var currentSlot:WinSlot = new WinSlot(this);
			var maxItems:Array = inventory.getItems();
			var currentItem:int = 0;
			for (var i:int = 0; i < maxItems.length; i++)
			{
				currentSlot = aSlots[i];
				currentSlot.setItem(maxItems[currentItem]);
				currentItem++;
			}
		}
		
		private function setSlots():void
		{
			aSlots = [];
			for (var i:int = 0; i < 2; i++)
			{
				
				for (var j:int = 0; j < 7; j++)
				{
					var currentSlot:WinSlot = new WinSlot(this);
					currentSlot.width = 20;;
					currentSlot.height = 17;
					currentSlot.x = (j * currentSlot.width) + 16
					currentSlot.y = (i * currentSlot.height) + 14;
					currentSlot.addEventListener(MouseEvent.ROLL_OVER, setOver);
					RemoveSprite(currentSlot);
					addChild(currentSlot);
					aSlots.push(currentSlot);
				}
			}
		}
		
		public function retrieveItem(e:Event):void
		{
			var spr:Sprite = currentItem.getIcon();
			var par:* = spr.parent;
			if (spr.hitTestObject(this))
			{
			
				if (!inventory.isFull())
				{
					spr.removeEventListener(Event.ENTER_FRAME, retrieveItem);
					par.eraseItem();
					//RemoveSprite(currentItem.getIcon());
					spr.stopDrag();
					//mob.removeFromQuickSLot(currentItem); 
					inventory.addItem(currentItem);
				//	Main.glblPlayer.inventory.addItem(currentItem);
					setSlotItems();
				}
				else
				{
					spr.x = 0;
					spr.y = 0;
				}
			}
		}
		public function retrieveEquipment(e:Event):void{
			var spr:Sprite = currentItem.getIcon();
			var par:* = spr.parent;
			if (spr.hitTestObject(this))
			{
			
				if (!inventory.isFull())
				{
					var itemType:String = currentItem.getType().toLowerCase();
					if (itemType == "weapon" || itemType == "armor" || itemType == "shield"){
						spr.removeEventListener(Event.ENTER_FRAME, par.removeWeapon);
					}
					par.removeFromSlot(currentItem.getType().toLowerCase());
					//RemoveSprite(currentItem.getIcon());
					spr.stopDrag();
					//mob.removeFromQuickSLot(currentItem); 
					inventory.addItem(currentItem);
					//Main.glblPlayer.inventory.addItem(currentItem);
					setSlotItems();
					
				}
				else
				{
					spr.x = 0;
					spr.y = 0;
				}
			}
		}
		
		private function setOver(e:MouseEvent):void
		{
			var slot:WinSlot = e.currentTarget as WinSlot;
			setChildIndex(slot, numChildren - 1);
		}
		
		public function dragTo(e:MouseEvent):void
		{
			var slot:WinSlot = e.currentTarget as WinSlot;
			if (slot.getItem() != null)
			{
				var itemIco:Sprite = slot.getIcon();
				itemIco.addEventListener(MouseEvent.MOUSE_DOWN, dragging);
				itemIco.addEventListener(Event.REMOVED_FROM_STAGE, clearItem);
				if (slot.getItem().getType().toLowerCase() == "weapon" && equipWin != null)
				{
					equipWin.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, equipWin.checkWeaponSlot);
				}
				else if (slot.getItem().getType().toLowerCase() == "armor" && equipWin != null)
				{
					equipWin.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, equipWin.checkArmorSlot);
				}
				else if (slot.getItem().getType().toLowerCase() == "shield" && equipWin != null)
				{
					equipWin.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, equipWin.checkShieldSlot);
				}
				else if(slot.getItem().getType().toLowerCase() == "skill" && equipWin != null) {
					quickslot.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, quickslot.checkItemSlot);
				}
				else if (slot.getItem().getType().toLowerCase() == "item" && equipWin != null) {
					quickslot.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, quickslot.checkItemSlot);
				}
				else if (slot.getItem().getType().toLowerCase() == "leggings" && equipWin != null) {
					equipWin.currentItem = slot.getItem();
					itemIco.addEventListener(Event.ENTER_FRAME, equipWin.checkLeggingSlot);
				}
				
		
			}
		}
		
		private function dragging(e:MouseEvent):void
		{
			
			var spr:Sprite = e.currentTarget as Sprite;
			if(spr.parent.parent == this){
				spr.startDrag(false);
				spr.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			}
			//spr.addEventListener(Event.ENTER_FRAME, watchIcon);
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			spr.x = 0;
			spr.y = 0;
			spr.stopDrag();
			spr.removeEventListener(MouseEvent.MOUSE_DOWN, dragging);
			//spr.x = 0; spr.y = 0;
		}
		
		private function clearItem(e:Event):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			spr.removeEventListener(Event.ENTER_FRAME, equipWin.checkWeaponSlot);
			spr.removeEventListener(Event.ENTER_FRAME, equipWin.checkArmorSlot);
			spr.removeEventListener(Event.ENTER_FRAME, equipWin.checkShieldSlot);
			spr.removeEventListener(MouseEvent.MOUSE_DOWN, dragTo);
			spr.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}
	}
}
import Assets.Item;
import Assets.SoundClass;
import Assets.Utility.CenterObjRelTo;
import flash.display.Sprite;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.RemoveSprite;
import Assets.Utility.RemoveFilters;
import Assets.Utility.GlowObj;
import flash.events.MouseEvent;
import flash.text.TextField;
import Assets.Utility.DrawText;
import Assets.Effects.DropShadow;
import Assets.Utility.ChangeColor;

class WinSlot extends Sprite
{
	private var item:* = null;
	private var itemIco:Sprite = new Sprite();
	[Embed(source = "InventorySlot.png")]
	private var slotImg3:Class;
	private var bkgrnd:Sprite = new Sprite();
	private var win:InventoryWindow; 
	public function WinSlot(_win:InventoryWindow):void
	{
		width = 20;
		height = 20;
		bkgrnd = ConvertEmbedToSprite(slotImg3);
		win = _win;
		addChild(bkgrnd);
		addEventListener(MouseEvent.ROLL_OVER, glow);
		addEventListener(MouseEvent.ROLL_OUT, stopGlow);
		addEventListener(MouseEvent.ROLL_OVER, showTooltip);
	}
	
	public function setItem(_item:*):void
	{
		item = _item;
		if(item != null){
			itemIco = item.getIcon();
			itemIco.x = 0;
			itemIco.y = 0;
			refresh();
		}
	}
	public function hasItem():Boolean{
		return item != null;
	}
	public function getItem():*
	{
		return item;
	}
	
	public function getIcon():Sprite
	{
		return itemIco;
	}
	
	public function eraseItem():void
	{
		item = null;
		win.hoveredItem = null;
		RemoveSprite(itemIco);
		RemoveFilters(this);
		removeEventListener(MouseEvent.ROLL_OVER, showTooltip);
	
	}
	
	public function refresh():void
	{
		RemoveSprite(bkgrnd)
		RemoveSprite(itemIco);
		
		addChild(bkgrnd);
		addChild(itemIco)
	}
	
	public function glow(e:MouseEvent):void
	{
		GlowObj(this, 0xffffff, 4);
	}
	
	public function stopGlow(e:MouseEvent):void
	{

		if (item != null){
			win.hoveredItem = null; 
		}
		RemoveFilters(this);
	}
	
	public function showTooltip(e:MouseEvent):void
	{
		if (item != null && contains(itemIco))
		{
			var txt:TextField = DrawText(item.getName() + " ", 24);
			txt.x -= (340 - txt.width); 
			txt.y = 170;
			DropShadow(txt);
			addChild(txt);
			addEventListener(MouseEvent.ROLL_OUT, hideToolTip(txt));
			addEventListener(MouseEvent.MOUSE_DOWN, hideToolTip(txt));
			
			win.hoveredItem = item; 
		}
	}
	
	public function hideToolTip(tooltip:TextField):Function
	{
		return function(e:MouseEvent):void
		{
			RemoveSprite(tooltip);
		}
	}
}
