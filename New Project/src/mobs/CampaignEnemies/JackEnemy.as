package mobs.CampaignEnemies 
{
	/**
	 * ...
	 * @author kljjlk
	 */
		import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite; 
	import skills.*;
	import items.*;
	public class JackEnemy extends Enemy
	{
		[Embed(source = "images/Jack.png")]
		public var img:Class;
		public function JackEnemy() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":18,
				"defense":15,
				"wisdom":4,
				"dexterity":4,
				"constitution":20
			}
			setStatus(newStats);
			setMaxHp(40);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:DoubleStrike = new DoubleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			inventory.addItem(hpPot); 
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			actions = [singleStrike, parry, bleedingHeart]; 
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			
		}
		
	}

}