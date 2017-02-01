package mobs.Players 
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.Antidote;
	import items.armor.BluePants;
	import items.HealthPotion;
	import items.weapon.Bow;
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
	public class BranInTraining extends Mob
	{
		[Embed(source="Beserker.png")]
		private var img:Class;
		[Embed(source="../CampaignEnemies/images/BranInTraining.png")]
		private var trainingImg:Class;
		private var lvl:int = 0;
		public var promotedStats:Object = {"strength": 0, "constitution": 0, "wisdom": 0, "dexterity": 0, "defense": 0};
		public function BranInTraining(_name:String="Bran") 
		{
			name = _name;
			setTrainingImage();
			raiseParticularStatByN("strength", 2); 
			raiseParticularStatByN("dexterity", 4);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStat("constitution", 5, 4);
			maxMp = 3;
			mp = maxMp;
			setMaxHp(50);
			var singleShot:SingleShot = new SingleShot();
			var hpPot:HealthPotion = new HealthPotion();
			singleShot.setOwner(this);
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleShot]; 
			setInitialState();
			
		}
		public function resetPlayer():void {
			this.resetMob(); 
		}
		public function setTrainingImage():void {
			equip(new Bow());
			equip(new BluePants());
			icon.genHair();
			setBattlePiece();
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
		
	}

}