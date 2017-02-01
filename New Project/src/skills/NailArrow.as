package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class NailArrow extends Skill
	{
		[Embed(source = "../pics/skills icon/nail arrow.png")]
		private var ico:Class;
		public function NailArrow()
		{
			super("Nail Arrow", 6, 5, "An arrow that unleashes a flurry of nails, attacking nearby opponents!");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 7;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("*Nail Arrow*");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				var physicalDmg:Number = stats.dexterity * (0.80);
				//physical dmg
				tgt.changeHp( physicalDmg  * -1, "physical", owner.nextAttackIsArmorPierce() ); 
				tgt.getBattlePiece().showDamage( physicalDmg ); 
				
			}
			return "";
		}
	
	}

}