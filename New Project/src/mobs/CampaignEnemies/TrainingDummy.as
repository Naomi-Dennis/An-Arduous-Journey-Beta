package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class TrainingDummy extends Enemy
	{
		[Embed(source="images/trainingDummy.png")]
		public var img:Class; 
		public function TrainingDummy() 
		{
			name = "Training Dummy" 
			raiseParticularStatByN("strength", 1); 
			raiseParticularStat("consitution", 1, 4);
			setBattlePiece(ConvertEmbedToSprite(img));
			maxMp = 0; 
			mp = maxMp; 
			setMaxHp(50);
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			var attk:Skill = orderOfAttack();
			
			
			//doSkill(field, player, attk);; 
			getBattlePiece().showAttackCry("*Haha*");

		}
		public override function orderOfAttack():Skill {
			var singleStrike:SingleStrike = new SingleStrike();
			singleStrike.setOwner(this);
		    return singleStrike; 
		}
	}

}