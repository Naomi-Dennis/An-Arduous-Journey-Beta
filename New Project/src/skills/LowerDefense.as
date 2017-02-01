package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class LowerDefense extends Skill
	{
		[Embed(source = "../pics/skills icon/lower defense.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Down.mp3")]
		private var sound:Class; 
		public function LowerDefense() 
		{
			super("Lower Defense", 2, 10, "Duration: 7 turns\nDoesn't stack, can be reset\n\nLower's the opponent's defenses!");
			
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("Lower Defense");
			Main.sndConfig.playSound(sound);
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:Number = (this.getOwner().getStatus().wisdom * (0.25)) ;
				var def:Number = tgt.getStatus().defense - dmg; 
				//temporarily change defense temporarily
				tgt.tempStatusChange("lower defense", -def, 7); 
				tgt.getBattlePiece().showPowerDown("defense"); 
				tgt.getBattlePiece().addEffect("defense down");
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}