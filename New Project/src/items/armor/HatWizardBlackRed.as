package items.armor 
{
	/**
	 * ...
	 * @author lk
	 */
	import Assets.Item;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	public class HatWizardBlackRed  extends Item
	{
		[Embed(source = "../clothing_hair/wizard_blackred.png")]
		private var mv:Class; 
		[Embed(source = "../clothing_hair/wizard_blackred_ico.png")]
		private var icoClass:Class; 
		public function HatWizardBlackRed() 
		{
			var ico:Sprite = new Sprite();
			setIcon(ico);
			super("BlackishRed Wizard Hat", 0, 1, "A wizard's hat.", "armor", true);
			setMobVersion(mv);
			setIcon(ConvertEmbedToSprite(icoClass));
		}
		public function equipMe(tgt:Mob):void {
			tgt.getMobIcon().equip(this); 
		}
		
	}

}