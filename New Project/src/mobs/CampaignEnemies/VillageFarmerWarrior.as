package mobs.CampaignEnemies
{
	/**
	 * ...
	 * @author kljjlk
	 */
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	import skills.*;
	import items.*;
	import items.armor.BrownPants;
	import items.armor.HatStraw;
	import items.armor.LeatherArmor;
	import items.weapon.Club;
	
	public class VillageFarmerWarrior extends Enemy
	{
		[Embed(source = "images/VillageFarmerWarrior.png")]
		public var img:Class;
		
		public function VillageFarmerWarrior()
		{
			super("Farmer");
			var newStats:Object = {"strength": 23, "defense": 10, "wisdom": 23, "dexterity": 0, "constitution": 23}
			
			setStatus(newStats);
			setMaxHp(23)
			hp = maxHp;
			equip(new BrownPants());
			equip(new HatStraw());
			equip(new LeatherArmor());
			equip(new Club());
			status.strength -= weapon.getPower();
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