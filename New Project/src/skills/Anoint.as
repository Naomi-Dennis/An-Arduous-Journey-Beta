package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class Anoint extends Skill
	{
		[Embed(source = "../pics/skills icon/anoint.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Heal.mp3")]
		private var sound:Class; 
		public function Anoint() 
		{
			super("Annoint", 2, 20, "Duration: 3 turns\nDoesn't stack, can reset\n\nIncrease the base stats of all allies by 15%!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 10; 
			rangeShape = "all_allies"; 
		}
		public override function perform(tgt:Mob):String {
			//temporarily increases all stats
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound); 
			owner.getBattlePiece().showAttackCry("Anoint");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				var tgtStats:Object = tgt.getStatus(); 
				var dmg:int = 0;
				for (var i:* in tgtStats) {
					dmg = tgtStats[i] + tgtStats[i] * (0.15); 
					if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
					}
					tgt.setAffliction( "anoint " + String(i).toLowerCase(), 3, dmg);
					
					
				}
				tgt.getBattlePiece().addEffect("defense up");
				tgt.getBattlePiece().addEffect("strength up");
				tgt.getBattlePiece().addEffect("constitution up");
				tgt.getBattlePiece().addEffect("wisdom up");
				tgt.getBattlePiece().addEffect("dexterity up");
				tgt.processAfflictions(3, 3, "ap up");
				tgt.getBattlePiece().showHeal(0);
				owner.getBattlePiece().showHeal(0);
				//call battle piece effect, buffed
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}