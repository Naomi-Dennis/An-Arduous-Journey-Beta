package Assets.Utility
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public function ChangeColor(spr:Sprite, color:Number):void
	{
		var ct:ColorTransform = new ColorTransform(); 
		ct.color = color; 
		spr.transform.colorTransform = ct; 
	}
}