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
	
	public class Donald extends Enemy
	{
		[Embed(source="../CampaignEnemies/images/donald.png")]
		public var img:Class;
		
		public function Donald()
		{ 
			super("Donald");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 3, "defense": 23, "wisdom": 0, "dexterity": 0, "constitution": 23}
			
			setStatus(newStats);
			setMaxHp(23)
			hp = maxHp;
			addAction(new DoubleStrike());
			setName("Donald");
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
			 * Basic AI - Go after the closest player
			 * */
			brainTicking("spartan", field, player, allies) 
		
		}
	
	}

}