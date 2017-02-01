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
	
	public class Troll extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/Troll.png")]
		public var img:Class;
		
		public function Troll()
		{
			super("Troll");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 15, "defense": 0, "wisdom": 10, "dexterity": 0, "constitution": 15}
			setStatus(newStats);
			setMaxHp(50)
			hp = maxHp;
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