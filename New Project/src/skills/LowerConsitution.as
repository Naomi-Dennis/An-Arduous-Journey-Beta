package skills 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	public class LowerConsitution extends Skill
	{
		[Embed(source = "../pics/skills icon/lower consitution.png")]
		private var imgClass:Class; 
		[Embed(source = "../snd/Power Down.mp3")]
		private var sound:Class; 
		public function LowerConsitution() 
		{
			super("Weaken", 3, 10, "\nLowers the opponent's consitution!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7; 
			rangeShape = "line"; 
		}
		public override function perform(tgt:Mob):String {
			var tax:int = this.ap * -1; 
			owner.getBattlePiece().showAttackCry("Weaken");
			Main.sndConfig.playSound(sound);
			if (owner.getAp() >= ap && tgt != null) {
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				var dmg:Number = (stats.wisdom * (0.25)); 
				var cons:Number =  tgt.getStatus().consitution - dmg; 
				//	tgt.changeAttr("defense", dmg); 
				//temporarily change consitution temporarily
				tgt.tempStatusChange("lower constitution", cons, 7);
				tgt.getBattlePiece().showPowerDown("constitution");
				tgt.getBattlePiece().addEffect("constitution down");
			}
			else if (tgt == null) {
				owner.changeAp( tax ); 
				triggerCooldown()
			}
			return "";
		}
	}

}