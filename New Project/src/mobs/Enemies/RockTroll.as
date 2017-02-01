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
	
	public class RockTroll extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/rock_troll.png")]
		public var img:Class;
		
		public function RockTroll()
		{
			super("Troll");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 30, "defense": 20, "wisdom": 0, "dexterity": 0, "constitution": 20}
			setStatus(newStats);
			setMaxHp(50)
			hp = maxHp;
			addAction(new SingleStrike());
			addAction(new StrongAttack());
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