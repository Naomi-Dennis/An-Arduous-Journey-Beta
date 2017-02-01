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
	public class RoyalGuardWithSword extends Enemy
	{
		[Embed(source="images/Royal Guard With Sword.png")]
		public var img:Class; 
		public function RoyalGuardWithSword()
		{
			
			var newStatus:Object = {"defense": 4, "strength": 6, "wisdom": 0, "constitution": 20, "dexterity": 1}
			setStatus(newStatus);
			setMaxHp(30)
			setStatus(newStatus);
			setBattlePiece(ConvertEmbedToSprite(img));
			maxMp = 3;
			mp = maxMp;
			var singleStrike:SingleStrike = new SingleStrike();
			var parry:Parry = new Parry();
			var lowerConst:LowerConsitution = new LowerConsitution();
			singleStrike.setOwner(this);
			lowerConst.setOwner(this);
			parry.setOwner(this);
			actions = [singleStrike, parry, lowerConst];
			inventory.addItem(new HealthPotion());
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			var attk:Skill = orderOfAttack();
			
			if (attk != null && !doSkill(field, player, attk))
			{
				moveTowardsPlayer(field, player);
				
				if (ap >= attk.getAp())
				{
					doSkill(field, player, attk);
				}
			}
			setTimeout(function():void
				{
				}, 500);
			if (this.getHp() <= this.getMaxHp() * 0.50)
			{
				var potion:HealthPotion = inventory.getItemByName("Health Potion") as HealthPotion;
				if (potion != null)
				{
					potion.useItem();
				}
			}
		}
		
		public override function orderOfAttack():Skill
		{
			var canUse:Skill = null;
			for (var i:*in actions)
			{
				if (!actions[i].onCooldown() && this.getAp() >= actions[i].getAp())
				{
					return actions[i]
				}
			}
			return null;
		}
	}

}