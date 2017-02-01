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
	
	public class RottingDemon extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/rotting_hulk.png")]
		public var img:Class;
		
		public function RottingDemon()
		{
			super("Zombie");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 22, "defense": 7, "wisdom": 4, "dexterity": 0, "constitution": 0}
			setStatus(newStats);
			setMaxHp(40)
			hp = maxHp;
			addAction(new Poison());
			addAction(new SingleStrike());
			inventory.addItem(new HealthPotion());
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