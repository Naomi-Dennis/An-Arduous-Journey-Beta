package Assets.Utility 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
		public function DrawText(str:String, size:int=12, align:String="left", tFont:String="rainyhearts") :TextField
		{
			var tf:TextFormat = StandardTextFormat(size, align, tFont); 
			var textField:TextField = new TextField();
			textField.embedFonts = true;
			textField.defaultTextFormat = tf; 
			textField.text = str; 
			textField.selectable = false;
			var metrics:TextLineMetrics = textField.getLineMetrics(0);
			textField.height = metrics.height + 5;
			textField.width = metrics.width + 5;
			return textField; 
		}
}