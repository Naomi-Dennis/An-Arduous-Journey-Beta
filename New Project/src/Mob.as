
package
{
	import Assets.Utility.ConvertToByteArray;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.GenStat;
	import Assets.Utility.GetAliasInformation;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveFromArray;
	import Assets.Utility.SpriteToBitmapData;
	import flash.display.Sprite;
	import Assets.Inventory;
	import Assets.Item;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import items.Antidote;
	import items.armor.*;
	import items.weapon.*;
	
	/**
	 * @author Naomi J. Dennis
	 */
	public class Mob
	{
		public var name:String = "none";
		protected var icon:MobIcon;
		protected var maxHp:int = 0;
		protected var hp:int = 0;
		private var str:int = 0;
		protected var cons:int = 0;
		protected var wis:int = 0;
		protected var intel:int = 0;
		protected var def:int = 0;
		protected var weapon:Assets.Item = null;
		protected var armor:Assets.Item = null;
		protected var shield:Item = null;
		protected var leggings:Item = null;
		protected var shoes:Item = null;
		public var inventory:Inventory;
		protected var aSkills:Array = new Array();
		protected var gold:int = 9999999999999999;
		protected var status:Object = {"strength": 2, "constitution": 0, "wisdom": 0, "dexterity": 0, "defense": 0};
		protected var affliction:Object = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0};
		protected var afflictionDmg:Object = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0}
		protected var resistances:Object = {"earth": 0, "fire": 0, "air": 0, "water": 0, "poison": 0, "electrical": 0, "bleeding":0};
		protected var ap:int = 6;
		protected var maxAp:int = 6;
		protected var mp:int = 3;
		protected var maxMp:int = 3;
		protected var skillSlots:int = 5;
		protected var aQuickSlots:Array = [null, null, null, null, null, null, null];
		protected var battlePiece:BattlePiece;
		protected var criticalHit:Number = .5;
		protected var autoCrit:Boolean = false;
		protected var parry:Boolean = false;
		protected var increasedMovement:int = 0;
		protected var tempStats:Object = {}
		protected var useTempStats:Boolean = false;
		protected var ORIG_STATS:Object = status;
		protected var effects:Array = [];
		public var mobType:String = "player";
		protected var description:String = "";
		protected var initialState:Object = {};
		protected var armorPierce:Boolean = false;
		protected var exp:int = 0;
		protected var maxExp:int = 50;
		protected var nLevel:int = 1;
		protected var strClass:String = "None";
		protected var death:Boolean = false;
		public var hasMoved:Boolean = false; 
		public var movementBegun:Boolean = false;
		public var myTurn:Boolean = false; 
		private var lockMovement:Boolean = false; 
		private var expEarnedHolder:int = 0; 
		public function Mob()
		{
			inventory = new Inventory(33, this);
			hp = 50;
			maxHp = hp;
			ap = maxAp;
			mp = maxMp;
			icon = new MobIcon(this);
			setBattlePiece();
			exp = 0;
			maxExp = getMaxExp();
		}
		
		public function setWarrior():void
		{

			strClass = "WARRIOR";
		}
		
		public function setArcher():void
		{
			strClass = "ARCHER";
		}
		
		public function setMage():void
		{
			strClass = "MAGE";
		}
		
		private function getMaxExp():int
		{
			return (( (nLevel * nLevel) + (nLevel + 5) ) * 40);
		}
		
		public function gainExperience(n:int):Boolean
		{
			expEarnedHolder += n;
		    if (expEarnedHolder > maxExp){
				expEarnedHolder = expEarnedHolder - maxExp; 
				return true; 
				/* call the level up function from the level up screen */
			}
			else if (expEarnedHolder == maxExp){
				expEarnedHolder = 0;
				return true;
				/* call the level up function from the level up screen */
			}
			return false;
		}
		
		public function getLevel():int
		{
			return nLevel;
		}
		public function storeExpPoints():void{
			exp = expEarnedHolder;
		}
		public function clearExpPointsHolder():void{
			expEarnedHolder = 0; 
		}
		public function getExperiencePercentage():Number
		{
			return (exp / maxExp);
		}
		public function getPotentialExperience():Number{
			return expEarnedHolder / maxExp; 
		}
		public function setPotentialExperience():void{
			expEarnedHolder = exp; 
		}
		
		public function getExp():Number{
			return expEarnedHolder;
		}
		public function getMaxExpNum():Number{
			return maxExp; 
		}
		public function levelUp():*
		{
			
			var currentStat:int = 0;
			maxHp += 25; 
			hp = maxHp; 
			for (var i:* in status){
				status[i] += nLevel; 
			}
			maxExp = getMaxExp();
			expEarnedHolder = 0;
			var screen:*;
			if (strClass == "WARRIOR")
			{
				if (nLevel == 1)
				{
					screen = LevelUpScreens.warrior_level_1(this);
				}
				else if (nLevel == 2)
				{
					screen = LevelUpScreens.warrior_level_2(this);
				}
				else if (nLevel == 3)
				{
					screen = LevelUpScreens.warrior_level_3(this);
				}
				else if (nLevel == 4)
				{
					screen = LevelUpScreens.warrior_level_4(this);
				}
				else if (nLevel == 5)
				{
					screen = LevelUpScreens.warrior_level_5(this);
				}
				else{
					screen = LevelUpScreens.get_stat(this);
				}
			}
			else if (strClass == "ARCHER")
			{
				if (nLevel == 1)
				{
					screen = LevelUpScreens.archer_level_1(this)
				}
				else if (nLevel == 2)
				{
					screen = LevelUpScreens.archer_level_2(this)
				}
				else if (nLevel == 3)
				{
					screen = LevelUpScreens.archer_level_3(this)
				}
				else if (nLevel == 4)
				{
					screen = LevelUpScreens.archer_level_4(this)
				}
				else if (nLevel == 5)
				{
					screen = LevelUpScreens.archer_level_5(this)
				}
				else{
					screen = LevelUpScreens.get_stat(this);
				}
			}
			else if (strClass == "MAGE")
			{
				if (nLevel == 1)
				{
					screen = LevelUpScreens.mage_level_1(this);
				}
				else if (nLevel == 2)
				{
					screen = LevelUpScreens.mage_level_2(this);
				}
				else if (nLevel == 3)
				{
					screen = LevelUpScreens.mage_level_3(this);
				}
				else if (nLevel == 4)
				{
					screen = LevelUpScreens.mage_level_4(this);
				}
				else if (nLevel == 5)
				{
					screen = LevelUpScreens.mage_level_5(this);
				}
				else if (nLevel == 6)
				{
					screen = LevelUpScreens.mage_level_6(this);
				}
				else{
					screen = LevelUpScreens.get_stat(this);
				}
			}
			nLevel++;
			setOriginalStats();
			setInitialState();
			return screen;
		}
		
		public function setName(newName:String):void
		{
			name = newName;
		}
		public function resetStatus():void{
			myTurn = false; 
			status = initialState.status;
			maxHp = initialState.maxHp;
			hp = maxHp;
			maxAp = initialState.maxAp;
			ap = maxAp;
			maxMp = initialState.maxMp;
			mp = maxMp; 
			nLevel = initialState.level;
			exp = initialState.exp;
			maxExp = initialState.maxExp; 
			expEarnedHolder = initialState.expEarnedHolder
			affliction = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0, "ap":0, "move":0};
			afflictionDmg = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0, "ap":0, "move":true}
			resetSkillCooldowns();
			if (useTempStats)
			{
				useTempStats = false;
				effects = [];
			}
			battlePiece.removeEffectsPerm();
			battlePiece.resetBattlePiece();
			battlePiece.putIconBack();
			this.getBattlePiece().alpha = 1;
		}
		public function resetMob(noItems:Boolean=false):void
		{
			resetStatus();
		}
		
		public function setInitialState():void
		{
			status = ORIG_STATS;
			resetSkillCooldowns();
			initialState = {};
			initialState.quickslots = copyArray(aQuickSlots); /* returns an array of objects containing string attributes*/
			initialState.inventory = copyArray(inventory.getItems()); /* returns an array of objects containing string attributes */
			initialState.status = DeepCopy(status, Object, "Object"); /* returns a byte array of an object */
			initialState.maxHp = maxHp; /* auto deep copy */
			initialState.maxAp = maxAp; /* auto deep copy */ 
			initialState.maxMp = maxMp; /* auto deep copy */
			initialState.exp = exp; /* auto deep copy */
			initialState.expEarnedHolder = expEarnedHolder; /* auto deep copy */
			initialState.maxExp = maxExp; /* auto deep copy */
			initialState.weapon = saveIfNotNull(weapon); /* returns an object containing string attributes */
			initialState.armor = saveIfNotNull(armor);  /* returns an object containing string attributes */
			initialState.level = nLevel;
			initialState.shield = saveIfNotNull(shield);  /* returns an object containing string attributes */
			initialState.leggings = saveIfNotNull(leggings);  /* returns an object containing string attributes */
			initialState.mobIconInUse = icon.isInUse();
			if (icon.isInUse()){
				initialState.mobIcon = icon.saveData(); /* returns an object containing string attributes */
			}
			else{
				initialState.mobIcon = "null"; 
			}
			
		}
		public function checkQuickslotFull():Boolean{
			for (var i:* in aQuickSlots){
				if (aQuickSlots[i] == null){
					return false; 
				}
			}
			return true;
		}
		private function resetSkillCooldowns():void{
			var currentSlot:*; 
			for (var i:* in aQuickSlots)
			{
				currentSlot = aQuickSlots[i];
				if (currentSlot!= null && currentSlot.getType().toLowerCase() == "skill")
				{
					currentSlot.resetCooldown();
				}
			}
		}
		public function saveIfNotNull(obj:*):*
		{
			var retObj:Object = {};
			if (obj != null)
			{
				var aliasName:Object = GetAliasInformation(obj);
				retObj.type = aliasName.path;
				var cmpType:String = retObj.type.toLowerCase();
				if (cmpType == "item" || cmpType == "weapon" || cmpType == "Armor")
				{
					retObj.enhancements = obj.getEnhancements();
				}
			}
			else
			{
				retObj = "null";
			}
			return retObj;
		}
		
		public function loadIfNotNull(obj:*):*
		{
			if (obj != "null" && obj != "undefined" && obj != undefined)
			{
				var className:* = getDefinitionByName(obj.type);
				var newItem:* = new className();
				var newItemEffects:Object = obj.enhancements;
				newItem.setOwner(this);
				for (var i:* in newItemEffects)
				{
					//newItem.setEnhancements(i, newItemEffects[i]); 
				}
				return newItem;
			}
			else
			{
				return null;
			}
		}
		
		public function saveMob():Object
		{
			battlePiece.resetBattlePiece();
			resetSkillCooldowns();
			var saveStats:Object = { }
			saveStats = {};
			saveStats.quickslots = copyArray(aQuickSlots); /* returns an array of objects containing string attributes*/
			saveStats.inventory = copyArray(inventory.getItems()); /* returns an array of objects containing string attributes */
			saveStats.generalStats = DeepCopy(status, Object, "Object"); /* returns a byte array of an object */
			saveStats.name = name; 
			saveStats.level = nLevel;
			saveStats.maxHp = maxHp; /* auto deep copy */
			saveStats.maxAp = maxAp; /* auto deep copy */ 
			saveStats.maxMp = maxMp; /* auto deep copy */
			saveStats.exp = exp; /* auto deep copy */
			
			saveStats.expEarnedHolder = expEarnedHolder; /* auto deep copy */
			saveStats.maxExp = maxExp; /* auto deep copy */
			saveStats.weapon = saveIfNotNull(weapon); /* returns an object containing string attributes */
			saveStats.armor = saveIfNotNull(armor);  /* returns an object containing string attributes */
			saveStats.shield = saveIfNotNull(shield);  /* returns an object containing string attributes */
			saveStats.leggings = saveIfNotNull(leggings);  /* returns an object containing string attributes */
			saveStats.mobIconInUse = icon.isInUse(); 
			saveStats.fightClass = strClass; 
			if (icon.isInUse()){
				saveStats.mobIcon = icon.saveData(); /* returns an object containing string attributes */
			}
			else{
				saveStats.mobIcon = "null"; 
			}
			
			return saveStats;
		}
		
		public function loadMob(loadStats:Object, changeBattlePieceSpecs:Boolean=true):void
		{
			
			status = loadStats.generalStats;
			setOriginalStats();
			strClass = loadStats.fightClass; 
			name = loadStats.name;
			maxHp = loadStats.maxHp;
			maxAp = loadStats.maxAp;
			maxMp = loadStats.maxMp;
			hp = maxHp;
			mp = maxMp;
			ap = maxAp;
			exp = loadStats.exp;
			expEarnedHolder = loadStats.expEarnedHolder;
			maxExp = loadStats.maxExp;
			nLevel = loadStats.level; 
			weapon = loadIfNotNull(loadStats.weapon);
			armor = loadIfNotNull(loadStats.armor);
			leggings = loadIfNotNull(loadStats.leggings);
			shield = loadIfNotNull(loadStats.shield);
			if (loadStats.mobIconInUse){
				icon.loadData(loadStats.mobIcon); 
			}
			var i:String = "0"; 
			for (i in loadStats.inventory)
			{
				inventory.addItem(loadIfNotNull(loadStats.inventory[int(i)]));
			}
			i = "0"; 
			for (i in loadStats.quickslots)
			{
				
				var item:* = loadIfNotNull(loadStats.quickslots[int(i)])
				if (item != null)
				{
					aQuickSlots[i] = item;
				}
			}
			affliction = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0, "ap":0, "move":0};
			afflictionDmg = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0, "bleeding":0, "ap":0, "move":true}
			if(changeBattlePieceSpecs){
				setBattlePiece(); 
			}
		}
		
		protected function copyArray(array:Array):Array
		{
			var currentElement:*;
			var getPath:Object = {};
			var newArray:Array = [];
			for (var i:* in array)
			{
				currentElement = array[i];
				newArray.push(saveIfNotNull(currentElement));
			}
			return newArray;
		}
		
		public function setQuickslot(array:Array):void
		{
			var obj:Object = { };
			for (var i:* in array)
			{
				if(array[i] != null){
					obj = saveIfNotNull(array[i]);
					aQuickSlots[i] = loadIfNotNull(obj);
					aQuickSlots[i].setOwner(this);
				}
			}
		}
		
		public function raiseParticularStatByN(stat:String, n:int):void
		{
			status[stat] += n;
			if (stat == "constitution")
			{
				hpGen();
			}
		}
		
		public function setStatByN(stat:String, n:int):void
		{
			status[stat] = n;
			if (stat == "constitution")
			{
				hpGen();
			}
		}
		
		public function generateStats(multi:int, face:int = 4):void
		{
			for (var i:* in status)
			{
				status[i] = GenStat(2, multi, face);
			}
			hpGen();
		}
		
		public function raiseParticularStat(stat:String, multi:int, face:int = 4):void
		{
			status[stat] += GenStat(2, multi, face);
			if (stat == "consitution")
			{
				hpGen();
			}
		}
		
		private function hpGen():void
		{
			var constModifier:int = Math.log(nLevel * nLevel) + Math.log(status["constitution"] * 2) + 3
			maxHp += constModifier;
			hp = maxHp;
		}
		
		public function getBattlePiece():BattlePiece
		{
			return battlePiece;
		}
		
		public function setBattlePiece(piece:Sprite = null):void
		{
			battlePiece = new BattlePiece(icon, this);
			icon.setInUse(true);
		}
		
		public function setCustomBattlePiece(piece:*):void
		{
			battlePiece = new BattlePiece(piece, this);
			icon.setInUse(false);
		}
		
		public function getQuickSlots():Array
		{
			return aQuickSlots;
		}
		
		public function addToQuickSlot(ref:*):void
		{
			var refName:String = ref.getName().toLowerCase();
			var names:Array = refName.split(" ");
			if (names[1] == "strike")
			{
				filterMultipleAttacks("strike");
			}
			else if (names[1] == "shot")
			{
				filterMultipleAttacks("shot");
			}
			
			for (var i:* in aQuickSlots){
				if (aQuickSlots[i] == null){
					aQuickSlots[i] = ref; 
					break;
				}
			}
		}
		
		private function filterMultipleAttacks(refType:String):void
		{
			var currentNames:Array = [];
			for (var i:* in aQuickSlots)
			{
				if (aQuickSlots[i] != null)
				{
					currentNames = aQuickSlots[i].getName().toLowerCase().split(" ");
					if (currentNames[1] == refType)
					{
						aQuickSlots[i] = null;
						break; 
					}
				}
			}
		}
		
		public function resetAp():void
		{
			ap = maxAp;
		}
		
		public function resetMp():void
		{
			mp = maxMp;
		}
		
		public function removeFromQuickSLot(ref:*):void
		{
			var index:int = -1;
			for (var i:* in aQuickSlots)
			{
				if(aQuickSlots[i] != null){
					if (aQuickSlots[i] == ref)
					{
						index = i;
						break;
					}
				}
			}
	
			(index != -1) ? aQuickSlots[i] = null : null;
		}
		
		public function getAp():int
		{
			return ap;
		}
		
		public function getMaxAp():int
		{
			return maxAp;
		}
		
		public function changeAp(n:int):void
		{
			ap += n;
			(ap < 0) ? ap = 0 : null;
		}
		
		public function changeMp(n:int):void
		{
			mp += n;
			(mp < 0) ? mp = 0 : null;
		}
		
		public function getMp():int
		{
			return mp;
		}
		
		public function getMaxMp():int
		{
			return maxMp;
		}
		
		public function getSkillSlots():int
		{
			return skillSlots;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function getSkills():Array
		{
			return aSkills;
		}
		
		public function setStatus(_status:Object):void
		{
			status = _status;
			hpGen();
			
		}
		public function setOriginalStats():void{
			for (var i:* in status){
				ORIG_STATS[i] = { } ;
				ORIG_STATS[i] = status[i]; 
			}
		}
		public function setMp(newMp:int):void{
			mp = newMp; 
			if (mp < 0){
				mp = 0;
			}
			else if (mp > maxMp){
				mp = maxMp; 
			}
		}
		public function getStatus():Object
		{
			return status;
		}
		public function getClass():String{
			return strClass;
		}
		
		public function changeAttr(attr:String, n:int):void
		{
			status[attr] += n;
			(status[attr] < 0) ? status[attr] = 0 : null;
		}
		
		public function setMaxHp(n:int):void
		{
			maxHp = n;
			hp = maxHp;
		}
		
		public function removeParry():void
		{
			parry = false;
		}
		
		public function changeHp(n:int, dmgType:String = "true", ignoreAttack:Boolean=false):void
		{
			
			if (parry)
			{
				//quote parried!
				
				//	battlePiece.showAttackCry("~Parried~")
				//parry = false;
			}
			else
			{
				dmgType = dmgType.toLowerCase();
				if (dmgType == "magic"){
					n = (defendAgainstMagicalAttack(n) * -1)
				}
				else if (dmgType == "physical"){
					n = (defendAgainstPhysicalAttack(n) * -1)
				}
			
				hp += n;
				(hp > maxHp) ? hp = maxHp : null;
			}
			
			if (hp <= 0)
			{
				hp = 0;
				die();
			}
		}
		
		public function clearStats():void
		{
			status = {"strength": 2, "constitution": 0, "wisdom": 0, "dexterity": 0, "defense": 0};
		}
		
		public function activateArmorPierce():void
		{
			armorPierce = true;
		}
		
		public function deactivateArmorPierce():void
		{
			armorPierce = false;
		}
		
		public function nextAttackIsArmorPierce():Boolean
		{
			return armorPierce;
		}
		
		public function defendAgainstPhysicalAttack(dmg:int, ignoreDefense:Boolean=false):int
		{
			if (!ignoreDefense)
			{
				if(dmg < 0){
					dmg = dmg * -1; 
				}
				var defenseModifier:int = status.defense / 2;
				var defensePower:Number = (defenseModifier + status.defense) / 100;
				var reduction:int = dmg * defensePower + 1
				dmg -= reduction;
				(dmg < 0) ? dmg = 0 : null;
			}
			return dmg;
		}
		public function defendAgainstMagicalAttack(dmg:int, ignoreDefense:Boolean=false):int{
			/* Magic Reist */ 
			if (!ignoreDefense){
				dmg = dmg * -1; 
				var magicModifier:int = status.wisdom / 2;
				var magicPower:Number = (magicModifier + status.wisdom) / 100;
				var reduction:int = dmg * magicPower + 1
				dmg -= reduction;
				(dmg < 0) ? dmg = 0 : null;
			}
			return dmg;
		}
		
		public function die():void
		{
			if (!death)
			{
				death = true;
				for (var i:* in affliction){
					affliction[i] = 0;
				}
				//this.battlePiece.addEventListener(Event.ENTER_FRAME, fadeOutBattlePiece);
			}
		}
		
		public function removeFromQuickSlotByName(objName:String):void
		{
			for (var i:* in aQuickSlots)
			{
				if (aQuickSlots[i].getName().toLowerCase() == objName.toLowerCase())
				{
					removeFromQuickSLot(aQuickSlots[i]);
				}
			}
		}
		
		private function fadeOutBattlePiece(e:Event):void
		{
			if (hp <= 0)
			{
				battlePiece.alpha -= 0.1;
				if (battlePiece.alpha <= 0)
				{
					e.currentTarget.removeEventListener(Event.ENTER_FRAME, fadeOutBattlePiece);
					battlePiece.getCellLocation().addBloodStain();
					battlePiece.getCellLocation().clearPiece();
					battlePiece.resetBattlePiece();
					
				}
			}
		}
		
		public function getMaxHp():int
		{
			return maxHp;
		}
		
		public function getHp():Number
		{
			return hp;
		}
		
		public function getWeapon():Assets.Item
		{
			return weapon;
		}
		
		public function getLeggings():Item
		{
			return leggings;
		}
		
		public function getArmor():Assets.Item
		{
			return armor;
		}
		
		public function getShield():Item
		{
			return shield;
		}
		
		public function equip(item:*):void
		{
			var itemType:String = item.getType().toLowerCase();
			var enhancements:Object = item.getEnhancements();
			var i:*;
			if (itemType == "weapon")
			{
				if (weapon == null)
				{
					//give weapon 
					weapon = item;
					status.strength += weapon.getPower();
					icon.equip(item);
					inventory.removeItem(item);
					//add enhancements
					for (i in enhancements)
					{
						status[i] += enhancements[i];
					}
				}
				else
				{
					(unEquip(item)) ? equip(item) : null; //if it can be unequipped, equip the current item
				}
			}
			else if (itemType == "armor")
			{
				if (armor == null)
				{
					//give armor
					armor = item;
					status.defense += armor.getPower();
					icon.equip(item);
					inventory.removeItem(item);
					//remove enhancements
					for (i in enhancements)
					{
						status[i] += enhancements[i];
					}
				}
				else
				{
					(unEquip(item)) ? equip(item) : null; //if it can be unequipped, equip the current item
				}
			}
			else if (itemType == "shield")
			{
				if (shield == null)
				{
					//give armor
					shield = item;
					status.defense += shield.getPower();
					icon.equip(item);
					inventory.removeItem(item);
					//remove enhancements
					for (i in enhancements)
					{
						status[i] += enhancements[i];
					}
				}
				else
				{
					(unEquip(item)) ? equip(item) : null; //if it can be unequipped, equip the current item
				}
			}
			else if (itemType == "leggings")
			{
				if (leggings == null)
				{
					//give armor
					leggings = item;
					status.defense += leggings.getPower();
					icon.equip(item);
					//remove enhancements
					for (i in enhancements)
					{
						status[i] += enhancements[i];
					}
				}
				else
				{
					(unEquip(item)) ? equip(item) : null; //if it can be unequipped, equip the current item
				}
			}
			else
			{
				item.equipMe(this);
			}
		
		}
		public function getMobIcon():MobIcon{
			return icon;
		}
		public function unEquip(item:Assets.Item):Boolean
		{
			var itemType:String = item.getType();
			var enhancements:Object = item.getEnhancements();
			var i:*;
			if (itemType == "weapon")
			{
				//add to the inventory the current item
				//if *** can happen, remove the weapon
				if (!inventory.isFull())
				{
					//removeo weapon
					weapon = null;
					status.strength -= item.getPower();
					inventory.addItem(item);
					//remove enhancements
					for (i in enhancements)
					{
						status[i] -= enhancements[i];
					}
					return true;
				}
				else
				{
					return false;
				}
			}
			else if (itemType == "armor")
			{
				//add to the inventory the current item
				//if *** can happen, remove the armor
				if (!inventory.isFull())
				{
					//remove armor
					armor = null;
					status.defense -= item.getPower();
					inventory.addItem(item);
					//remove enhancements
					for (i in enhancements)
					{
						status[i] -= enhancements[i];
					}
					return true;
				}
				else
				{
					return false;
				}
			}
			else if (itemType == "shield")
			{
				//add to the inventory the current item
				//if *** can happen, remove the shield
				if (!inventory.isFull())
				{
					//remove shield
					shield = null;
					status.defense -= item.getPower();
					inventory.addItem(item);
					
					//remove enhancements
					for (i in enhancements)
					{
						status[i] -= enhancements[i];
					}
					return true;
				}
				else
				{
					return false;
				}
			}
			else if (itemType == "leggings")
			{
				//add to the inventory the current item
				//if *** can happen, remove the shield
				if (!inventory.isFull())
				{
					//remove shield
					leggings = null;
					status.defense -= item.getPower();
					inventory.addItem(item);
					
					//remove enhancements
					for (i in enhancements)
					{
						status[i] -= enhancements[i];
					}
					return true;
				}
				else
				{
					return false;
				}
			}
			return false;
		}
		
		public function getInventory():Inventory
		{
			return inventory;
		}
		
		public function getIcon():*
		{
			if (icon.isInUse())
			{
				return icon;
			}
			else
			{
				return battlePiece.getIcon();
			}
		
		}
		
		public function getGold():Number
		{
			return gold;
		}
		
		public function changeGold(n:Number):void
		{
			gold += n;
			(gold < 0) ? gold = 0 : null;
		}
		
		public function addSkill(skill:Skill):void
		{
			aSkills.push(skill);
			//return the skill
		}
		
		public function getItems():Array
		{
			//return the inventory items 
			return [];
		}
		
		public function setIcon(ico:Sprite):void
		{
			//icon = ico;
		}
		
		public function setGold(n:int):void
		{
			gold = n;
		}
		
		public function isNextAttackCritical():Boolean
		{
			if (autoCrit)
			{
				return true;
			}
			else if (critFoo())
			{
				return true;
			}
			return false;
		}
		
		private function critFoo():Boolean
		{
			var rand:int = RandomNumber(1000, 0);
			var critChange:Number = criticalHit * 10;
			return rand <= criticalHit;
		}
		
		public function isIncreasedMovement():int
		{
			return increasedMovement;
		}
		
		public function activateParry():void
		{
			parry = true;
		}
		
		public function isParrying():Boolean
		{
			return parry;
		}
		
		public function activateAutoCrit():void
		{
			autoCrit = true;
		}
		
		public function deactivateAutoCrit():void
		{
			autoCrit = false;
		}
		
		public function increaseMovementBy(n:int, nTurns:int=0):void
		{
			maxMp += n; 
			mp += n; 
		}
		
		public function deactivateIncreaseMovement():void
		{
			maxMp = 3
			mp = maxMp;
		}
		
		public function tempStatusChange(attr:String, nChange:int, nTurns:int):void
		{
			var newEffect:Object = {stat: attr, change: nChange, turns: nTurns};
			effects.push(newEffect);
			if (!useTempStats)
			{
				status[attr.toLowerCase()] = nChange + ORIG_STATS[attr];
			}
			useTempStats = true;
		}
		
		public function resetAfflictions():void
		{
		
		}
		public function setAffliction(afflic_name:String, turns:int, damage:int):void{
			affliction[afflic_name] = turns;
			afflictionDmg[afflic_name] = damage;
		}
		public function getAfflictions():Object
		{
			return affliction;
		}
		
		public function getAfflictionDmg():Object
		{
			return afflictionDmg;
		}
		
		public function processCooldowns():void
		{
			for (var i:* in aQuickSlots)
			{
				if (aQuickSlots[i] != null && aQuickSlots[i].getType().toLowerCase() == "skill")
				{
					Skill(aQuickSlots[i]).deductCooldown();
				}
			}
		
		}
		
		public function processAfflictions(dmg:int = 0, turns:int = 0, element:String = "none"):void
		{
			/*
			   "burning":0,
			   "frozen":0,
			   "stunned":0,
			   "poisoned":0
			 * */
			deactivateIncreaseMovement();
			battlePiece.removeEffectsPerm();
			element = element.toLowerCase();
			if (element != "none")
			{
				afflictionDmg[element] = dmg;
				affliction[element] = turns;
			}
			
			if (affliction.burning > 0)
			{
				battlePiece.addEffect("burning");
				takeElementalDamage(afflictionDmg.burning, "fire");
				affliction.burning--;
				battlePiece.addEffect("burning");
			}
			if (affliction.poisoned > 0)
			{
				battlePiece.addEffect("poisoned");
				takeElementalDamage(afflictionDmg.poisoned, "poison");
				affliction.poisoned--;
			}
			else{
				battlePiece.removeEffectName("poisoned"); 
			}
			if (affliction.stunned > 0)
			{
				battlePiece.addEffect("stunned");
				affliction.stunned--;
				battlePiece.addEffect("stunned");
			}
			if (affliction.frozen > 0)
			{
				battlePiece.addEffect("frozen");
				affliction.frozen--;
				battlePiece.addEffect("frozen");
			}
			if (affliction.bleeding > 0){
				battlePiece.addEffect("bleeding");
				affliction.bleeding--;
				battlePiece.addEffect("bleeding");
				if (strClass.toLowerCase() == "warrior"){
					changeHp( (status["strength"] * 0.25) * -1 );
				}
				else if(strClass.toLowerCase() == "archer"){
					changeHp( (status["dexterity"] * 0.25) * -1 );
				}
			}
			if (affliction.ap <= 0){
				afflictionDmg.ap = 0;
				maxAp = 6;
				ap = maxAp; 
			}
			else{
				affliction.ap--;
			}
			if (element == "ap up"){
				affliction["ap"] = turns;
				afflictionDmg["ap"] = dmg; 
				maxAp += dmg; 
			}
			else if (element == "ap down"){
				affliction["ap"] = turns;
				afflictionDmg["ap"] = -dmg; 
				maxAp += dmg; 
			}
			if (element == "move"){
				affliction["move"] = turns; 
				afflictionDmg["move"] = false; 
			}
			if (affliction.move > 0){
				battlePiece.addEffect("fear");
				mp = 0;
				affliction.move--; 
				afflictionDmg.move = false; 
			}
			else{
				afflictionDmg.move = true; 
				resetMp();
			}
			var currentEffect:Array = []
			var statName:String = "";
			if (mobType.toLowerCase() == "player" ){ status = ORIG_STATS; }
			for (var i:* in affliction)
			{
				currentEffect = String(i).toLowerCase().split(" ");
				if (currentEffect.length == 2){
					statName = currentEffect[1]; 
					if (statName == "strength" || statName == "dexterity" || statName == "wisdom" || statName == "defense" || statName == "constitution"){
						if (affliction[i] > 0){
							affliction[i]--; 
							var dmg:int = afflictionDmg[i]; 
							status[statName] += dmg; 
							if(afflictionDmg[i] > 0){
								battlePiece.addEffect( statName + " up"); 
							}
							else{
								battlePiece.addEffect( statName + " down"); 
							}
						}
						else{
							delete affliction[i]; 
						}
					}
				}
			}
					//**//
			//**//
			battlePiece.showEffects();
			//The below is just a percaution // 
		}
		
		public function skipTurn():Boolean
		{
			return hp <= 0 || affliction.stunned > 0 || affliction.frozen > 0
		}
		
		private function takeElementalDamage(n:int, element:String):void
		{
			/*
			   "earth":0,
			   "fire":0,
			   "air":0,
			   "water":0,
			   "poison":0,
			   "electrical":0
			 */
			var dmg:int = n;
			if (dmg < 0){
				dmg *= -1; 
			}
			var resistance:Number = resistances[element] / 100 * dmg;
			dmg -= Math.floor(resistance);
			if (dmg < 0){
				dmg *= -1; 
			}
			changeHp(dmg * -1);
			battlePiece.showDamage(dmg);
		}
		
		public function setDescription(str:String):void
		{
			description = str;
		}
		
		public function getDescription():String
		{
			return description;
		}
	}

}