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
	
	public class TripleShot extends Skill
	{
		[Embed(source = "../pics/skills icon/triple shot.png")]
		private var imgClass:Class;
		[Embed(source = "../snd/Single - Double - Triple Strike.mp3")]
		private var sound:Class;
		private var tgt:Mob;
		private var dmg:int = 0;
		private var times:int = 0;
		private var n:int = 0; 
		private var interval:uint; 
		public function TripleShot()
		{
			super("Triple Shot", 4, 1, "\nShoot three arrows at your opponent!");
			
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			changeIcon(ico);
			range = 7;
			rangeShape = "line";
		}
		
		public override function perform(_tgt:Mob):String
		{
			tgt = _tgt; 
			var tax:int = this.ap * -1;
			Main.sndConfig.playSound(sound);
			owner.getBattlePiece().showAttackCry("Triple Shot");
			if (owner.getAp() >= ap && _tgt != null)
			{
				triggerCooldown();
				var stats:Object = owner.getStatus();
				dmg = stats.dexterity * (0.75) + 1;
				owner.changeAp(tax);
				takeShots();
			}
			else if (_tgt == null)
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