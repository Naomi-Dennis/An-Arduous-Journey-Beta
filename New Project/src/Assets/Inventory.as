package Assets  
{
	/**
	 * @author Naomi J. Dennis
	 */
	public class Inventory 
	{
		private var contents:Array = [];
		private var size:int = 0;
		private var owner:Mob = null; 
		public function Inventory(_size:int=0, _owner:Mob=null) 
		{
			size  = _size; 
			owner = _owner; 
		}
		public function getItems():Array {
			return contents; 
		}
		public function getItemsOfType(type:String):Array {
			var currentItem:* = null;
			var itemType:String = type.toLowerCase();
			var items:Array = [];
			for (var i:* in contents) {
				currentItem = contents[i]; 
				if (currentItem.getType().toLowerCase() == itemType) {
					items.push(currentItem); 
				}
			}
			return items; 
		}
		public function addItem(item:*):void {
			(owner != null ) ? item.setOwner(owner) : null;
			
			(!isFull()) ? contents.push(item) : null; 
		}
		
		public function removeItem(item:*):void {
			var index:int = getItemIndex(item); 
			(index == 0) ? contents.splice(0, 1) : contents.splice(index, 1); 
		}
		
		public function getItemByName(name:String):* {
			var currentItem:* = null;
			for (var i:* in contents) {
				currentItem = contents[i]; 
				if (currentItem.getName().toLowerCase() == name.toLowerCase()) {
					return currentItem;
				}
			}
			return currentItem;
		}
		public function setItems(items:Array):void {
			contents = [];
			for (var i:* in items) {
				addItem(items[i]); 
			}
		}
		public function getItemIndex(item:*):int {
			var currentItem:* = null;
			for (var i:* in contents) {
				currentItem = contents[i]; 
				if (item == currentItem) {
					return i; 
				}
			}
			return -1; 
		}
		
		public function getItemByIndex(index:int):* {
			return contents[index]; 
		}
		
		public function isFull():Boolean {
			return (contents.length >= size);
		}
		
		public function nUsedSlots():int {
			for (var i:* in contents) {
				if (contents[i] != null) {
					i++;
				}
				else {
					break;
				}
			}
			return i;
		}
		
		public function nFreeSlots():int {
			return (size - contents.length); 
		}
		public function getsize():int {
			return size;
		}
		
	}

}