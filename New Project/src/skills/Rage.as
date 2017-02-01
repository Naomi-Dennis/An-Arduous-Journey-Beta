package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Rage extends Skill
	{
		[Embed(source = "../pics/skills icon/rage.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Rage.mp3")]
		private var sound:Class; 
		public function Rage() 
		{
			super("Rage", 4, 5, "Duration: 3 turns\nDoesn't stack, can be reset\n\nIncrease strength by 20%!");

			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1;  
			Main.sndConfig.playSound(sound);
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				//tgt.changeAttr("strength", stats.strength * (0.10)); 
				//chance user's strength by 20 percent for 1 turn
				var strBoost:int = Math.ceil( stats.strength * (0.20) );
				tgt.setAffliction( "rage strength", strBoost, 3 ); 
				tgt.getBattlePiece().showRage();
				tgt.getBattlePiece().addEffect("rage");
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}