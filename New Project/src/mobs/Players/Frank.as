package mobs.Players 
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import Assets.Utility.ConvertEmbedToSprite;
	import items.*;
	import skills.*;
	public class Frank extends Mob
	{
		[Embed(source = "../CampaignEnemies/images/Frank.png")]
		private var img:Class; 
		public function Frank() 
		{
			name = "SerYork";
			setBattlePiece(ConvertEmbedToSprite(img)); 
		}
		public function setLevel():void {
			this.clearStats();
			var newStatus:Object = {
				"defense":4,
				"strength":6,
				"wisdom":0,
				"constitution":20,
				"dexterity": 1
			}
			setStatus(newStatus);
			setMaxHp(40);
			var anoint:Anoint = new Anoint();
			anoint.setOwner(this);
			var iceStrike:IceAttack = new IceAttack();
			iceStrike.setOwner(this);
			var heal:Heal = new Heal()
			heal.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			aQuickSlots = [anoint, iceStrike, heal, hpPot]; 
		}
	}

}