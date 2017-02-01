package mobs.Enemies 
{
	/**
	 * ...
	 * @author lk
	 */
import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import skills.*;
	import items.*;
	
	public class Door extends Enemy
	{
		[Embed(source="../CampaignEnemies/images/dngn_closed_door.png")]
		public var img:Class;
		public function Door()
		{
			super("door");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 3, "defense": 23, "wisdom": 0, "dexterity": 0, "constitution": 23}
			
			setStatus(newStats);
			setMaxHp(23)
			hp = maxHp;
			setName("door");
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
			 * Basic AI - It's a door
			 * */
		}
	}

}