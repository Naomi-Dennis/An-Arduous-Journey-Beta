package items 
{
	import Assets.Item;
	import Assets.Utility.DrawText;
	import flash.display.Sprite;
	import Assets.Utility.ConvertEmbedToSprite;
	/**
	 * ...
	 * @author lk
	 */
	public class MysteriousKey extends Item
	{
		[Embed(source = "pics/key.png")]
		private var imgClass:Class 
		public function MysteriousKey() 
		{
			var ico:Sprite = ConvertEmbedToSprite(imgClass);
			setIcon(ico); 
			super("Key", 0, 0, "A mysterious key."); 
		}
		
	}

}