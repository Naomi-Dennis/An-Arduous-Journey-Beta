package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import items.armor.BrownPants;
	import items.weapon.Club;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class WarriorInTraining extends Enemy
	{
		[Embed(source="images/warriorInTraining.png")]
		public var img:Class; 
		public function WarriorInTraining(_name:String) 
		{
			name = _name;
			raiseParticularStatByN("strength", 1); 
			raiseParticularStat("consitution", 3, 4);
			setBattlePiece(ConvertEmbedToSprite(img));
			equip(new BrownPants());
			equip(new Club());
			icon.genHair(); 
			maxMp = 3; 
			mp = maxMp;
			setMaxHp(50);
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
		}
		public override function orderOfAttack():Skill {
			var singleStrike:SingleStrike = new SingleStrike();
			singleStrike.setOwner(this);
		    return singleStrike; 
		}
	}

}