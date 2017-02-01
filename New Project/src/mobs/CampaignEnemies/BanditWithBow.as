package mobs.CampaignEnemies
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.utils.setTimeout;
	import items.armor.BlueCape;
	import items.armor.BluePants;
	import items.armor.BrownPants;
	import items.HealthPotion;
	import items.weapon.Bow;
	import skills.LowerConsitution;
	import skills.SingleShot;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class BanditWithBow extends Enemy
	{
		public function BanditWithBow()
		{
			var newStatus:Object = {"strength": 5, "defense": 1, "consitution": 15, "wisdom": 3, "dexterity": 12}
			setName("Bandit");
			setMaxHp(75)
			setStatus(newStatus);
			maxMp = 3;
			mp = maxMp;
			var singleStrike:SingleShot = new SingleShot();
			singleStrike.setOwner(this);
			actions = [singleStrike];
			inventory.addItem(new HealthPotion());
			equip(new Bow());
			equip(new BrownPants());
			icon.equip(new BlueCape());
			icon.genHair();
			setBattlePiece();
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