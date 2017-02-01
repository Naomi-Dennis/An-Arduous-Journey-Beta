package skills
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.display.Sprite
	import Assets.Utility.DrawText
	import Assets.Utility.ConvertEmbedToSprite;
	
	public class ArmorPiercing extends Skill
	{
		[Embed(source = "../pics/skills icon/armor piercing.png")]
		private var ico:Class;
		public function ArmorPiercing()
		{
			super("Armor Pierce", 1, 6, "\nYour next attack ignores the opponent's armor!");
			var ico:Sprite = ConvertEmbedToSprite(ico);
			changeIcon(ico);
			range = 1;
			rangeShape = "self";
		}
		
		public override function perform(tgt:Mob):String
		{
			var tax:int = this.ap * -1;
			owner.getBattlePiece().showAttackCry("Aaar!!");
			if (owner.getAp() >= ap && tgt != null)
			{
				triggerCooldown();
				var stats:Object =  owner.getStatus(); 
				owner.changeAp( tax ); 
				owner.activateArmorPierce();
				
			}
			else if (tgt == null)
			{
				owner.changeAp(tax);
				triggerCooldown()
			}
			return "";
		}
	
	}

}