package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class SpinAttack extends Skill
	{
		[Embed(source = "../pics/skills icon/spinAttack.png")]
		private var ico:Class;
		public function SpinAttack()
		{
			super("Spin Attack", 5, 6, "\nSpin around striking all the opponents about you.");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 1;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("Spin Attack!");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				owner.changeAp(tax);
				var dmg:int = Math.ceil(stats.strength * 0.50);
				if (owner.isNextAttackCritical())
				{
					owner.getBattlePiece().showAttackCry("Critical!");
					dmg *= 2;
					owner.deactivateAutoCrit();
				}
				tgt.changeHp(dmg * -1, "physical", owner.nextAttackIsArmorPierce());
				tgt.getBattlePiece().showDamage(dmg);
				}
			}
			else if (tgt == null)
			{
				owner.changeAp(tax);
				triggerCooldown()
			}
			return "";
		}
	
	}

}