package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class EarthStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/earth strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Earth Strike.mp3")]
		private var sound:Class; 
		public function EarthStrike() 
		{
			super("Earth Strike", 4, 4, "\nHurl a chunk of earth at your opponent and strike down your enemy!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Earth Strike");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:int = stats.wisdom * (0.75); 
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.changeHp( dmg * -1, "magic" ); 
				tgt.getBattlePiece().showDamage( dmg ); ; 
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}