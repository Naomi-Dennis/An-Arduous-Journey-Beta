package mobs.Players 
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import Assets.Utility.ConvertEmbedToSprite;
	import items.*;
	import skills.*;
	public class Jack extends Mob
	{
		[Embed(source = "../CampaignEnemies/images/Jack.png")]
		private var img:Class; 
		public function Jack() 
		{
			name = "SerYork";
			setBattlePiece(ConvertEmbedToSprite(img)); 
		}
		public function setLevel():void {
			this.clearStats();
			var newStatus:Object = {
				"defense":4,
				"strength":18,
				"wisdom":6,
				"constitution":20,
				"dexterity": 1
			}
			setStatus(newStatus);
			setMaxHp(40);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:DoubleStrike = new DoubleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			aQuickSlots = [hpPot, singleStrike, parry]; 
		}
	}

}