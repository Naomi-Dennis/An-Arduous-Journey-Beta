package 
{
	/**
	 * ...
	 * @author lk
	 */
	public class BackgroundList 
	{
		
		[Embed(source="pics/backgrounds/Basement.png")]
		public static var basementClass:Class;
		[Embed(source = "pics/backgrounds/barracks.png")]
		public static var barracksClass:Class;
		[Embed(source = "pics/backgrounds/Courtyard Continuation.png")]
		public static var courtyardContClass:Class;
		[Embed(source = "pics/backgrounds/Courtyard.png")]
		public static var courtyardClass:Class;
		[Embed(source = "pics/backgrounds/Great Hall to Throne Room.png")]
		public static var greatHallToThroneClass:Class;
		[Embed(source = "pics/backgrounds/Great Hall.png")]
		public static var greatHallClass:Class;
		[Embed(source = "pics/backgrounds/Heavy Forest Battle.png")]
		public static var heavyForestClass:Class;
		[Embed(source = "pics/backgrounds/prison.png")]
		public static var prisonClass:Class;
		[Embed(source = "pics/backgrounds/Throne Room.png")]
		public static var throneRoomClass:Class;
		[Embed(source = "pics/backgrounds/woods surrounded by bandits.png")]
		public static var woodsSurroundedClass:Class;
		[Embed(source = "pics/backgrounds/woods.png")]
		public static var woodsClass:Class;
		[Embed(source = "pics/backgrounds/Old Pasture.png")]
		public static var oldPastureClass:Class; 
		[Embed(source = "pics/backgrounds/Sewers.png")]
		public static var sewersClass:Class; 
		[Embed(source = "pics/backgrounds/swamp.png")]
		public static var swampClass:Class;
		[Embed(source="pics/backgrounds/Hell Battleground.png")]
		public static var hellClass:Class; 
		[Embed(source = "pics/backgrounds/firstTown.png")]
		public static var firstTownClass:Class; 
		[Embed(source = "pics/backgrounds/destroyedTown.png")]
		public static var destroyedTownClass:Class;
		private static var field:Field = new Field();
		public function BackgroundList() 
		{
			
		}
		public static function createObject(bkgrndClass:Class, fieldObj:Field):Object {
			return { background:bkgrndClass, field:fieldObj }; 
		}
		public static function heavyforest():Object {
			field = new Field();
			field.createDirtyField();
			field.placeTrees();
			return createObject(heavyForestClass, field); 
		}
		public static function dirtyfield():Object{
			field = new Field();
			field.createDirtyField();
			field.placeTrees();
			return createObject(heavyForestClass, field); 
		}
		public static function destroyedtown():Object {
			field = new Field(); 
			field.createBloodyCobblestone();
			return createObject(destroyedTownClass, field); 
		}
		public static function firsttown():Object {
			field = new Field();
			field.createDirtyField();
			return createObject(firstTownClass, field); 
		}
		public static function basement():Object {
			field = new Field();
			field.createMeshFloor();
			return createObject(basementClass, field);
		}
		public static function barracks():Object {
			field = new Field();
			field.createPrisonFloor();
			return createObject(barracksClass, field);
		}
		public static function hell():Object {
			field = new Field();
			field.createMudFloor();
			return createObject(hellClass, field);
		}
		public static function hellwithfire():Object{
			field = new Field();
			field.createMudFloor();
			return createObject(hellClass, field);
		}
		public static function swamp():Object {
			field = new Field();
			field.createSwampFloor();
			return createObject(swampClass, field);
		}
		public static function sewers():Object {
			field = new Field();
			field.createPrisonFloor();
			return createObject(sewersClass, field);
		}
		public static function plains():Object {
			field = new Field();
			field.createMeadowField();
			return createObject(oldPastureClass, field); 
		}
		public static function woods():Object {
			field = new Field();
			field.createGrassLandWithTreesField();
			return createObject(woodsClass, field);
		}
		public static function woodssurrounded():Object {
			field = new Field();
			field.createGrassLandWithTreesField();
			return createObject(woodsSurroundedClass, field); 
		}
		public static function throneRoom():Object {
			field = new Field();
			field.createCobblestoneField();
			return createObject(throneRoomClass, field);
		}
		public static function courtyard():Object {
			field = new Field();
			field.createMeadowField();
			return createObject(courtyardClass, field);
		}
		public static function greatHall():Object {
			field = new Field();
			field.createCobblestoneField();
			return createObject(greatHallClass, field);
		}
		public static function prison():Object {
			field = new Field();
			field.createPrisonFloor();
			return createObject(prisonClass, field); 
		}
		
		
	}

}