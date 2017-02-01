package mobs.CampaignEnemies 
{
	import Assets.Utility.ConvertEmbedToSprite;
	import flash.utils.setTimeout;
	import items.armor.BlueCape;
	import items.armor.BrownPants;
	import items.HealthPotion;
	import items.weapon.Bow;
	import items.weapon.Club;
	import items.weapon.Katana;
	import skills.Fear;
	import skills.LowerConsitution;
	import skills.SingleShot;
	import skills.SingleStrike;
	import Assets.Utility.AddSound;
	
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class Skeleton extends Enemy
	{
		[Embed(source="images/skeleton_humanoid_small.png")]
		public var img:Class; 
		public function Skeleton() 
		{
			super("Skeleton");
			setCustomBattlePiece(ConvertEmbedToSprite(img)); 
			var newStatus:Object = {
				"strength":22,
				"defense":2,
				"consitution":15,
				"wisdom":2,
				"dexterity":2
			}
			
			mp = maxMp;
			var lowerConst:LowerConsitution = new LowerConsitution();
			var singleStrike:SingleStrike = new SingleStrike();
			
			singleStrike.setOwner(this);
			lowerConst.setOwner(this); 
			addAction(new Fear());
			addAction(new SingleStrike());
			inventory.addItem(new HealthPotion()); 
			equip(new Club());
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