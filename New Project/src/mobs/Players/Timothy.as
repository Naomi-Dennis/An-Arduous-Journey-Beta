package mobs.Players 
{
	/**
	 * ...
	 * @author kljjlk
	 */
		import Assets.Utility.ConvertEmbedToSprite;
	import items.*;
	import skills.*;
	public class Timothy extends Mob
	{
		[Embed(source = "../CampaignEnemies/images/Timothy.png")]
		private var img:Class; 
		public function Timothy() 
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
			var doubleShot:Anoint = new Anoint();
			doubleShot.setOwner(this);
			var swiftness:IceAttack = new IceAttack();
			swiftness.setOwner(this);
			var stunStrike:StunStrike = new StunStrike()
			stunStrike.setOwner(this); 
			stunStrike.setRange(doubleShot.getRange());
			var hpPot:HealthPotion = new HealthPotion();
			aQuickSlots = [doubleShot ,stunStrike, stunStrike, hpPot]; 
		}
		
	}

}