package mobs.Enemies
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.weapon.Katana;
	import skills.*;
	import items.*;
	
	public class OrcKnight extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/orc_knight.png")]
		public var img:Class;
		
		public function OrcKnight()
		{
			super("Orc");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 25, "wisdom": 0, "dexterity": 25, "constitution": 10}
			setStatus(newStats);
			setMaxHp(60)
			hp = maxHp;
			equip(new Katana());
			addAction(new LowerDefense());
			addAction(new DoubleStrike());
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