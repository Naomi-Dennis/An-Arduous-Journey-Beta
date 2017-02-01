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
	
	public class Ogres extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/ogre.png")]
		public var img:Class;
		
		public function Ogres()
		{
			super("Ogre");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 15, "wisdom": 0, "dexterity": 0, "constitution": 10}
			setStatus(newStats);
			setMaxHp(32)
			hp = maxHp;
			equip(new Club());
			inventory.addItem(new HealthPotion());
			addAction(new StunStrike());
			addAction(new SingleStrike());
		
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