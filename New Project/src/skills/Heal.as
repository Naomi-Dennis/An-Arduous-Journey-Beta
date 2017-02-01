package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Heal extends Skill
	{
		[Embed(source = "../pics/skills icon/heal.png")]
		private var imgClass:Class; 
		public function Heal() 
		{
			super("Heal", 3, 4, "\nHeal a teammate!");
	
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 0; 
			rangeShape = "allies"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Heal");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax );
				var power:int = tgt.getMaxHp() * (0.30) + stats.wisdom * (0.15); 
				if (owner.isNextAttackCritical()) {
						power *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.changeHp( power );
				tgt.getBattlePiece().showHeal( power );
				//heal with the range of you + your teammates
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}