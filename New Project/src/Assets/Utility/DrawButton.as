package Assets.Utility
{
	import Assets.Effects.DropShadow;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function DrawButton(content:String, size:int=12):Sprite
	{
		
		//creates a new button and returns it. The button glows when the mouse is over it
		var btn:Sprite = new Sprite();
		btn.name = content;
		btn.addChild(DrawText(content, size));
		btn.addEventListener(MouseEvent.ROLL_OVER, contourGlow);
		btn.addEventListener(MouseEvent.ROLL_OUT, removeFilters);
		btn.addEventListener(MouseEvent.ROLL_OVER, btnSound);
		DropShadow(btn);
		function contourGlow(e:MouseEvent):void {
			RemoveFilters(btn);
			GlowObj(btn, 0xffdd00); 
			
			
		}
		function removeFilters(e:MouseEvent):void {
			RemoveFilters(btn); 
			DropShadow(btn);
		}
		function btnSound(e:MouseEvent):void {
			SndLib.playButtonClick();
		}
		return btn;
	}

}