package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Parry extends Skill
	{
		[Embed(source = "../pics/skills icon/parry.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Defensive Stance - Parry.mp3")]
		private var sound:Class; 
		public function Parry() 
		{
			super("Parry", 4, 3, "Parry your opponent's next attack.");
		
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Parry");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				//create parry functionality
				owner.activateParry();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}