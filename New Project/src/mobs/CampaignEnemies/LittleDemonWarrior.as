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
	public class LittleDemonWarrior extends Enemy
	{
		[Embed(source = "images/LittleDemonWarrior.png")]
		public var img:Class; 
		public function LittleDemonWarrior() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":40,
				"defense":40,
				"wisdom":40,
				"dexterity":40,
				"constitution":20
			}
			setStatus(newStats);
			setMaxHp(0); 
			hp = maxHp; 
			addAction(new Rage());
			addAction(new SingleStrike());
		
		}
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
			
		}
		
	}

}