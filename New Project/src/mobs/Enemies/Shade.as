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
	
	public class Shade extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/soulEater.png")]
		public var img:Class;
		
		public function Shade()
		{
			super("Shade");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 6, "defense": 4, "wisdom": 5, "dexterity": 5, "constitution": 30}
			setStatus(newStats);
			setMaxHp(30)
			hp = maxHp;
			addAction(new LifeSteal());
			addAction(new DoubleStrike());
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
			 * Basic AI - Go after the closest player
			*;
		*/
				brainTicking("practical", field, player, allies)
		}
	
	}

}