package 
{
	import Assets.Utility.DeepCopy;
	import Assets.Utility.GetAliasInformation;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class ArmyHanger 
	{
		private var army:Array = new Array()
		private  var current:Array = []; 
		public var loaded:Boolean = false; 
		public function ArmyHanger(initArmy:Array) 
		{
			army = initArmy;
		}
		public function deleteAll():void {
			army = [];
		}
		public function setCurrent(aCurrent:Array):void {
			current = aCurrent;
		}
		public function getCurrent():Array {
			return current; 
		}
		public function clearCurrents():void{
			current = []; 
		}
		public function addToCurrent(personnel:Mob):void {
			current.push(personnel);
		}
		public function getArmy():Array {
			var returnedArmy:Array = [];
			var properName:Object = { }
			var currentMob:Mob = null;
		/*	for (var i:* in army) {
				currentMob = army[i]; 
				properName = GetAliasInformation(currentMob);
				//returnedArmy.push( DeepCopy(currentMob, properName.className, properName.path) ); 
			}
			*/
			return army; 
		}
		public function setArmy(newArmy:Array):void {
			army = newArmy;
		}
		public function add(recruit:Mob):void {
			army.push(recruit);
		}
		public function remove(badRecruit:Mob):void {
			for (var i:* in army) {
				if (army[i] == badRecruit) {
					(i == 0) ? army.splice(0, 1) : army.splice(i, 1); 
				}
			}
		}
		public function resetPersonnel():void {
			//delete if not used
			for (var i:* in army) {
				Mob(army[i]).resetMob(); 
			}
		}
		
	}

}