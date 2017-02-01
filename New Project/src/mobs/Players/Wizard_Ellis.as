package mobs.Players 
{
	import items.HealthPotion;
	import skills.EarthStrike;
	import skills.FireStrike;
	import skills.LowerConsitution;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Wizard_Ellis extends Mob
	{
		[Embed(source = "Wizard.png")]
		private var img:Class;
		public function Wizard_Ellis() 
		{
			name = "Ellis"; 
			setBattlePiece(ConvertEmbedToSprite(img)); 
		}
		public function setLevelOne():void {
			raiseParticularStatByN("wisdom", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var earthStrike:EarthStrike = new EarthStrike();
			earthStrike.setOwner(this);
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, earthStrike];
		}
		public function setLevelTwo():void {
			raiseParticularStatByN("wisdom", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var earthStrike:EarthStrike = new EarthStrike();
			earthStrike.setOwner(this);
			var fireStrike:FireStrike = new FireStrike();
			fireStrike.setOwner(this);
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, earthStrike, fireStrike];
		}
		public function setLevelThree():void {
			raiseParticularStatByN("wisdom", 8);
			raiseParticularStatByN("defense", 4); 
			raiseParticularStatByN("constitution", 10);
			var earthStrike:EarthStrike = new EarthStrike();
			earthStrike.setOwner(this);
			var fireStrike:FireStrike = new FireStrike();
			fireStrike.setOwner(this);
			var lowerConstitution:LowerConsitution = new LowerConsitution();
			lowerConstitution.setOwner(this);
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			aQuickSlots = [hpPot, earthStrike, fireStrike, lowerConstitution];
		}
		
		
	}

}