package mobs.Players 
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.Antidote;
	import items.armor.BluePants;
	import items.armor.BrownPants;
	import items.armor.BrownShoes;
	import items.armor.LeatherArmor;
	import items.HealthPotion;
	import items.weapon.Club;
	import items.weapon.Katana;
	import items.weapon.SwiftKatana;
	import skills.DefensiveStance;
	import skills.DoubleShot;
	import skills.DoubleStrike;
	import skills.Rage;
	import skills.SingleShot;
	import skills.SingleStrike;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Beserker_Tristan extends Mob
	{
		[Embed(source="Beserker.png")]
		private var img:Class;
		[Embed(source = "../CampaignEnemies/images/playerInTraining.png")]
		private var trainingImg:Class;
		[Embed(source = "../CampaignEnemies/images/RoyalSwordsmanPlayer.png")]
		private var primaryImg:Class; 
		[Embed(source = "../../long hair and beard.png")]
		private var hair:Class;
		private var lvl:int = 0;
		public var promotedStats:Object = {"strength": 0, "constitution": 0, "wisdom": 0, "dexterity": 0, "defense": 0};
		public function Beserker_Tristan(_name:String="Tristan") 
		{
			name = _name;
			setTrainingImage();
			raiseParticularStatByN("strength", 2);
			raiseParticularStatByN("defense", 3); 
			raiseParticularStat("constitution", 5, 4);
			maxMp = 3;
			mp = maxMp;
			setMaxHp(50);
			var singleStrike:SingleStrike = new SingleStrike();
			var hpPot:HealthPotion = new HealthPotion();
			singleStrike.setOwner(this);
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleStrike]; 
			setInitialState();
			
		}
		public function gainExperience():void {
			maxHp += 1;
			hp = maxHp; 
		}
		public function resetPlayer():void {
			this.resetMob(); 
		}
		public function setTrainingImage():void {
			icon.setHair(ConvertEmbedToSprite(hair));
			equip(new BluePants());
			equip(new Club());
		
			setBattlePiece(icon);
			
			inventory.addItem(new SwiftKatana());
		}
		public function setSquireImage():void {
			equip(new LeatherArmor());
			equip(new Katana()); 
			equip(new BrownPants());
			equip(new BrownShoes());
			setMaxHp(50);
			setBattlePiece(ConvertEmbedToSprite(primaryImg)); 
		}
		public function setLevelTwo():void {
			/*setStatus(promotedStats);
			gainExperience()
			setBattlePiece(ConvertEmbedToSprite(primaryImg)); 
			maxMp = 2;
			mp = maxMp;
			hp = maxHp;
			var doubleStrike:SingleStrike = new SingleStrike();
			var defenseUp:DefensiveStance = new DefensiveStance();
			var hpPot:HealthPotion = new HealthPotion();
			doubleStrike.setOwner(this);
			defenseUp.setOwner(this); 
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, doubleStrike, defenseUp ];
			*/
		}
		
		public function setLevelThree():void {
			/*
			if (lvl < 3) {
			raiseParticularStatByN("strength", 4);
				raiseParticularStatByN("defense", 4);
				raiseParticularStatByN("constitution", 10);
				lvl = 3; 
			}
			var doubleStrike:SingleStrike = new SingleStrike();
			var defenseUp:DefensiveStance = new DefensiveStance();
			var rage:Rage = new Rage();
			var hpPot:HealthPotion = new HealthPotion();
			var antidote:Antidote = new Antidote();
			antidote.setOwner(this);
			doubleStrike.setOwner(this);
			hpPot.setOwner(this);
			rage.setOwner(this);
			aQuickSlots = [hpPot, antidote, doubleStrike, defenseUp, rage ];
			*/

		}
		
	}

}