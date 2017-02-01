package skills 
{
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class SingleStrike extends Skill 
	{
		[Embed(source = "../pics/skills icon/single strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Single - Double - Triple Strike.mp3")]
		private var sound:Class; 
		public function SingleStrike() 
		{
			super("Single Strike", 6, 1, "\nStrike your opponent once!");
			rangeShape = "von"; 
			range = 1; 
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
		}
		public override function perform(tgt:Mob):String {
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Single Strike");
			if (owner.getAp() >= ap && tgt != null && !onCooldown()) {
				var stats:Object =  owner.getStatus();
				owner.changeAp( -1 * ap); 
				var dmg:int = stats.strength; 
				if (owner.isNextAttackCritical()) {
					dmg *= 2; 
					owner.deactivateAutoCrit();
				}
				tgt.changeHp( dmg  * -1, "physical", owner.nextAttackIsArmorPierce() ); 
				tgt.getBattlePiece().showDamage( dmg ); 
			}
			else {
				owner.changeAp( -1 * ap); 
			}
			triggerCooldown()
			return "";
		}
		
	}

}