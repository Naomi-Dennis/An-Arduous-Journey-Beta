package skills 
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Fear  extends Skill
	{
		[Embed(source="../pics/skills icon/fear.png")]
		private var img:Class;
		public function Fear() 
		{
			super("Fear", 4, 5, "Duration: 1 turn\nDoesn't stack, can be reset\n\nScare your opponent so badly, they can't move!");
			var ico:Sprite = new Sprite();
			ico.addChild( ConvertEmbedToSprite(img) );
			changeIcon(ico);
			range = 4; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Boo!");
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				tgt.getBattlePiece().showFear();
				tgt.setAffliction("move", 1, 0); 
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
		
	}

}