package skills 
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Haste  extends Skill
	{
		[Embed(source = "../pics/skills icon/haste.png")]
		private var img:Class; 
		public function Haste() 
		{
			super("Haste", 2, 6, "Duration: 3 turns\nDoesn't stack, can be reset\n\nIncrease your AP by 3!");
			var ico:Sprite = new Sprite();
			changeIcon(ConvertEmbedToSprite(img));
			range = 1; 
			rangeShape = "self"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				owner.getBattlePiece().showAttackCry("*Hastened*", 0x0000FF)
				tgt.processAfflictions(3, 3, "ap up");
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
		
	}

}