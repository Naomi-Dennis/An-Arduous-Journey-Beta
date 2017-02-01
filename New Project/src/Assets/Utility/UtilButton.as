package Assets.Utility
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class UtilButton extends Sprite
	{
		public function UtilButton(content:String, size:int=12)
		{
			
			name = content;
			addChild(DrawText(content, size));
			enable();
		}
		private function contourGlow(e:MouseEvent):void {
			GlowObj(this, 0xffdd00); 
		}
		private function removeFilters(e:MouseEvent):void {
			RemoveFilters(this); 
		}
		public function disable():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, contourGlow);
			this.removeEventListener(MouseEvent.ROLL_OUT, removeFilters);
			this.removeEventListener(MouseEvent.ROLL_OVER, btnSound);
			RemoveFilters(this); 
			alpha = 0.5; 	
		}
		public function enable():void {
			this.addEventListener(MouseEvent.ROLL_OVER, contourGlow);
			this.addEventListener(MouseEvent.ROLL_OUT, removeFilters);
			this.addEventListener(MouseEvent.ROLL_OVER, btnSound);
			alpha = 1; 
		
		}
		private function btnSound(e:MouseEvent):void {
			//	Sounds.button();
		}
	
	}

}