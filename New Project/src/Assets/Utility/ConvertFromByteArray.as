package Assets.Utility 
{
	import flash.events.DataEvent;
	import flash.utils.ByteArray;
	import flash.display.Sprite; 
	/**
	 * ...
	 * @author Naomi J Dennis
	 */

		/**
		 * ONLY USE THIS FOR PRIMITIVES! 
		 * @param ba the byte array
		 * @param datatype the actual class object
		 * */
		public function ConvertFromByteArray(ba:ByteArray, dataType:Class):*
		{
			ba.position = 0;
			var newObject:* = ba.readObject() as dataType; 
			return newObject;
		}
		

}