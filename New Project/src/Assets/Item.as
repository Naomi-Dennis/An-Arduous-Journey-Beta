package Assets  
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Item 
	{
		private var name:String = "none";
		private var icon:Sprite = new Sprite();
		private var nValue:int = 99999999999999999;
		private var type:String = "Item";
		private var owner:Mob = null;
		private var power:int = 0;
		protected var specialFoo:Function = null;
		private var useable:Boolean = false; 
		private var desc:String = "DESCRIPTION"; 
		private var target:Mob = null;
		private var enhancements:Object = { strength:0, dexterity:0, wisdom:0 }; 
		private var mobVersion:Class; 
		public function Item(_name:String="none", _nValue:int=9999999, _power:int=0, _desc:String="None", _type:String="Item", _useable:Boolean=false) 
		{
			name = _name;
			nValue = _nValue;
			power = _power; 
			desc = _desc;
			type = _type;
			useable = _useable; 
		}
		protected function setMobVersion(className:Class):void {
			mobVersion = className;
		}
		public function getMobVersion():Sprite {
			return ConvertEmbedToSprite(mobVersion);
		}
		public function getMobVersionClass():Class{
			return mobVersion;
		}
		
		public function setEnchancements(attr:String, val:int):void {
			enhancements[attr] = val; 
		}
		public function getEnhancements():Object {
			return enhancements; 
		}
		public function resetEnhancements():void {
			enhancements = { strength:0, dexterity:0, wisdom:0 }; 
		}
		public function setTarget(newTarget:Mob):void {
			target = newTarget; 
		}
		public function canUse():Boolean {
			return useable; 
		}
		public function getPower():int {
			return power; 
		}
		public function getName():String {
			return name;
		}
		public function getIcon():Sprite {
			return icon; 
		}
		public function getValue():Number {
			return nValue;
		}
		public function getOwner():Mob {
			return owner; 
		}
		public function getType():String {
			return type; 
		}
		public function getCompleteDesc():String {
			var string:String = ""; 
			string += name + "\n\n";
			string += desc + "\n";
			for (var i:* in enhancements) {
				if (this.enhancements[i] > 0) {
					string += (i + " + " + enhancements[i]); 
				}
				else if (this.enhancements[i] < 0) {
						string += (i + " - " + enhancements[i]);  
				}
			}
			if (type.toLowerCase() == "weapon"){
				string += "\nPower : " + power.toString() + "\n";
			}
			else if (type.toLowerCase() == "armor"){
				string += "\n\nDefense : " + power.toString() + "\n";
			}
			return string;
		}
		public function useItem():void {
			(target == null) ? target = owner : null;
			specialFoo(target); 
			target.inventory.removeItem(this); 
		}
		public function setFoo(foo:Function):void {
			specialFoo = foo; 
		}
		public function setOwner(newOwner:Mob):void {
			owner = newOwner; 
		}
		public function setUseability(_useable:Boolean):void {
			useable = _useable; 
		}
		public function setIcon(newIcon:Sprite):void {
			icon = newIcon; 
		}
	}

}