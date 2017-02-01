package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class SingleShot extends Skill
	{
		[Embed(source = "../pics/skills icon/single shot.png")]
		private var imgClass:Class; 
		[Embed(source="../snd/Single - Double - Triple Strike.mp3")]
		private var sound:Class; 
		public function SingleShot() 
		{
			super("Single Shot", 3, 1, "\nShoot a single arrow at your opponent!");
	
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 5; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			Main.sndConfig.playSound(sound);
			var tax:int = 0;
			owner.getBattlePiece().showAttackCry("Single Shot");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				tax = ap * -1; 
				var dmg:Number = stats.dexterity * (0.75); 
				owner.changeAp( tax ); 
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.changeHp( dmg *  -1, "physical", owner.nextAttackIsArmorPierce() ); 
				tgt.getBattlePiece().showDamage( dmg ); 
			}
			else if (tgt == null) {
				tax = ap * -1; 
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
		
		
	}

}