package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class IceAttack extends Skill
	{
		[Embed(source = "../pics/skills icon/ice attack.png")]
		private var imgClass:Class; 
		public function IceAttack() 
		{
			super("Ice Attack", 4, 3, "Duration: 3 turns\nDoesn't stack, can be reset\n\nSend a flurry of ice shards at an enemy!\n50% chance to freeze");
	
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Ice Attack");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:Number = stats.wisdom * (0.75); 
				if (owner.isNextAttackCritical()) {
						dmg *= 2;
						owner.deactivateAutoCrit();
				}
				tgt.getBattlePiece().getCellLocation().setFrozenState();
				tgt.changeHp( dmg * -1, "magic"); 
				tgt.getBattlePiece().showDamage( dmg  ); 
				tgt.processAfflictions(0, 3, "frozen");
				tgt.getBattlePiece().showFrozen();
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}