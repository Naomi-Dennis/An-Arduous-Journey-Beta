package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class IncreaseMovement extends Skill
	{
		[Embed(source = "../pics/skills icon/increase movement.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Up.mp3")]
		private var sound:Class; 
		public function IncreaseMovement() 
		{
			super("Swiftness", 4, 12, "Duration: 1 turn\nDoesn't stack, can be reset\n\nIncrease your mp by 2 !");
	
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 0; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			Main.sndConfig.playSound(sound);
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Swiftness");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				tgt.increaseMovementBy(2);
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}