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
	public class ArabicPrinceWarrior extends Enemy 
	{
		[Embed(source = "images/ArabicPrinceWarrior.png")]
		public var img:Class;
		public function ArabicPrinceWarrior() 
		{
			setBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":0,
				"defense":0,
				"wisdom":0,
				"dexterity":0,
				"constitution":0
			}
			setStatus(newStats);
			setMaxHp(0); 
			hp = maxHp; 
		}
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
			
		}
		
	}

}