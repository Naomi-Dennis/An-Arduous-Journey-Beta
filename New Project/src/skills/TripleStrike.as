package skills
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	public class TripleStrike extends Skill
	{
		[Embed(source = "../pics/skills icon/double strike.png")]
		private var imgClass:Class;
		[Embed(source = "../snd/Single - Double - Triple Strike.mp3")]
		private var sound:Class;
		private var tgt:Mob;
		private var dmg:int = 0;
		private var times:int = 0
		private var n:int = 0;
		public var interval:uint = 0;
		
		public function TripleStrike()
		{
			super("Triple Strike", 4, 1, "\nStrike the opponent three times!");
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 1;
			rangeShape = "von";
		}
		
		public override function perform(_tgt:Mob):String
		{
			tgt = _tgt;
			var tax:int = this.ap * -1;
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Triple Strike");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				owner.changeAp(tax);
				dmg = (stats.strength)
				//owner.getBattlePiece().addEventListener(Event.ENTER_FRAME, processAction);
				takeShots();
			}
			else if (tgt == null)
			{
				owner.changeAp(tax);
				triggerCooldown()
			}
			return "";
		}
		
		private function takeShots():void
		{
			if (n < 3)
			{
				if (owner.isNextAttackCritical())
				{
					dmg *= 2;
					owner.deactivateAutoCrit();
				}
				tgt.changeHp(dmg * -1, "physical", owner.nextAttackIsArmorPierce());
				tgt.getBattlePiece().showDamage(dmg);
				n++;
				setTimeout(takeShots, 600);
			}
			else
			{
				n = 0;
				if (callback != null)
				{
					callback();
				}
			}
			times++;
		}
	}
}