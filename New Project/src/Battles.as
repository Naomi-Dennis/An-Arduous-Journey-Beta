package 
{
	import Assets.Utility.RandomNumber;
	import mobs.CampaignEnemies.BanditWithSword;
	import mobs.Enemies.Rat;
	/**
	 * ...
	 * @author lk
	 */
	public class Battles 
	{
		[Embed(source = "pics/backgrounds/barracks.png")]
		public static var barracks:Class;
		[Embed(source = "pics/backgrounds/Courtyard Continuation.png")]
		public static var courtyardCont:Class;
		[Embed(source = "pics/backgrounds/Courtyard.png")]
		public static var courtyard:Class;
		[Embed(source = "pics/backgrounds/Great Hall to Throne Room.png")]
		public static var greatHallToThrone:Class;
		[Embed(source = "pics/backgrounds/Great Hall.png")]
		public static var greatHall:Class;
		[Embed(source = "pics/backgrounds/Heavy Forest Battle.png")]
		public static var heavyForest:Class;
		[Embed(source = "pics/backgrounds/prison.png")]
		public static var prison:Class;
		[Embed(source = "pics/backgrounds/Throne Room.png")]
		public static var throneRoom:Class;
		[Embed(source = "pics/backgrounds/woods surrounded by bandits.png")]
		public static var woodsSurrounded:Class;
		[Embed(source = "pics/backgrounds/woods.png")]
		public static var woods:Class;
		[Embed(source = "pics/backgrounds/Old Pasture.png")]
		public static var oldPasture:Class; 
		[Embed(source = "pics/backgrounds/Sewers.png")]
		public static var sewers:Class; 
		[Embed(source = "pics/backgrounds/swamp.png")]
		public static var swamp:Class;
		[Embed(source="pics/backgrounds/Hell Battleground.png")]
		public static var hell:Class; 
		public static var field:Field = new Field()
		public static var army:ArmyHangerGUI = new ArmyHangerGUI();
		public function Battles() 
		{
			
		}
		public static function level1(currentArmy:Array):BattleClass {
			field = new Field();
			field.createPrisonFloor();
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), [new Rat()], prison, true);
			return battle; 
		}
		
		public static function generateMonsters(monsters:Array, maxNum:int):Array {
			var rand:int = RandomNumber(monsters.length, 1); 
			var array:Array = [new monsters[rand - 1]()];
			if (maxNum == 0) {
				return []; 
			}
			else {
				return array.concat( generateMonsters(monsters, maxNum - 1) ); 
			}
		}
		
		public static function newBattle(field:Field, monsters:Array, bkgrnd:Class, tut:Boolean):BattleClass {
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), monsters, bkgrnd, tut);
			return battle; 
		}
		
		public static function battleStorageRoom(monsters:Array):BattleClass {
			field = new Field();
			field.createPrisonFloor();
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), monsters, prison, true); 
			return battle; 
		}
		public static function battleForest(monsters:Array):BattleClass {
			field = new Field();
			field.createGrassLandWithTreesField();
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), monsters, heavyForest, true); 
			return battle; 
		}
		public static function battleBarracks(monsters:Array):BattleClass {
			field = new Field();
			field.createPrisonFloor();
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), monsters, heavyForest, true); 
			return battle; 
		}
		public static function battleFaddedGrassForest(monsters:Array):BattleClass {
			field = new Field();
			field.createTressWithDirtyGrassField();
			var battle:BattleClass = new BattleClass(field, Main.army.getCurrent(), monsters, heavyForest, true); 
			return battle; 
		}

		
	}

}