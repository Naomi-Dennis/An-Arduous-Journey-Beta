package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	
	public function CenterObjRelTo(objToPlace:*, relObj:*):void
	{
		objToPlace.x =  Math.abs((relObj.width / 2) - (objToPlace.width / 2)) + relObj.x;
	}

}