package mobs.CampaignEnemies 
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite; 
	import skills.*;
	import items.*;
	public class SquireSwordsman extends Enemy
	{
		[Embed(source = "images/SquireWarrior.png")]
		public var img:Class; 
		public function SquireSwordsman() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":9,
				"defense":10,
				"wisdom":4,
				"dexterity":2,
				"constitution":0
			}
			setStatus(newStats);
			setMaxHp(30); 
			hp = maxHp; 
			addAction(new SingleStrike());
			addAction(new DefensiveStance());
			addAction(new HealthPotion()); 
			addAction(new StrengthPotion()); 
		}
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
		
		}
	}

}