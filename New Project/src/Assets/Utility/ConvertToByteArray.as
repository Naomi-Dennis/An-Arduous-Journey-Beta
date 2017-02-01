package Assets.Utility
{
	/**
	 * ...
	 * @author lk
	 */
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	public function ConvertToByteArray(original:*, classObjName:Class, alias:String=""):ByteArray
	{
		registerClassAlias(alias, classObjName);
		var ba:ByteArray = new ByteArray();
		ba.writeObject(original);
		ba.position = 0;
		return ba;
	}

}