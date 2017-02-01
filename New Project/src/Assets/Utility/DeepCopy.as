package Assets.Utility
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	 * Creates a deep copy of any object via byte array copy. 
	 */
	public function DeepCopy(original:*, classObjName:Class, alias:String=""):*
	{
		registerClassAlias(alias, classObjName);
		var ba:ByteArray = new ByteArray();
		ba.writeObject(original);
		ba.position = 0;
		var copy:* = ba.readObject() as classObjName;
		return copy;
	}

}