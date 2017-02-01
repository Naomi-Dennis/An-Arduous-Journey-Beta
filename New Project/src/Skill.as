package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Skill 
	{
		protected var ap:int = 0;
		protected var cooldown:int = 0; // current cooldown
		protected var maxCooldown:int = 0; 
		protected var name:String = "NAME";
		protected var desc:String = "DESCRIPTION";
		protected var icon:Sprite = new Sprite(); 
		protected var owner:Mob = null; 
		protected var snd:Object = { }; //chnage this to sound
		protected var rangeShape:String = "circle"; 
		protected var range:int = 1;
		private var type:String = "Skill";
		private var nValue:int = 9999999; 
		public var callback:Function;
		public function Skill(_name:String="None", _ap:int=0, _maxCooldown:int=0, _desc:String="None") 
		{
			maxCooldown = _maxCooldown;
			name = _name; 
			ap = _ap;
			SkillLib.addSkill(name, _ap, _maxCooldown); 
			desc = _desc;
		}
		public function setRange(newRange:int):void {
			range = newRange;
		}
		public function getValue():int {
			return nValue;
		}
		public function getName():String {
			return name; 
		}
		public function getAp():int {
			return ap;
		}
		public function getType():String {
			return type;
		}
		public function returnType():String {
			return type; 
		}
		public function getRangeShape():String {
			return rangeShape; 
		}
		public function getRange():int {
			return range; 
		}
		public function setOwner(newOwner:Mob):void {
			owner = newOwner; 
		}
		public function getOwner():Mob {
			return owner; 
		}
		public function getIcon():Sprite {
			return icon; 
		}
		public function changeIcon(newIcon:Sprite):void {
			icon = newIcon; 
		}
		public function perform(tgt:Mob):String {
			return "";
		}
		public function getCompleteDesc():String {
			var string:String = ""; 
			string += name + "\n\n";
			string += "cooldown: " + maxCooldown.toString() + "\n\n";
			string += "AP: " + ap.toString() + "\n\n";
			string += desc + "\n";
			return string;
		}
		public function playSnd():void {
			//play sound //play the sound file
		}
		public function resetCooldown():void {
			 cooldown = 0; 
		}
		public function onCooldown():Boolean {
			return cooldown > 0;
		}
		public function triggerCooldown():void{
			if (maxCooldown == 0){
				maxCooldown = SkillLib.getCooldown(name); 
				maxCooldown = cooldown;
			}
			cooldown = maxCooldown; 
		}
		public function getCooldown():int {
			
			return cooldown;
		}
		public function deductCooldown():void {
			
			if (onCooldown()) {
				cooldown--;
			}
		}
	}

}