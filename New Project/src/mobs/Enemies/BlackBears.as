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
	
	public class BlackBears extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/blackBear.png")]
		public var img:Class;
		
		public function BlackBears()
		{
			super("Bear");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 20, "defense": 15, "wisdom": 0, "dexterity": 0, "constitution": 0}
			setStatus(newStats);
			setMaxHp(32)
			hp = maxHp;
			addAction(new SingleStrike());
			addAction(new Rage());
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