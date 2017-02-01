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
	
	public class MeleeCentaur extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/centaur_warrior.png")]
		public var img:Class;
		
		public function MeleeCentaur()
		{
			super("Centuar");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 35, "defense": 30, "wisdom": 0, "dexterity": 30, "constitution": 10}
			setStatus(newStats);
			increaseMovementBy(2, 999)
			setMaxHp(200)
			hp = maxHp;
			addAction(new DoubleStrike());
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