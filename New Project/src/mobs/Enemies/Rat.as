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
	
	public class Rat extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/rat.png")]
		public var img:Class;
		public function Rat()
		{
			super("Rat");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 5, "defense": 3, "wisdom": 3, "dexterity": 3, "constitution": 1}
			
			setStatus(newStats);
			setMaxHp(15)
			hp = maxHp;
			addAction(new SingleStrike());
			setName("Rat");
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