package Assets.Utility 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
		public function PlaceObjNextTo(objToPlace:*, relativeObj:*, c:int=10):void 
		{
			objToPlace.x = relativeObj.x + relativeObj.width + c
		}

}