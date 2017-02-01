package Assets.Utility
{
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public function PlaceObjBelowRel(objToPlace:*, relObjToPlace:*, offset:int=10):void
	{
		objToPlace.y = relObjToPlace.y + relObjToPlace.height + offset;
	}

}