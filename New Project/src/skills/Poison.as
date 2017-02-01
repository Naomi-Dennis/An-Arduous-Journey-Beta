package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Poison extends Skill
	{
		[Embed(source = "../pics/skills icon/poison.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Down.mp3")]
		private var sound:Class; 
		public function Poison() 
		{
			super("Poison", 4, 5, "Duration: 5 turns\nDoesn't stack, can be reset\n\nInflict poison on the opponent!");
		
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 5; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Poison");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:Number = stats.wisdom * (.10) + 2; 
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.getBattlePiece().getCellLocation().setPoisonState();
				tgt.processAfflictions(dmg, 5, "poisoned");
				tgt.getBattlePiece().showPoisoned();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}