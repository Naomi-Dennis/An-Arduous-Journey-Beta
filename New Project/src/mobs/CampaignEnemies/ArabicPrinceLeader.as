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
	public class ArabicPrinceLeader extends Enemy
	{
		[Embed(source = "images/ArabicPrinceLeader.png")]
		public var img:Class;
		public function ArabicPrinceLeader() 
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