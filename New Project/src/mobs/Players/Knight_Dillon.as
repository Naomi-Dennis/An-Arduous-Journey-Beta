package mobs.Players 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import items.Antidote;
	import items.HealthPotion;
	import skills.BleedingHeart;
	import skills.DefensiveStance;
	import skills.DoubleShot;
	import skills.DoubleStrike;
	import skills.Parry;
	import skills.SingleShot;
	import skills.SingleStrike;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Knight_Dillon extends Mob
	{
		[Embed(source="Knight.png")]
		private var img:Class;
		public function Knight_Dillon() 
		{
			name = "Dillon";
			setBattlePiece(ConvertEmbedToSprite(img)); 
		}
		public function setLevelOne():void {
			raiseParticularStatByN("strength", 6);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:SingleStrike = new SingleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, singleStrike, parry]; 
		}
		public function setLevelTwo():void {
			raiseParticularStatByN("strength", 6);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:SingleStrike = new SingleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			aQuickSlots = [hpPot, singleStrike, parry]; 
		} 
		public function setLevelThree():void {
			raiseParticularStatByN("strength", 6);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:SingleStrike = new SingleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			var doubleStrike:DoubleStrike = new DoubleStrike();
			doubleStrike.setOwner(this);
			var antidote:Antidote = new Antidote();
			antidote.setOwner(this);
			aQuickSlots = [hpPot, antidote, singleStrike, parry, doubleStrike]; 
		}
		
	}

}