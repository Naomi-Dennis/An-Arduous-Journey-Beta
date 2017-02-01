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
	
	public class SoldierSwordsman extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/soldier swordsman.png")]
		public var img:Class;
		
		public function SoldierSwordsman()
		{
			super("Soldier");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 15, "defense": 25, "wisdom": 0, "dexterity": 0, "constitution": 15}
			setStatus(newStats);
			setMaxHp(60)
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