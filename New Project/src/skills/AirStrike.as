package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import Assets.Utility.RollDie;
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class AirStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/air strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Air Strike.mp3")]
		private var sound:Class; 
		public function AirStrike() 
		{
			super("Air Strike", 4, 3, "\nConcentrate air and launch a deadly attack on your foes!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			//attacks the enemy
			var tax:int = this.ap * -1 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Air Strike");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				var dmg:Number = stats.wisdom * (0.75); 
				if (owner.isNextAttackCritical()) {
					dmg *= 2;
					owner.deactivateAutoCrit();
				}
				owner.changeAp( tax ); 
				
				tgt.changeHp( dmg * -1, "magic"); 
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