package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class InflictWound extends Skill
	{
		[Embed(source = "../pics/skills icon/inflict wound.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Single - Double - Triple Shot.mp3")]
		private var shotSnd:Class; 
		[Embed(source = "../snd/Single - Double - Triple Strike.mp3")]
		private var strikeSnd:Class; 
		public function InflictWound() 
		{
			super("Inflict Wound", 3, 10, "Duration: 5 turns\nInf. Stack\n\nCause an enemy to bleed for a longer time!\nThe enemy must already be bleeding!");
		
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Inflict Wound");
			if (owner.getName() == "Tristan" || owner.getName() == "Dillon") {
				Main.sndConfig.playSound(strikeSnd); 
			}
			else {
				Main.sndConfig.playSound(shotSnd);
			}
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var affliction:Object = tgt.getAfflictions();
				var afflictionDmg:Object = stats.strength * .15;
				if (owner.getClass().toLowerCase() == "archer"){
					afflictionDmg = stats.dexterity * .15; 
				}
				if (owner.isNextAttackCritical()) {
						afflictionDmg.bleeding *= 2;
						owner.deactivateAutoCrit();
				}
				if (affliction.bleeding >= 0) {
					tgt.processAfflictions(afflictionDmg.bleeding, affliction.bleeding + 5, "bleeding");
					tgt.getBattlePiece().showBleeding();
				}
				if (owner.getClass().toLowerCase() == "warrior"){
					tgt.changeHp( (owner.getStatus()["strength"] * 0.25) * -1 );
				}
				else if(owner.getClass().toLowerCase() == "archer"){
					tgt.changeHp( (owner.getStatus()["dexterity"] * 0.25) * -1 );
				}
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}