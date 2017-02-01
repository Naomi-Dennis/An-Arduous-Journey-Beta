package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	import flash.display.Sprite; 
	public function RemoveSprite(win:*):void
	{
		if(win != null){
			(win.parent != null ) ? win.parent.removeChild(win) : null; 
		}
	}

}