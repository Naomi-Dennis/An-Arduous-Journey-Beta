package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.utils.setTimeout;
	import items.armor.BlueCape;
	import items.armor.BrownPants;
	import items.HealthPotion;
	import items.weapon.Bow;
	import items.weapon.Katana;
	import skills.LowerConsitution;
	import skills.SingleShot;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class BanditWithSword extends Enemy
	{
		[Embed(source="images/banditWithSword.png")]
		public var img:Class; 
		public function BanditWithSword() 
		{
			var newStatus:Object = {
				"strength":17,
				"defense":3,
				"consitution":15,
				"wisdom":3,
				"dexterity":3
			}
			setName("Bandit");
			setMaxHp(75)
			setStatus(newStatus);
			maxMp = 3; 
			
			mp = maxMp;
			var singleStrike:SingleStrike = new SingleStrike();
			var lowerConst:LowerConsitution = new LowerConsitution();
			singleStrike.setOwner(this);
			lowerConst.setOwner(this); 
			actions = [singleStrike];
			inventory.addItem(new HealthPotion()); 
			equip(new Katana());
			equip(new BrownPants()); 
			icon.equip(new BlueCape());
			icon.genHair();
			setBattlePiece();
		}
		public override function brainTick(player:Mob, field:Field, allies:Array):void
		{
			brainTicking("practical", field, player, allies)
		}
		
	}

}