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
	
	public class OrcWarlord extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/orc_warlord.png")]
		public var img:Class;
		
		public function OrcWarlord()
		{
			super("Orc");
			setCustomBattlePiece(ConvertEmbedToSprite(img));
			var newStats:Object = {"strength": 25, "defense": 35, "wisdom": 0, "dexterity": 25, "constitution": 1}
			setStatus(newStats);
			setMaxHp(60)
			hp = maxHp;
			equip(new Katana());
			
			addAction(new DefensiveStance());
			addAction(new LowerDefense());
			addAction(new Rage());
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