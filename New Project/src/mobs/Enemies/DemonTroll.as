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
	
	public class DemonTroll extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/ghoul.png")]
		public var img:Class;
		
		public function DemonTroll()
		{
			super("Troll");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 35, "wisdom": 35, "dexterity": 30, "constitution": 20}
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
			brainTicking("practical", field, player, allies)
		}
	
	}

}