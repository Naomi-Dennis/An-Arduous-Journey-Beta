package
{
	import Assets.Inventory;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	;
	import flash.events.Event;
	;
	
	/**
	 * ...
	 * @author lk
	 */
	public class QuickslotWindow extends Sprite
	{
		
		private var aSlots:Array = [];
		private var mob:Mob;
		private var inventoryWin:InventoryWindow;
		public var currentItem:*;
		public var hoveredItem:*;
		
		public function QuickslotWindow(_mob:Mob)
		{
			mob = _mob;
			initSlots();
			setSlots();
			addEventListener(Event.REMOVED_FROM_STAGE, saveVars);
		}
		
		private function saveVars(e:Event):void
		{
			var currentItems:Array = [];
			for (var i:* in aSlots)
			{
				currentItems.push(aSlots[i].getItem());
			}
			mob.setQuickslot(currentItems);
		}
		
		public function setInventoryWin(_inventoryWin:InventoryWindow):void
		{
			inventoryWin = _inventoryWin;
		}
		
		private function initSlots():void
		{
			var currentSlot:EasySlot = new EasySlot(this);
			for (var i:int = 0; i < 7; i++)
			{
				currentSlot = new EasySlot(this);
				if (i > 0)
				{
					currentSlot.x = aSlots[i - 1].x + aSlots[i - 1].width;
				}
				currentSlot.addEventListener(MouseEvent.MOUSE_DOWN, setDragTo);
				aSlots.push(currentSlot);
				addChild(currentSlot);
			}
		}
		
		private function setSlots():void
		{
			var items:Array = mob.getQuickSlots();
			var maxItems:int = items.length;
			var currentSlot:EasySlot = new EasySlot(this);
			for (var i:* in aSlots)
			{
				currentSlot = aSlots[i];
				if (i < maxItems && items[i] != null)
				{
					currentSlot.setSlot(items[i]);
					RemoveSprite(currentSlot);
					addChild(currentSlot);
					
				}
			}
		}
	
		private function setDragTo(e:MouseEvent):void
		{
			
			var slot:EasySlot = e.currentTarget as EasySlot;
			if (slot.hasObject())
			{
				var spr:Sprite = slot.getItem().getIcon();
				spr.startDrag();
				mob.removeFromQuickSLot(slot.getItem());
				inventoryWin.currentItem = slot.getItem();
				spr.addEventListener(Event.ENTER_FRAME, inventoryWin.retrieveItem);
			}
		}
		
	
		
		private function hitSlotBounds(spr:*, target:*):Boolean
		{
			var targetCoords:Point = new Point(target.x + 110, target.y + 218);
			var sprCoords:Point = new Point(spr.x + 49, spr.y + 217); 
			var offset:int = 5;
			var originX:Number = sprCoords.x + offset;
			var originY:Number = sprCoords.y + offset;
			var slotWidth:Number = (originX + spr.width) - offset;
			var slotHeight:Number = (originY + spr.height) - offset;
			if (targetCoords.x > originX && targetCoords.x < slotWidth)
			{
				if (targetCoords.y > originY && targetCoords.y < slotHeight)
				{
					return true;
				}
			}
			return false;
		}
		
		private function removeDragTo(e:MouseEvent):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			spr.stopDrag();
			spr.x = 0;
			spr.y = 0;
			spr.removeEventListener(Event.ENTER_FRAME, inventoryWin.retrieveItem);
			spr.removeEventListener(MouseEvent.MOUSE_UP, removeDragTo);
		}
		
		public function checkItemSlot(e:Event):void
		{
			var spr:Sprite = currentItem.getIcon();
			var par:* = spr.parent;
			var currentSlot:EasySlot = null;
			for (var i:* in aSlots)
			{
				currentSlot = aSlots[i];
				if (spr.hitTestObject(currentSlot) && !currentSlot.hasObject())
				{
					break;
				}
			}
			if (currentSlot != null && spr.hitTestObject(currentSlot) && !currentSlot.hasObject())
			{
				currentItem.getIcon().removeEventListener(Event.ENTER_FRAME, checkItemSlot);
				inventoryWin.removeFromInventory(currentItem);
				
				par.eraseItem();
				spr.stopDrag();
				spr.x = 0;
				spr.y = 0;
				currentSlot.setSlot(currentItem);
				setSlots();
				
			}
		
		}
	
	}

}
import Assets.Item;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import Assets.Item;
import Assets.Utility.RemoveSprite;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import flash.text.TextField;
import Assets.Utility.DrawText;
;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.CenterObjRelTo;
import Assets.Effects.DropShadow;

class EasySlot extends Sprite
{
	[Embed(source = "pics/EquipmentWindow/itemImg.png")]
	private var slotImg2:Class;
	private var object:*;
	private var ownObject:Boolean = false;
	private var objImg:Sprite = new Sprite();
	private var bkgrnd:Sprite = new Sprite();
	private var win:QuickslotWindow;
	
	public function EasySlot(_win:QuickslotWindow):void
	{
		win = _win;
		bkgrnd = ConvertEmbedToSprite(slotImg2);
		bkgrnd.width = 32;
		bkgrnd.height = 32;
		addChild(bkgrnd);
		addEventListener(MouseEvent.ROLL_OVER, showTooltip);
		addEventListener(MouseEvent.ROLL_OVER, glow);
		addEventListener(MouseEvent.ROLL_OUT, stopGlow);
	}
	
	private function glow(e:MouseEvent):void
	{
		GlowObj(bkgrnd, 0xffffff, 4);
	}
	
	private function stopGlow(e:MouseEvent):void
	{
		if (object != null)
		{
			win.hoveredItem = null;
		}
		RemoveFilters(bkgrnd);
	}
	
	public function setSlot(obj:*):void
	{
		
		object = obj;
		ownObject = true;
		objImg = obj.getIcon();
		RemoveSprite(objImg);
		objImg.x = 0;
		objImg.y = 0;
		objImg.width = bkgrnd.width;
		objImg.height = bkgrnd.height;
		addChild(objImg);
	}
	
	public function eraseItem():void
	{
		object = null;
		win.hoveredItem = null;
		RemoveSprite(objImg);
		ownObject = false;
		
	}
	
	public function getItem():*
	{
		return object;
	}
	
	public function hasObject():Boolean
	{
		return ownObject;
	}
	
	private function removeGlow(e:MouseEvent):void
	{
		RemoveFilters(this);
	}
	
	public function showTooltip(e:MouseEvent):void
	{
		if (object != null && contains(objImg))
		{
			var txt:TextField = DrawText(object.getName(), 24);
			txt.y = this.y + 30
			txt.x = (this.parent).x - 42;
			DropShadow(txt);
			GlowObj(txt, 0xffffff, 4);
			if (hasObject())
			{
				addChild(txt);
			}
			addEventListener(MouseEvent.ROLL_OUT, hideToolTip(txt));
			addEventListener(MouseEvent.MOUSE_DOWN, hideToolTip(txt));
			win.hoveredItem = object;
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