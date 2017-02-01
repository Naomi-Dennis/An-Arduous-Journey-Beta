package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class DeadlyStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/deadly strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Up.mp3")]
		private var sound:Class; 
		public function DeadlyStrike() 
		{
			super("Deadly Strike", 1, 10, "Aim at the pressure points! You're next melee attack will do critical damage!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			//set the next attack to be an auto critical
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Deadly Strike");
			if (owner.getAp() >= ap && tgt != null) {
				
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				owner.activateAutoCrit();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}