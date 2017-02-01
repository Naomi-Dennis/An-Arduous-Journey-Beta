package mobs.Enemies
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.weapon.Club;
	import skills.*;
	import items.*;
	
	public class TwoHeadedOgre extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/two_headed_ogre.png")]
		public var img:Class;
		
		public function TwoHeadedOgre()
		{
			super("Ogre");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 15, "wisdom": 0, "dexterity": 0, "constitution": 10}
			setStatus(newStats);
			setMaxHp(125)
			hp = maxHp;
			equip(new Club());
			addAction(new DoubleStrike());
		}
		
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			/*
			 * Basic AI - Go after the closest player
			 * */
			brainTicking("spartan", field, player, allies) 
		
		}
	}

}