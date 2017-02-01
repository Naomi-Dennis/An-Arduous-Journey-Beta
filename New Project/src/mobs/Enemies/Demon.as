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
	
	public class Demon extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/demon.png")]
		public var img:Class;
		
		public function Demon()
		{
			super("Demon");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 40, "defense": 40, "wisdom": 40, "dexterity": 40, "constitution": 30}
			setStatus(newStats);
			setMaxHp(70)
			hp = maxHp;
			addAction(new Fear());
			addAction(new Rage());
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