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
	
	public class Devil extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/devilBoss.png")]
		public var img:Class;
		
		public function Devil()
		{
			super("Devil");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 25, "wisdom": 25, "dexterity": 30, "constitution": 30}
			setStatus(newStats);
			setMaxHp(100)
			hp = maxHp;
			addAction(new TripleStrike());
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