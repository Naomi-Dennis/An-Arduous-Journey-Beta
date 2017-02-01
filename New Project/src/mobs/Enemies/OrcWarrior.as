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
	
	public class OrcWarrior extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/orc_knight.png")]
		public var img:Class;
		
		public function OrcWarrior()
		{
			super("Orc");
			icon.setNewBase(ConvertEmbedToSprite(img));
			setBattlePiece()
			var newStats:Object = {"strength": 25, "defense": 10, "wisdom": 0, "dexterity": 15, "constitution": 10}
			setStatus(newStats);
			setMaxHp(40)
			hp = maxHp;
			equip(new Katana());
			inventory.addItem(new HealthPotion());
			addAction(new DefensiveStance());
			addAction(new LowerDefense());
			addAction(new SingleStrike());
		
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