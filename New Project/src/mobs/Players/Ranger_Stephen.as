package mobs.Players 
{
	import items.HealthPotion;
	import skills.DoubleShot;
	import skills.SingleShot;
	import skills.TripleShot;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Ranger_Stephen extends Mob
	{
		[Embed(source="Archer.png")]
		private var img:Class;
		public function Ranger_Stephen() 
		{
			name = "Stephen"; 
			setBattlePiece(ConvertEmbedToSprite(img)); 
		}
		public function setLevelOne():void {
			raiseParticularStatByN("dexterity", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var singleShot:SingleShot = new SingleShot();
			singleShot.setOwner(this);
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleShot];
		}
		public function setLevelTwo():void {
			raiseParticularStatByN("dexterity", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var singleShot:SingleShot = new SingleShot();
			singleShot.setOwner(this);
			var doubleShot:DoubleShot = new DoubleShot();
			doubleShot.setOwner(this);
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleShot, doubleShot];
		}
		public function setLevelThree():void {
			raiseParticularStatByN("dexterity", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var singleShot:SingleShot = new SingleShot();
			singleShot.setOwner(this);
			var doubleShot:DoubleShot = new DoubleShot();
			doubleShot.setOwner(this);
			var tripleShot:TripleShot = new TripleShot();
			tripleShot.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleShot, doubleShot, tripleShot];
		}
		
	}

}