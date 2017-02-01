package skills 
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class StrongAttack  extends Skill
	{
		[Embed(source="../pics/skills icon/strong attack.png")]
		private var img:Class;
		public function StrongAttack() 
		{
			super("Strong Attack", 6, 6, "\nGather all your strength and strike your opponent with double your strength!");
			var ico:Sprite = new Sprite();
			ico.addChild( ConvertEmbedToSprite(img) );
			changeIcon(ico);
			range = 1; 
			rangeShape = "von"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:int = stats.strength * 2;
				tgt.changeHp( dmg, "physical", owner.nextAttackIsArmorPierce() ); 
				tgt.getBattlePiece().showDamage( dmg ); 
				owner.getBattlePiece().showAttackCry("Strong Attack");
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
		
	}

}