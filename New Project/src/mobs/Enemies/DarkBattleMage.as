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
	
	public class DarkBattleMage extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/Dark Battle Mage.png")]
		public var img:Class;
		
		public function DarkBattleMage()
		{
			super("Battle Mage");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 10, "defense": 10, "wisdom": 30, "dexterity": 0, "constitution": 10}
			setStatus(newStats);
			setMaxHp(45)
			hp = maxHp;
			addAction(new SingleStrike());
			addAction(new AirStrike());
			addAction(new FireStrike());
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