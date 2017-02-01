package mobs.Enemies
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite; 
	import skills.*;
	import items.*;
	public class EnemyTemplate extends Enemy
	{
		//Embedded Code
		public var img:Class; 
		public function EnemyTemplate() 
		{
			
			//OR setBttlePiece() //uses the mobIcon instead
			setCustomBattlePiece(ConvertEmbedToSprite(img)); 
			var newStats:Object = {
				"strength":0,
				"defense":0,
				"wisdom":0,
				"dexterity":0,
				"constitution":0
			}
			setStatus(newStats);
			setMaxHp(000) 
			hp = maxHp; 
		//	addAction(ACTION);
		//	inventory.addItem(ITEM);
		}
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
						Refer to AI Notes, to choose an AI. 
			* */

		}
	}

}