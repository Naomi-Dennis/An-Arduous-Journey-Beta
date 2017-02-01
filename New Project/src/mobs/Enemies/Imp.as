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
	
	public class Imp extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/Imp.png")]
		public var img:Class;
		
		public function Imp()
		{
			super("Imp");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 15, "defense": 3, "wisdom": 25, "dexterity": 3, "constitution": 30}
			setStatus(newStats);
			setMaxHp(000)
			hp = maxHp;
			addAction(new Fear());
			addAction(new LifeSteal());
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