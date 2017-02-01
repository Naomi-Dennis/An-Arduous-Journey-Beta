package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class FireArrow extends Skill
	{
		[Embed(source = "../pics/skills icon/fire arrow.png")]
		private var ico:Class;
		
		public function FireArrow()
		{
			super("Fire Arrow", 6, 5, "Duration: 5 turns\nDoesn't stack, can be reset\n\nAn arrow that burns multiple enemies!");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 7;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			owner.getBattlePiece().showAttackCry("*Fire Arrow*");
			triggerCooldown();
			var stats:Object = owner.getStatus();
			var dmg:Number = Math.ceil(stats.wisdom * (.10) + stats.dexterity * (0.10));
			var physicalDmg:Number = stats.dexterity * (0.75);
			//burning dmg 
			tgt.processAfflictions(dmg, 5, "burning");
			tgt.getBattlePiece().showBurning();
			tgt.getBattlePiece().getCellLocation().setFireState();
			//physical dmg
			tgt.changeHp(physicalDmg * -1, "magic");
			tgt.getBattlePiece().showDamage(physicalDmg);
			return "";
		}
	
	}

}