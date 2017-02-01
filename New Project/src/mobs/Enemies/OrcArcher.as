package mobs.Enemies
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import items.weapon.Bow;
	import skills.*;
	import items.*;
	
	public class OrcArcher extends Enemy
	{
		[Embed(source = "../CampaignEnemies/images/orc.png")]
		public var img:Class;
		
		public function OrcArcher()
		{
			super("Orc");
			icon.setNewBase(ConvertEmbedToSprite(img));
			setBattlePiece()
			var newStats:Object = {"strength": 15, "defense": 10, "wisdom": 0, "dexterity": 25, "constitution": 30}
			setStatus(newStats);
			setMaxHp(40)
			hp = maxHp;
			equip(new Bow());
			inventory.addItem(new HealthPotion());
			addAction(new SingleShot());
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