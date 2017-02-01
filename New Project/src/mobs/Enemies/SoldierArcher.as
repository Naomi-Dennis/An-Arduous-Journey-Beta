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
	
	public class SoldierArcher extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/soldier archer.png")]
		public var img:Class;
		
		public function SoldierArcher()
		{
			super("Soldier");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 0, "defense": 25, "wisdom": 0, "dexterity": 40, "constitution": 10}
			setStatus(newStats);
			setMaxHp(60)
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