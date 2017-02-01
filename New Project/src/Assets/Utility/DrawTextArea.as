package Assets.Utility 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */

	public function DrawTextArea(w:int, h:int, size:int=12, align:String="left", tfont:String="rainyhearts"):TextField 
	{
		var tf:TextField = new TextField();
		tf.embedFonts = true;
		tf.width = w;
		tf.height = h;
		tf.defaultTextFormat = StandardTextFormat(size, align, tfont); 
		tf.selectable = false;
		tf.wordWrap = true; 
		tf.multiline = true; 
		return tf; 
	}
		
}