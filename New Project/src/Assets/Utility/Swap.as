package Assets.Utility 
{
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public function Swap(array:Array, posA:int, posB:int):void
	{
		var temp:Object = array[posA];
		array[posA] = array[posB];
		array[posB] = temp;
	}


}