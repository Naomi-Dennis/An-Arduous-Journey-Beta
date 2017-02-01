package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class Resurrect extends Skill
	{
		[Embed(source = "../pics/skills icon/resurrect.png")]
		private var imgClass:Class; 
		public function Resurrect() 
		{
			super("Resurrect", 6, 10, "Bring a teammate back from the dead.");
	
		var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 10; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				//access the graveyard, 
				//open a menu
				//show the dead teammates
				//allow 1 to be taken 
				//place them on the field
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}