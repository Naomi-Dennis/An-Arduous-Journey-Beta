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
	
	public class Wolf extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/wolf.png")]
		public var img:Class;
		
		public function Wolf()
		{
			super("Wolf");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 15, "defense": 15, "wisdom": 0, "dexterity": 0, "constitution": 1}
			setStatus(newStats);
			setMaxHp(60)
			mp = 5;
			hp = maxHp;
			
			addAction(new StrongAttack());
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