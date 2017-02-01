package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class BleedingHeart extends Skill
	{
		[Embed(source = "../pics/skills icon/bleeding heart.png")]
		private var imgClass:Class; 
		
		public function BleedingHeart() 
		{
			super("Bleeding Heart", 3, 10, "Duration: 3 turns\nDoesn't stack, can be reset\nCause your opponent to bleed!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			//deal damage
			//inflict bleeding
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Bleeding Heart");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax );
				var dmg:Number = stats.strength (0.20) + stats.wisdom * (0.20);
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.processAfflictions(dmg, 3, "bleeding");
				tgt.changeHp( dmg * -1, "physical", owner.nextAttackIsArmorPierce() );
				tgt.getBattlePiece().showDamage(dmg); 
				tgt.getBattlePiece().showBleeding();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}