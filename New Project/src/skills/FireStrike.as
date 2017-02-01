package skills
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class FireStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/fire strike.png")]
		private var imgClass:Class;
		[Embed(source = "../snd/Fireball.mp3")]
		private var sound:Class;
		
		public function FireStrike()
		{
			super("FireStrike", 4, 4, "Duration: 4 turns\nDoesn't stack, can be reset\n\nStrike your enemy wwith deadly fire!");
			
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7;
			rangeShape = "line";
		}
		
		public override function perform(tgt:Mob):String
		{
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Fire Strike");
			triggerCooldown();
			var stats:Object = owner.getStatus();
			var dmg:int = stats.wisdom * (0.75);
			if (owner.isNextAttackCritical())
			{
				dmg *= 2;
				owner.deactivateAutoCrit();
			}
			var tax:int = this.ap * -1 
			owner.changeAp( tax ); 
			tgt.changeHp(dmg * -1, "magic");
			tgt.getBattlePiece().showDamage(dmg);
			tgt.processAfflictions(stats.wisdom * (0.05), 4, "burning");
			tgt.getBattlePiece().showBurning();
			tgt.getBattlePiece().getCellLocation().setFireState();
			// attack enemy
			//inflict burning
			return "";
		}
	}

}