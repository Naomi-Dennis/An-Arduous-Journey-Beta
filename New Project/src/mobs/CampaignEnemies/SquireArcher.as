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
	public class SquireArcher extends Enemy
	{
		[Embed(source = "images/squireArcher.png")]
		public var img:Class; 
		public function SquireArcher() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":2,
				"defense":10,
				"wisdom":4,
				"dexterity":9,
				"constitution":0
			}
			setStatus(newStats);
			setMaxHp(30); 
			hp = maxHp; 
			addAction(new SingleShot());
			addAction(new IncreaseMovement());
			inventory.addItem(new HealthPotion());
			inventory.addItem(new DexterityPotion());
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