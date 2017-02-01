package skills
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	public class DoubleShot extends Skill
	{
		[Embed(source = "../pics/skills icon/double shot.png")]
		private var imgClass:Class;
		[Embed(source = "../snd/Single - Double - Triple Strike.mp3")]
		private var sound:Class;
		private var tgt:Mob;
		private var times:int = 0;
		private var dmg:int = 0;
		private var interval:uint = 0;
		private var n:int = 0;
		
		public function DoubleShot()
		{
			super("Double Shot", 3, 1, "\nShoot the enemy twice!");
			
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 5;
			rangeShape = "line";
		}
		
		public override function perform(_tgt:Mob):String
		{
			tgt = _tgt;
			Main.sndConfig.playSound(sound);
			var tax:int = 0;
			owner.getBattlePiece().showAttackCry("Double Shot");
			if (owner.getAp() >= ap && tgt != null)
			{
				times = 0;
				triggerCooldown();
				var stats:Object = owner.getStatus();
				tax = ap * -1;
				dmg = stats.dexterity * (0.75);
				owner.changeAp(tax);
				//	owner.getBattlePiece().addEventListener(Event.ENTER_FRAME, processAction);
				takeShots()
			}
			else if (tgt == null)
			{
				tax = ap * -1;
				owner.changeAp(tax);
				triggerCooldown()
			}
			return "";
		}
		
		private function takeShots():void
		{
			if (n < 2)
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