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
	
	public class Alligator extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/alligator.png")]
		public var img:Class;
		
		public function Alligator()
		{
			super("Alligator");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 15, "defense": 23, "wisdom": 0, "dexterity": 0, "constitution": 23}
			
			setStatus(newStats);
			setMaxHp(75)
			hp = maxHp;
			addAction(new SingleStrike());
			addAction(new BleedingHeart());
			setName("Alligator");
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