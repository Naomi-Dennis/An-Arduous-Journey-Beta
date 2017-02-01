package skills 
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class LifeSteal extends Skill
	{
		[Embed(source="../pics/skills icon/life steal.png")]
		private var img:Class; 
		public function LifeSteal() 
		{
			super("Life Steal", 4, 3, "\nSteal an enemy's hp!");
			var ico:Sprite = new Sprite();
			ico.addChild( ConvertEmbedToSprite(img) );
			changeIcon(ico);
			range = 4; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Life Steal");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:int = (tgt.getMaxHp() * (0.15 )) + (stats.wisdom * (0.30))
				tgt.changeHp( dmg * -1 );
				owner.changeHp( dmg )
				owner.getBattlePiece().showHeal(dmg);
				tgt.getBattlePiece().showDamage( dmg ); 
				
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
		
	}

}