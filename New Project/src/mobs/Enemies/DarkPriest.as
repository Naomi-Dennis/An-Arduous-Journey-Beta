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
	
	public class DarkPriest extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/Dark Priest.png")]
		public var img:Class;
		
		public function DarkPriest()
		{
			super("Priest");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 10, "defense": 10, "wisdom": 45, "dexterity": 0, "constitution": 10}
			setStatus(newStats);
			setMaxHp(45)
			hp = maxHp;
			addAction(new StunStrike());
			addAction(new AirStrike());
			inventory.addItem(new HealthPotion());
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
			 * Basic AI - Go after the closest player
			 * */
			brainTicking("practical", field, player, allies)
		}
	}

}