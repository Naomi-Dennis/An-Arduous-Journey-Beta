package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.utils.setTimeout;
	import items.HealthPotion;
	import skills.Anoint;
	import skills.FireStrike;
	import skills.Heal;
	import skills.LowerConsitution;
	import skills.SingleShot;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BanditBoss extends Enemy
	{
		[Embed(source="images/BanditLeader.png")]
		public var img:Class; 
		public function BanditBoss() 
		{
			var newStatus:Object = {
				"strength":2,
				"defense":2,
				"consitution":15,
				"wisdom":25,
				"dexterity":2
			}
			setName("Bandit");
			setMaxHp(20)
			setStatus(newStatus);
			
			maxMp = 3; 
			mp = maxMp;
			var fireStrike:FireStrike = new FireStrike();
			var anoint:Anoint = new Anoint();
			var singleStrike:SingleStrike = new SingleStrike(); 
			fireStrike.setOwner(this);
			anoint.setOwner(this);
			singleStrike.setOwner(this);
			actions = [anoint, fireStrike, singleStrike];
			inventory.addItem(new HealthPotion()); 
			setBattlePiece();
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			var attk:Skill = orderOfAttack();
			
			if (!doSkill(field, player, attk))
			{
				setTimeout(function():void { }, 500);
				if (ap >= attk.getAp()) {
					doSkill(field, player, attk);; 
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