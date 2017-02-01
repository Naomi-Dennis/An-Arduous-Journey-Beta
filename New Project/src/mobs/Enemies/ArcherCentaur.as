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
	
	public class ArcherCentaur extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/centaur.png")]
		public var img:Class;
		
		public function ArcherCentaur()
		{
			super("Centaur");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 20, "defense": 20, "wisdom": 20, "dexterity": 35, "constitution": 10}
			increaseMovementBy(3, 999)
			setStatus(newStats);
			setMaxHp(250)
			hp = maxHp;
			addAction(new DoubleShot());
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