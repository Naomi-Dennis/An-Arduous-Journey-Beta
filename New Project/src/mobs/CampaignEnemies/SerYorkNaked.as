package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import items.HealthPotion;
	import skills.*;
	import items.*;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class SerYorkNaked extends Enemy
	{
		[Embed(source="images/SerYorkNaked.png")]
		public var img:Class; 
		public function SerYorkNaked() 
		{
			name = "SerYork";
			setBattlePiece(ConvertEmbedToSprite(img)); 
			this.clearStats();
			var newStatus:Object = {
				"defense":0,
				"strength":6,
				"wisdom":0,
				"constitution":20,
				"dexterity": 1
			}
			setStatus(newStatus);
			var singleStrike:SingleStrike = new SingleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			var parryAttk:Parry = new Parry();
			parryAttk.setOwner(this);
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			inventory.addItem(hpPot);
			actions = [singleStrike, parryAttk, bleedingHeart]; 
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			var attk:Skill = orderOfAttack();
			
			if (!doSkill(field, player, attk))
			{
				moveTowardsPlayer(field, player);
				if (ap >= attk.getAp()) {
					doSkill(field, player, attk);; 
				}
			}
			
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