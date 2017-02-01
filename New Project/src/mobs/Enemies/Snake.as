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
	
	public class Snake extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/snake.png")]
		public var img:Class;
		public function Snake()
		{
			super("Snake");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 3, "defense": 6, "wisdom": 0, "dexterity": 0, "constitution": 1}
			setStatus(newStats);
			setMaxHp(15)
			hp = maxHp;
			addAction(new Poison());
			addAction(new SingleStrike());
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