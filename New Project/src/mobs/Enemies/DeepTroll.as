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
	
	public class DeepTroll extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/darkTroll.png")]
		public var img:Class;
		
		public function DeepTroll()
		{
			super("Troll");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 30, "defense": 15, "wisdom": 0, "dexterity": 30, "constitution": 10}
			setStatus(newStats);
			setMaxHp(60)
			hp = maxHp;
			addAction(new Fear());
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