package mobs.CampaignEnemies
{
	import Assets.Utility.ConvertEmbedToSprite;
	import skills.*;
	import items.*;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author kljjlk
	 */
	public class RoyalGuardWithBow extends Enemy
	{
		[Embed(source="images/Royal Guard With Bow.png")]
		public var img:Class; 
		public function RoyalGuardWithBow() 
		{
			var newStatus:Object = {"defense": 4, "strength": 2, "wisdom": 0, "constitution": 20, "dexterity": 6}
			setStatus(newStatus);
			setMaxHp(30)
			setBattlePiece(ConvertEmbedToSprite(img));
			maxMp = 3; 
			mp = maxMp;
			this.ap = 8;
			maxAp = ap; 
			var swift:IncreaseMovement = new IncreaseMovement();
			var singleStrike:SingleShot = new SingleShot();
			singleStrike.setOwner(this);
			swift.setOwner(this);
			actions = [swift, singleStrike];
			inventory.addItem(new HealthPotion()); 
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			var attk:Skill = orderOfAttack();
			var closestPlayer:Mob = getClosestPlayer(field); 
			if (attk != null && !doSkill(field, closestPlayer, attk))
			{
				moveTowardsPlayer(field, closestPlayer);
				attk = orderOfAttack(); 
				if (attk != null && ap >= attk.getAp() )
				{
					doSkill(field, player, attk);
				}
			}
			setTimeout(function():void { }, 500);
			if (this.getHp() <= this.getMaxHp() * 0.50) {
				var potion:HealthPotion = inventory.getItemByName("Health Potion") as HealthPotion; 
				if(potion != null){
					potion.useItem();
				}
			}
		}
		public override function orderOfAttack():Skill {
			var canUse:Skill = null;
			for (var i:* in actions){
				if (!actions[i].onCooldown() && this.getAp() >= actions[i].getAp()) {
					return actions[i]
				}
			}
			return null;
		}
	}

}