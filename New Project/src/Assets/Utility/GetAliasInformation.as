package Assets.Utility
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	   Gets the Alias information of an object. 
	   @return className -- the actual class object (i.e 'Sprite')
	     path -- the string path to the object (i.e. 'flash.display.Sprite');
	 */
	
	public function GetAliasInformation(obj:*):Object
	{
		var qualifiedName:String = getQualifiedClassName(obj);
		var pathStr:String = "";
		var officialClassName:String = "";
		var className:Array = qualifiedName.split("::");
		if (className.length > 1)
		{
			officialClassName = className[1];
			pathStr = className[0];
		}
		else
		{
			officialClassName = qualifiedName;
		}
		
		var clName:Class = getDefinitionByName( pathStr + "." + officialClassName ) as Class; 
		var officialPath:String = pathStr + "." + officialClassName; 
		
		return { className:clName, path:officialPath }; 
	
	}

}