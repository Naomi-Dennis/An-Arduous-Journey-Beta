package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class StunStrike extends Skill
	{
		[Embed(source="../pics/skills icon/stun strike.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Down.mp3")]
		private var sound:Class; 
		public function StunStrike() 
		{
			super("Stun Strike", 4, 5, "Duration: 3\n\nDoesn't stack, can be reset\nStun your opponent!");
	
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			Main.sndConfig.playSound(sound); 
			owner.getBattlePiece().showAttackCry("Stun Strike");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:Number = stats.strength * (0.75) + stats.wisdom * (0.75);
				if (owner.getClass().toLowerCase() == "warrior"){
					dmg = stats.strength * .75 
				}
				else if (owner.getClass().toLowerCase() == "archer"){
					dmg = stats.dexterity * .75 
				}
				else if (owner.getClass().toLowerCase() == "mage"){
					dmg = stats.strength * .75 
				}
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.processAfflictions(0, 3, "stunned"); 
				tgt.changeHp(dmg, "physical", owner.nextAttackIsArmorPierce())
				tgt.getBattlePiece().showStunned();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}