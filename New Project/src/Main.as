package
{
	import Screens.ArmyHangerWindows;
	import Screens.InBattleRewardScreen;
	import Assets.Inventory;
	import Assets.SoundClass;
	import Assets.Utility.AddSound;
	import Assets.Utility.CloningSprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.PlaceObjNextTo;
	import Screens.TutorialMessage;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.utils.getAliasName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import items.Antidote;
	import items.ConstitutionBook;
	import items.DexterityPotion;
	import items.HealthPotion;
	import items.MysteriousKey;
	import items.PrizeBox;
	import items.StrengthBook;
	import items.Torch;
	import items.weapon.BookBlack;
	import items.weapon.BookBlue;
	import items.weapon.BookRed;
	import items.weapon.BookWhite;
	import items.weapon.Bow;
	import items.weapon.Club;
	import items.weapon.Crossbow;
	import items.weapon.Katana;
	import items.weapon.Morningstar;
	import items.weapon.OrchishGreatSword;
	import items.WisdomBook;
	import items.WisdomPotion;
	import mobs.Players.Beserker_Tristan;
	import mobs.Players.SerYork;
	import Screens.GetSkillScreen;
	import Screens.TownScreen;
	import org.flashdevelop.utils.FlashConnect;
	import skills.Fear;
	import skills.IncreaseMovement;
	import skills.LifeSteal;
	import skills.NailArrow;
	import skills.Parry;
	import skills.Rage;
	import Screens.SplashScreen;
	import Screens.TitleScreen;
	import Screens.TownScreen;
	import flash.utils.ByteArray;
	import flash.net.registerClassAlias;
	import mobs.PlayersLibrary;
	import skills.SingleShot;
	import items.*; 
	import items.armor.*;
	import Assets.Utility.*;
	import Screens.OptionScreen;;
	import flash.utils.*;
	/**
	 * ...
	 * @author Naomi J. Dennis
	 */
	public class Main extends Sprite
	{
		[Embed(source="snd/theme.mp3")]
		private var theme:Class;
		[Embed(source = "snd/Theme 4.mp3")]
		private var theme2:Class; 
		[Embed(source = "snd/AIR_L._Red_Houfe Theme.mp3")]
		private var theme3:Class;
		[Embed(source = "music ico.png")]
		private var musicIco:Class;
		[Embed(source = "sndIco.png")]
		private var sndIco:Class; 
		//[Embed(source = "pics/backgrounds/Heavy Forest Battle.png")]
		//private var img:Class; 
		public static var sndConfig:SoundClass = new SoundClass();
		public static var musicConfig:SoundClass = new SoundClass();
		public static var ambienceConfig:SoundClass = new SoundClass();
		private static var so:SharedObject = SharedObject.getLocal("finalTesting45"); //saved object  
		public static var playerProgress:Object = { savedArmy:null };
		public static var playerMob:Object = { mob:null };
		public static var glblPlayer:PlayerStruct = new PlayerStruct();
		public static var army:ArmyHanger = new ArmyHanger([]);
		[Embed(source="map4.png")]
		private var img:Class; 
		public function Main()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			musicConfig.setSongClasses( [theme, theme2, theme3] );
			musicConfig.changeMaxNumSongs(3);
			musicConfig.setPlayListToTrue();
			musicConfig.playSound();
			SndLib.lakeside();
			addChild(new TitleScreen());
			
			var bitmapData:BitmapData = new BitmapData(32, 32, true, 0x0);
			var options:Sprite = DrawButton("Options", 24); 
			options.x = 540 - options.width - 10; 
			options.y = 5; 
			addChild(options); 
			
			options.addEventListener(MouseEvent.CLICK, optionsWin);
			stage.addEventListener(MouseEvent.CLICK, test);
			
			var obj:Object = { };
			obj.prop = "sdfsf"; 
			FlashConnect.trace(obj.hasOwnProperty("prop"));
			delete obj.prop;
			 	FlashConnect.trace(obj.hasOwnProperty("prop"));
			
		}
		private function test(e:MouseEvent):void{
			
		}
		private function optionsWin(e:MouseEvent):void{
			var win:OptionScreen = new OptionScreen();
			win.x = 540 / 2 - win.width / 2;
			win.y = 540 / 2 - win.height / 2; 
			addChild(win);
		}
		public static function saveGame():void
		{
			/// save the game using byte array
			registerClassAlias("Mob", Mob);
			registerClassAlias("Skill", Skill);
			var ba:ByteArray = new ByteArray();
			var savedData:* = Main.glblPlayer.setSaveObject(); 
			ba.writeObject(savedData);
			ba.position = 0; 
			so.data.game5 = ba; 
			so.flush();
		}
		
		public static function loadGame():Boolean
		{
			if (so.data.hasOwnProperty("game5"))
			{
				var ba:ByteArray = new ByteArray();
				ba = so.data.game5;
				ba.position = 0;
				var loadedData:Object = ba.readObject();
				
				glblPlayer.loadSaveObject( loadedData ); 
				
				return true; 
			}
			else
			{
				so.data.game5 = new Object();
				return false; 
			}
		}
		public static function checkIfGameExist():Boolean{
			return so.data.hasOwnProperty("game5")
		}
	}

}
