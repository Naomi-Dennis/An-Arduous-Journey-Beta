package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class WaterStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/water strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Water Strike.mp3")]
		private var waterStrike:Class; 
		public function WaterStrike() 
		{
			super("Water Strike", 4, 1, "Summon water and launch a deadly attack on your foes.\n(wis * 0.75)");

			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(waterStrike);
			owner.getBattlePiece().showAttackCry("Water Strike");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				var dmg:Number = stats.wisdom * (0.75); 
				owner.changeAp( tax ); 
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.changeHp( dmg * -1 ); 
				tgt.getBattlePiece().showDamage( dmg ); 
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}