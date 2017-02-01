package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class SkillTemplate extends Skill
	{
		
		public function SkillTemplate() 
		{
			super("SkillName", AP, MAXCOOLDOWN, "SKillDescription");
			var ico:Sprite = new Sprite();
			ico.addChild( DrawText("ACRONYM") );
			changeIcon(ico);
			range =0; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				tgt.changeHp( 0 ); 
				tgt.getBattlePiece().showDamage( 0 ); 
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}