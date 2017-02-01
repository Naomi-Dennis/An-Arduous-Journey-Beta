package mobs 
{
	/**
	 * ...
	 * @author lk
	 */
	import items.armor.*;
	import items.weapon.*;
	import Screens.HelpScreen;
	import skills.*; 
	import items.*;
	import Assets.Utility.ConvertEmbedToSprite;
	public class PlayersLibrary 
	{
		[Embed(source = "../fem_red.png")]
		private static var femaleRedHair:Class; 
		[Embed(source = "../fem_black.png")]
		private static var femaleBlackHair:Class; 
		public function PlayersLibrary() 
		{
			
		}
		public static function createJack():Mob {
			var mob:Mob = new Mob();
			mob.setName("Jack");
			mob.setStatus( { "strength":8, "dexterity":3, "wisdom":5, "constitution":15, "defense":0 } );
			mob.setOriginalStats();
			mob.setMaxHp(15);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike()]);
			mob.equip(new Club());
			mob.equip(new BluePants()); 
			mob.equip(new LeatherArmor()); 
			mob.equip(new HatStraw());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createReggie():Mob {
			var mob:Mob = new Mob();
			mob.setName("Reggie");
			mob.setStatus( { "strength":2, "dexterity":6, "wisdom":8, "constitution":15, "defense":0 } );
			mob.setOriginalStats();
			mob.setMaxHp(15);
			mob.setArcher();
			mob.setQuickslot([new SingleShot()]);
			mob.equip(new Bow());
			mob.equip(new BluePants()); 
			mob.equip(new Vest());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createKahn():Mob {
			/*
			 * Things to Add:
			 * Robe 
			 * Staff
			 * */
			var mob:Mob = new Mob();
			mob.setName("Kahn");
			mob.setStatus( { "strength":2, "dexterity":2, "wisdom":6, "constitution":15, "defense":0 } );
			mob.setMaxHp(15);
			mob.setMage();
			mob.setQuickslot([new AirStrike()]);
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createArnold():Mob {
			//add staff
			//add robe
			var mob:Mob = new Mob();
			mob.setName("Arnold");
			mob.setStatus( { "strength":4, "dexterity":4, "wisdom":8, "constitution":30, "defense":0 } );
			mob.setMaxHp(30);
			mob.setMage();
			mob.setQuickslot([new SingleStrike(), new AirStrike(), new Heal()]);
			mob.equip(new BlueRobe());
			mob.equip(new Staff());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createKevin():Mob {
			var mob:Mob = new Mob();
			mob.setName("Kevin");
			mob.setStatus( { "strength":8, "dexterity":4, "wisdom":10, "constitution":30, "defense":12 } );
			mob.setMaxHp(30);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike(), new DefensiveStance()]);
			mob.equip(new Club());
			mob.equip(new BrownPants()); 
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createAlice():Mob {
			var mob:Mob = new Mob();
			mob.setName("Alice");
			mob.setStatus( { "strength":4, "dexterity":15, "wisdom":10, "constitution":30, "defense":0 } );
			mob.setMaxHp(30);
			mob.setArcher();
			mob.setQuickslot([new SingleStrike()]);
			mob.equip(new Bow());
			mob.equip(new ShirtYellowWhite());
			mob.equip(new BrownPants()); 
			mob.getMobIcon().setHair(femaleBlackHair)
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createTim():Mob {
			var mob:Mob = new Mob();
			mob.setName("Tim");
			mob.setStatus( { "strength":12, "dexterity":12, "wisdom":20, "constitution":45, "defense":0 } );
			mob.setMaxHp(45);
			mob.setMage();
			mob.setQuickslot([new AirStrike(), new FireStrike()]);
			mob.equip(new BookRed());
			mob.equip(new BrownRobe());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createTristan():Mob {
			var mob:Mob = new Mob();
			mob.setName("Tristan");
			mob.setStatus( { "strength":16, "dexterity":4, "wisdom":10, "constitution":45, "defense":0 } );
			mob.setMaxHp(45);
			mob.setMage();
			mob.setQuickslot([new AirStrike(), new DefensiveStance(), new Rage()]);
			mob.getMobIcon().genHair();
			mob.equip(new Katana());
			mob.equip(new IronLeggings());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createArthur():Mob {
			var mob:Mob = new Mob();
			mob.setName("Arthur");
			mob.setStatus( { "strength":16, "dexterity":16, "wisdom":13, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setQuickslot([new TripleStrike(), new Haste() , new ArmorPiercing()]);
			mob.equip(new Dagger()); 
			mob.equip(new HoodOrange());
			mob.equip(new Vest());
			mob.equip(new BrownPants()); 
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createJohn():Mob {
			var mob:Mob = new Mob();
			mob.setName("John");
			mob.setStatus( { "strength":16, "dexterity":16, "wisdom":30, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setMage();
			var stunStrike:StunStrike = new StunStrike();
			stunStrike.setRange(7);
			mob.setQuickslot([new AirStrike(), new IceAttack(), stunStrike, new Poison() ]);
			mob.equip(new StaffAnucis());
			mob.equip(new HatWizardBlackGold());
			mob.equip(new BrownRobe());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createTyler():Mob {
			var mob:Mob = new Mob();
			mob.setName("Tyler");
			mob.setStatus( { "strength":9, "dexterity":9, "wisdom":9, "constitution":45, "defense":0 } );
			mob.setMaxHp(45);
			mob.setWarrior();
			mob.setQuickslot([new DoubleStrike() ]);
			mob.equip(new Dagger());
			mob.equip(new HoodCyan());
			mob.equip(new Vest());
			mob.equip(new BrownPants());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createBrandon():Mob {
			var mob:Mob = new Mob();
			mob.setName("Brandon");
			mob.setStatus( { "strength":16, "dexterity":16, "wisdom":30, "constitution":30, "defense":0 } );
			mob.setMaxHp(45);
			var stun:StunStrike = new StunStrike();
			stun.setRange(2); 
			mob.setWarrior();
			mob.setQuickslot([new DoubleStrike(), stun, new ArmorPiercing() ]);
			mob.equip(new Katana());
			mob.equip(new FeatherHatGreen());
			mob.equip(new ShirtHawaii());
			mob.equip(new BrownPants());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createAstor():Mob {
			var mob:Mob = new Mob();
			mob.setName("Astor");
			mob.setStatus( { "strength":12, "dexterity":12, "wisdom":25, "constitution":45, "defense":0 } );
			mob.setMaxHp(45);
			mob.setMage();
			mob.equip(new BookBlue());
			mob.equip(new GreenRobe());
			mob.setQuickslot([new AirStrike(), new Anoint() ]);
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createBuster():Mob {
			var mob:Mob = new Mob();
			mob.setName("Buster");
			mob.setStatus( { "strength":25, "dexterity":4, "wisdom":10, "constitution":60, "defense":0 } );
			mob.setMaxHp(60);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike(), new DefensiveStance()]);
			mob.equip(new StuddedLeatherArmor());
			mob.equip(new BrownPants());
			mob.equip(new Morningstar());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 	
		}
		public static function createTuco():Mob {
			var mob:Mob = new Mob();
			mob.setName("Tuco");
			mob.setStatus( { "strength":40, "dexterity":4, "wisdom":10, "constitution":72, "defense":0 } );
			mob.setMaxHp(72);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike(), new Rage(), new DefensiveStance()]);
			mob.equip(new ShirtYellowWhite());
			mob.equip(new HatWizardBlackGold());
			mob.equip(new Katana());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createSteve():Mob {
			var mob:Mob = new Mob();
			mob.setName("Steve");
			mob.setStatus( { "strength":50, "dexterity":4, "wisdom":10, "constitution":90, "defense":0 } );
			mob.setMaxHp(90);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike()]);
			mob.equip(new Katana());
			mob.equip(new IronLeggings());
			mob.equip(new Chainmail()); 
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function Goury():Mob {
			var mob:Mob = new Mob();
			mob.setName("Goury");
			mob.setStatus( { "strength":60, "dexterity":4, "wisdom":1, "constitution":100, "defense":0 } );
			mob.setMaxHp(100);
			mob.setWarrior();
			mob.setQuickslot([new SingleStrike(), new DefensiveStance(), new ArmorPiercing()]);
			mob.equip(new OrchishLongsword());
			mob.equip(new IronLeggings());
			mob.equip(new Chainmail()); 
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 	
		}
		public static function createGus():Mob {
			var mob:Mob = new Mob();
			mob.setName("Gus");
			mob.setStatus( { "strength":10, "dexterity":30, "wisdom":30, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setArcher();
			mob.setQuickslot([new DoubleShot(), new NailArrow(), new FireArrow()]);
			mob.equip(new HoodOrange());
			mob.equip(new BrownPants());
			mob.equip(new ShirtBlack());
			mob.equip(new Bow()); 
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 	
		}
		public static function createWalter():Mob {
			var mob:Mob = new Mob();
			mob.setName("Walter");
			mob.setStatus( { "strength":10, "dexterity":25, "wisdom":25, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setArcher();
			mob.setQuickslot([new SingleShot()]);
			mob.equip(new Bow());
			mob.equip(new Vest());
			mob.equip(new FeatherHatGreen());
			mob.equip(new BrownPants());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createJessie():Mob {
			var mob:Mob = new Mob();
			mob.setName("Jessie");
			mob.setStatus( { "strength":15, "dexterity":15, "wisdom":0, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setWarrior();
			mob.setQuickslot([new DoubleStrike(), new IncreaseMovement(), new PressurePoints()]);
			mob.equip(new IronLeggings());
			mob.equip(new BluePants());
			mob.equip(new ShirtHawaii());
			mob.equip(new OrchishShortSword());
			mob.getMobIcon().genHair();
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createLee():Mob {
			var mob:Mob = new Mob();
			mob.setName("Lee");
			mob.setStatus( { "strength":30, "dexterity":15, "wisdom":10, "constitution":40, "defense":0 } );
			mob.setMaxHp(40);
			mob.setWarrior();
			mob.setQuickslot([new TripleStrike(), new IncreaseMovement(), new PressurePoints()]);
			mob.equip(new BluePants());
			mob.equip(new Scarf());
			mob.equip(new Dagger());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createBeeBee():Mob {
			var mob:Mob = new Mob();
			mob.setName("BeeBee");
			mob.setStatus( { "strength":25, "dexterity":25, "wisdom":0, "constitution":50, "defense":0 } );
			mob.setMaxHp(50);
			mob.setWarrior();
			mob.setQuickslot([new TripleStrike(), new IncreaseMovement(), new PressurePoints()]);
			mob.equip(new Dagger());
			mob.equip(new HatWizardBlackGold());
			mob.equip(new ShirtBlack());
			mob.equip(new BrownPants());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createLina():Mob {
			var mob:Mob = new Mob();
			mob.setName("Lina");
			mob.setStatus( { "strength":15, "dexterity":15, "wisdom":35, "constitution":20, "defense":0 } );
			mob.setMaxHp(20);
			var stun:StunStrike = new StunStrike();
			stun.setRange(7);
			mob.setMage();
			mob.setQuickslot([new FireStrike(), new Heal(), stun]);
			mob.equip(new Katana());
			mob.equip(new BlueCape());
			mob.equip(new BrownRobe());
			mob.getMobIcon().setHair(femaleRedHair)
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createAmelia():Mob {
			//add robe
			//add staff
			var mob:Mob = new Mob();
			mob.setName("Amelia");
			mob.setStatus( { "strength":15, "dexterity":15, "wisdom":35, "constitution":35, "defense":0 } );
			mob.setMaxHp(35);
			mob.setMage();
			mob.setQuickslot([new Heal(), new Anoint(), new AirStrike()]);
			mob.equip(new Dagger());
			mob.equip(new StaffAnucis());
			mob.equip(new BlueRobe());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
		public static function createScott():Mob {
			//add haste
			//add shirt
			var mob:Mob = new Mob();
			mob.setName("Scott");
			mob.setStatus( { "strength":33, "dexterity":33, "wisdom":15, "constitution":60, "defense":0 } );
			mob.setMaxHp(60);
			mob.setWarrior();
			mob.setQuickslot([new DoubleStrike(), new IncreaseMovement(), new Haste()]);
			mob.equip(new Dagger());
			mob.equip(new ShirtYellowWhite());
			mob.equip(new BrownPants());
			mob.setBattlePiece();
			mob.setInitialState(); 
			return mob; 
		}
	}

}