package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class DefensiveStance extends Skill
	{
		[Embed(source = "../pics/skills icon/defensive stance.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Up.mp3")]
		private var sound:Class; 
		public function DefensiveStance() 
		{
			super("Defensive Stance", 6, 10, "Duration: 5 turns\nDoesn't stack, can be reset\n\nHeighten defenses by 50%!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 6; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			//increase defenses by 50% for 
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Defensive Stance");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var newDef:int = stats.defense + (stats.defense * 0.50); 
				if (owner.isNextAttackCritical()) {
						newDef *= 2;
						owner.deactivateAutoCrit();
				}
				//call function to temporarily increase stats for x turns
				tgt.setAffliction("stance defense", newDef, 5); 
				tgt.getBattlePiece().showPowerUp("defense");
				tgt.getBattlePiece().addEffect("defense up");
				
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}