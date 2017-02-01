package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class PressurePoints extends Skill
	{
		[Embed(source = "../pics/skills icon/pressure points.png")]
		private var ico:Class;
		public function PressurePoints()
		{
			super("Pressure Points", 5, 9, "Duration: 2 turns\nDoesn't stack, can be reset\n\nStrike the pressure points, reducing the target's ap by 3!");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 1;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("*Pressure Points*");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				owner.changeAp(tax);
				tgt.changeHp(0);
				tgt.getBattlePiece().addEffect("ap down");
				tgt.processAfflictions( -3, 2, "ap"); 
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