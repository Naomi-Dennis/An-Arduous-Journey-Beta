package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class PoisonArrow extends Skill
	{
		[Embed(source = "../pics/skills icon/poison arrow.png")]
		private var ico:Class;
		
		public function PoisonArrow()
		{
			super("Poison Arrow", 6, 5, "Duration: 5 turns\nDoesn't stack, can be reset\n\nShoot a poison arrow affecting the surrounding units!");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 7;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("*Poison Arrow*");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				var dmg:Number = Math.ceil(stats.wisdom * (.10) + stats.dexterity * (0.25));
				var physicalDmg:Number = stats.dexterity * (0.80);
				//poison dmg 
				tgt.processAfflictions(dmg, 5, "poisoned");
				tgt.getBattlePiece().showPoisoned();
				//physical dmg
				tgt.changeHp(physicalDmg * -1, "physical", owner.nextAttackIsArmorPierce());
				tgt.getBattlePiece().showDamage(physicalDmg);
				tgt.getBattlePiece().getCellLocation().setPoisonState();
				
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