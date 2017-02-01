package
{
	import Assets.Inventory;
	import Assets.Item;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.GetAliasInformation;
	import flash.utils.getDefinitionByName;
	import items.armor.BrownPants;
	import items.armor.IronLeggings;
	import items.armor.OrchishRingmail;
	import items.armor.PlateMail;
	import items.HealthPotion;
	import items.armor.RoyalShield;
	import items.armor.TowerShield;
	import items.weapon.OrchishGreatSword;
	import mobs.PlayersLibrary;
	import items.armor.*;
	import items.weapon.*;
	import items.*;
	
	/**
	 * ...
	 * @author lk
	 */
	public class PlayerStruct
	{
		private var CLASS_REFS_ITEMS:Array = [ Antidote, ConstitutionBook, DefenseBook, DexterityPotion, HealthPotion, MysteriousKey, PrizeBox, StrengthBook, StrengthPotion, Torch, WisdomBook, WisdomPotion];
		private var CLASS_REFS_ARMOR:Array = [ Staff, BearSkin, BlueCape, BluePants, BlueRobe, BrownPants, BrownRobe, BrownShoes, Chainmail, ElvenScalemail, FeatherHatBlue, FeatherHatGreen, FeatherHatRed, FighterGloves, GoldenBuckler, GreenRobe, HatStraw, HatWizardBlackGold, HatWizardBlackRed, HatWizardBlueGreen, HoodCyan, HoodGray, HoodGreen, HoodOrange, IronLeggings, LeatherArmor, LeopardSkin, OrchishRingmail, PlateMail, PurpleRobe, RedRobe, RoyalChainmail, RoyalShield, Scarf, ShirtBlack, ShirtHawaii, ShirtYellowWhite, SteelLeggings, StuddedLeatherArmor, StuddedMetalBuckler, StuddedPlateMail, TowerShield, Vest, WoodenBuckler];
		private var CLASS_REFS_WEAPONS:Array = [ BattleAxe, BlessedBlade, Blowgun, BookBlack, BookBlue, BookRed, BookWhite, Bow, Club, Crossbow, Dagger, DwarvenBattleAxe, Katana, Morningstar, OrchishGreatSword, OrchishLongsword, OrchishShortSword, RougansBattleAxe, Sling, StaffAnucis, StaffArcadi, StaffRenly, StaffScepter, StuddedMorningstar, SwiftKatana ]; 		
		public var inventory:Inventory = new Inventory(10);
		public var gold:int = 0;
		public var currentRoom:String = "settingIntro";
		public var currentLevel:int = 1;
		public var saveObj:Object = {};
		public var missionStatuses:Object = { };
		public var tutOn:Boolean = true; 
		public function PlayerStruct()
		{
			
			inventory.addItem(new HealthPotion());
		}
		
		public function changeGold(n:int):void
		{
			gold += n;
			(gold < 0) ? gold = 0 : gold = gold;
		}
		
		public function getGold():int
		{
			return gold;
		}
		
		public function setSaveObject():Object
		{
			saveObj = new Object(); 
			saveObj.inventory = copyArray(inventory.getItems());
			saveObj.gold = gold;
			var aSoldiers:Array = Main.army.getArmy();
			var aCurrentSoldiers:Array = Main.army.getCurrent();
			var savedSoldiers:Array = [];
			var savedMob:Object = { }; 
			var savedCurrentArmy:Array = []; 
			for (var i:* in aSoldiers)
			{
				savedMob = Mob(aSoldiers[i]).saveMob(); 
				savedSoldiers.push( savedMob ); 
				for (var j:* in aCurrentSoldiers){
					if (savedMob.name == aCurrentSoldiers[j].name){
						savedCurrentArmy.push( savedMob.name ); 
					}
				
				}
			}
			saveObj.soldierData = (savedSoldiers);
			saveObj.currentArmyData = (savedCurrentArmy); 
			saveObj.missionStatuses = missionStatuses;
			return saveObj; 
		}
		
		public function loadSaveObject(obj:Object):void
		{
			var army:Array = [];
			var currentArmy:Array = []; 
			var currentMob:Mob = new Mob();
			var mobData:Object = { }; 
			var soldierData:Object = obj.soldierData;
			var loadedCurrent:Object = obj.currentArmyData;
			for (var i:* in soldierData)
			{
				currentMob = new Mob();
				mobData = soldierData[i];
				currentMob.loadMob( mobData ) 
				army.push( currentMob ); 
				for (var j:* in loadedCurrent){
					if (mobData.name == loadedCurrent[j]){
						currentArmy.push( currentMob ); 
						break;
					}
				}
			}
			Main.army.setArmy(army);
			Main.army.setCurrent( currentArmy ); 
			Main.army.loaded = true; 
			gold = 1000
			missionStatuses = obj.missionStatuses;
		}
		
		public function incrementLevel():void
		{
			currentLevel++;
		}
		
		public function give_gold(n:int):void
		{
			gold += n;
		}
		
		public function take_gold(n:int):void
		{
			gold -= n;
		}
	
		public function take_item(item:String):void
		{
			item = inventory.getItemByName(item);
			inventory.removeItem(item);
		}
		
		public function give_item(item:String):void
		{
			var itemType:String = item.split("_")[0].toLowerCase();
			var item:String = item.split("_")[1];
			var itemClass:Class;
			var defName:String = "";
			if (itemType.toLowerCase() != "item")
			{
				defName = "items." + itemType + "." + item;
			}
			else
			{
				defName = "items." + item;
			}
			itemClass = getDefinitionByName(defName) as Class; 
			var itemObj:Item = new itemClass();
			
			inventory.addItem(itemObj);
		}
		public function add_army(name:String):void{
			Main.army.add(PlayersLibrary["create " + name]()); 
		}
		public function give_exp(n:String):void{
			var army:Array = Main.army.getCurrent();
			var expGained:int = parseInt(n) / army.length; 
		}
		public function copyArray(array:Array):Array
		{
			var currentElement:*;
			var getPath:Object = {};
			var newArray:Array = [];
			for (var i:* in array)
			{
				currentElement = array[i];
				if (currentElement != null)
				{
					getPath = GetAliasInformation(currentElement);
					newArray.push(DeepCopy(currentElement, getPath.className, getPath.path));
				}
			}
			return newArray;
		}
	}

}