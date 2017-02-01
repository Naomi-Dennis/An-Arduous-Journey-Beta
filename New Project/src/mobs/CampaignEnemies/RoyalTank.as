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
	public class RoyalTank extends Enemy
	{
		[Embed(source = "images/RoyalTank.png")]
		public var img:Class;
		public function RoyalTank() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":15,
				"defense":20,
				"wisdom":8,
				"dexterity":8,
				"constitution":8
			}
			setStatus(newStats);
			setMaxHp(50); 
			hp = maxHp; 
			inventory.addItem(new StrengthPotion());
			addAction(new Rage());
			addAction(new DefensiveStance()); 
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