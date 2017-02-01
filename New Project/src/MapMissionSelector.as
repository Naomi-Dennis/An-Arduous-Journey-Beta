package 
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawText;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.GlowObj;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lk
	 */
	
	public class MapMissionSelector extends Sprite
	{
		[Embed(source = "pics/redOrb.png")]
		private var redOrb:Class; 
		[Embed(source = "pics/greenOrb.png")]
		private var greenOrb:Class; 
		[Embed(source="pics/grayOrb.png")]
		private var grayOrb:Class; 
		[Embed(source="pics/yellowOrb.png")]
		private var yellowOrb:Class;
		[Embed(source = "pics/orangeOrb.png")]
		private var orangeOrb:Class;
		[Embed(source = "pics/purpleOrb.png")]
		private var purpleOrb:Class; 
		private var badArea:Sprite = new Sprite();
		private var goodArea:Sprite = new Sprite(); 
		private var neutralArea:Sprite = new Sprite(); 
		private var yellowArea:Sprite = new Sprite(); 
		private var brownArea:Sprite = new Sprite();
		private var size:Object = { width:12, height:12 }; 
		private var glowColor:Number = 0x000000;
		private var currentOrb:Sprite = new Sprite(); 
		private var purpleArea:Sprite = new Sprite(); 
		public function MapMissionSelector(levelName:String) 
		{
	
			goodArea = ConvertEmbedToSprite(greenOrb)
			badArea = ConvertEmbedToSprite(redOrb); 
			neutralArea = ConvertEmbedToSprite(grayOrb);
			yellowArea = ConvertEmbedToSprite(yellowOrb);
			brownArea = ConvertEmbedToSprite(orangeOrb);
			purpleArea = ConvertEmbedToSprite(purpleOrb);
			showGrayOrb();
			addEventListener(MouseEvent.ROLL_OVER, glowOrb); 
			addEventListener(MouseEvent.ROLL_OUT, stopGlowOrb);
		
		}
		
		public function enable():void {
			addEventListener(MouseEvent.ROLL_OVER, showGreen);
			addEventListener(MouseEvent.ROLL_OUT, showRed);
		}
		public function disable():void {
			removeEventListener(MouseEvent.ROLL_OVER, showGreen);
			removeEventListener(MouseEvent.ROLL_OUT, showRed);
			showGreenOrb();
		
		}
		private function showGreen(e:MouseEvent):void {
			showGreenOrb();
		}
		private function showRed(e:MouseEvent):void {
			showRedOrb();
		}
		public function showGreenOrb():void {
			clearChildren();
			glowColor = 0x81F781;
			currentOrb = goodArea;
			goodArea.width = size.width;
			goodArea.height = size.height; 
			addChild(goodArea);
		}
		public function showGrayOrb():void {
			clearChildren();
			glowColor = 0xFFFFFF;
			currentOrb = neutralArea; 
			neutralArea.width = size.width;
			neutralArea.height = size.height; 
			addChild(neutralArea);
		}
		public function showRedOrb():void {
			clearChildren();
			glowColor = 0xF6CED8; 
			currentOrb = badArea; 
			badArea.width = size.width;
			badArea.height = size.height; 
			addChild(badArea); 
		}
		public function showYellowOrb():void {
			clearChildren();
			glowColor = 0xffdd00; 
			currentOrb = yellowArea; 
			yellowArea.width = size.width;
			yellowArea.height = size.height; 
			addChild(yellowArea); 
		}
		public function showBrownOrb():void {
			clearChildren();
			glowColor = 0x8B4513; 
			currentOrb = brownArea; 
			brownArea.width = size.width;
			brownArea.height = size.height; 
			addChild(brownArea); 
		}
		public function showPurpleOrb():void{
			clearChildren();
			glowColor = 0x8A2BE2; 
			currentOrb = purpleArea; 
			purpleArea.width = size.width;
			purpleArea.height = size.height; 
			addChild(purpleArea);
		}
		private function glowOrb(e:MouseEvent):void {
			GlowObj(currentOrb, glowColor, 6); 
		}
		private function stopGlowOrb(e:MouseEvent):void {	
			RemoveFilters(currentOrb); 
		}
		private function clearChildren():void {
			while (numChildren > 0) {
				RemoveSprite(getChildAt(0)); 
			}
		}
		
	}

}

