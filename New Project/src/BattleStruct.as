package 
{
	import Assets.Utility.RandomNumber;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	 
	import Screens.MissionDialog;
	import Towns.MissionStruct;
	/**
	 * ...
	 * @author lk
	 */
	public class BattleStruct extends Sprite
	{
		public var aEnemies:Array = [];
		public var nEnemies:int = 0;
		public var bkgrnd:Object;
		public var monsters:Array = []; 
		public var isTut:Boolean = false; 
		public var nextFoo:Function; 
		public var myPar:MissionStruct;
		private var bkgrndData:String ;
		public function BattleStruct(_nEnemies:String, _bkgrnd:String, _aEnemies:Array) 
		{
			bkgrndData = _bkgrnd; 
			
			if (_nEnemies.length > 1){
				var nums:Array = _nEnemies.split("-"); 
				nEnemies = RandomNumber( parseInt(nums[1]), parseInt(nums[0])); 
			}
			else{
				nEnemies = parseInt(_nEnemies);
			}
			
			var enemyClass:*;
			var foo:Function; 
			for (var i:* in _aEnemies) {
				var name:String = _aEnemies[i].toLowerCase()
				foo = EnemiesList[name]			
				aEnemies.push(foo());
			}
		}
		private function nextFunc():void {
			myPar.nextFoo();
		}
		public function render():void {
			bkgrnd = BackgroundList[bkgrndData.toLowerCase()](); 
			monsters = Battles.generateMonsters(aEnemies, nEnemies); 
			var battle:BattleClass = Battles.newBattle(bkgrnd.field, monsters, bkgrnd.background, isTut);
			battle.setNextFoo(nextFunc);
			battle.signalFight();
			addChild(battle); 
		}
		
	}

}

