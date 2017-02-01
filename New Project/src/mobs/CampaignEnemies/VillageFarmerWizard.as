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
	import items.armor.BrownRobe;
	import items.armor.HatStraw;
	import items.weapon.Staff;
	import items.weapon.StaffAnucis;
	public class VillageFarmerWizard extends Enemy
	{
		[Embed(source="images/VillageFarmerWizard.png")]
		public var img:Class;
		public function VillageFarmerWizard()
		{
			super("Farmer");
			var newStats:Object = {"strength": 23 , "defense": 10, "wisdom": 23, "dexterity": 0, "constitution": 23}
			
			setStatus(newStats);
			setMaxHp(23)
			hp = maxHp;
			setName("Farmer");
			equip(new HatStraw());
			equip(new BrownRobe());
			equip(new Staff());
			status.wisdom -= weapon.getPower();
			addAction(new SingleStrike());
			addAction(new FireStrike());
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