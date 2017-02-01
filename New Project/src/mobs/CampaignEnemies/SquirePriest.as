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
	public class SquirePriest extends Enemy
	{
		[Embed(source = "images/SquirePriest.png")]
		public var img:Class; 
		public function SquirePriest() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":9,
				"defense":2,
				"wisdom":10,
				"dexterity":2,
				"constitution":0
			}
			setStatus(newStats);
			setMaxHp(30); 
			hp = maxHp; 
			addAction(new AirStrike());
			addAction(new Heal());
			inventory.addItem(new HealthPotion());
			inventory.addItem(new WisdomPotion()); 
		}
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
						var hasMoved:Boolean = false;
			var hasAttacked:Boolean  = false; 
			hasMoved = moveAround( function():void { moveTowardsPlayer(field, getClosestPlayer(field));  } );
			hasAttacked = attack(field, orderOfAttack(), getClosestPlayer(field) );
			if (hp < getMaxHp() * 0.50) {
				useInventory(new HealthPotion(), HealthPotion);
			}
			if (hasMoved || hasAttacked) {
				brainTick(player, field, allies); 
			}
		}
	}

}