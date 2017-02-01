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
	public class RoyalArcher extends Enemy
	{
		[Embed(source = "images/RoyalArcher.png")]
		public var img:Class;
		public function RoyalArcher() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":8,
				"defense":15,
				"wisdom":8,
				"dexterity":15,
				"constitution":8
			}
			setStatus(newStats);
			setMaxHp(50); 
			hp = maxHp; 
			inventory.addItem(new HealthPotion());
			addAction(new DoubleShot());
			addAction(new IncreaseMovement());
			addAction(new LowerDefense()); 
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