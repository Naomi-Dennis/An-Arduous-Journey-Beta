package mobs.Players 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import items.*;
	import items.armor.BrownPants;
	import items.armor.BrownShoes;
	import items.armor.Chainmail;
	import items.weapon.OrchishShortSword;
	import items.weapon.SwiftKatana;
	import skills.*;
	/**
	 * ...
	 * @author kljjlk
	 */
	public class SerYork extends Mob
	{
		
		[Embed(source="../CampaignEnemies/images/SerYorkWithArmor.png")]
		private var img:Class;
		[Embed(source = "../../long blonde hair.png")]
		private var hair:Class; 
		public function SerYork() 
		{
			name = "SerYork";
			icon.setHair(ConvertEmbedToSprite(hair));
			equip(new Chainmail());
			equip(new BrownPants());
			equip(new BrownShoes());
			equip(new SwiftKatana());
			setBattlePiece();
		}
		public function setLevel():void {
			this.clearStats();
			var newStatus:Object = {
				"defense":4,
				"strength":6,
				"wisdom":0,
				"constitution":20,
				"dexterity": 1
			}
			setStatus(newStatus);
			setMaxHp(50);
			var parry:Parry = new Parry();
			parry.setOwner(this);
			var singleStrike:DoubleStrike = new DoubleStrike()
			singleStrike.setOwner(this); 
			var hpPot:HealthPotion = new HealthPotion();
			hpPot.setOwner(this);
			var bleedingHeart:BleedingHeart = new BleedingHeart();
			bleedingHeart.setOwner(this);
			aQuickSlots = [hpPot, singleStrike, parry]; 
		}
		
	}

}