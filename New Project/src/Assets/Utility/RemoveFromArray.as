package Assets.Utility 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public function RemoveFromArray(array:Array, obj:*):void
	{
		for (var i:* in array) {
			if (obj == array[i]) {
				(i == 0) ? array.splice(0, 1) : array.splice(i, 1); 
				return; 
			}
		}
	}
}