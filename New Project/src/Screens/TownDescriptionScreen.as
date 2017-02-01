package Screens
{
	
	import Screens.ScreenBackground;
	import flash.display.Sprite;
	import Assets.Utility.*;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TownDescriptionScreen extends Sprite
	{
		private var bkgrnd:ScreenBackground = new ScreenBackground({width: 250, height: 250}, 0x000000, 0xffffff);
		private var txtField:TextField = DrawTextArea(240, 240, 15, "center");
		private var icon:Sprite = new Sprite();
		[Embed(source = "../pics/tab_label_memorise.png")]
		private var defaultClass:Class; 
		private var overshadow:Sprite = DrawSquare(540, 540); 
		public function TownDescriptionScreen(_icon:Sprite=null, desc:String="")
		{
			
			icon = _icon;
			if (icon == null){
				icon = ConvertEmbedToSprite(defaultClass);
			}
			icon.width *= 2;
			icon.height *= 2;
			txtField.text = desc;
			overshadow.alpha = 0.2; 
			CenterObjRelTo(txtField, bkgrnd);
			PlaceObjBelowRel(txtField, icon, 30);
			txtField.y += 3;
			txtField.text = desc;
			
			CenterObjRelTo(icon, bkgrnd);
			icon.y = 20;
			
			
			var closeBtn:Sprite = DrawButton("Close", 15);
			CenterObjRelTo(closeBtn, bkgrnd);
			closeBtn.y = (bkgrnd.y + bkgrnd.height) - closeBtn.height - 10;
			//addChild(overshadow);
			addChild(bkgrnd);
			addChild(txtField);
			addChild(icon);
			addChild(closeBtn);
			
			closeBtn.addEventListener(MouseEvent.CLICK, closeWin);
		
		}
		
		private function closeWin(e:MouseEvent):void
		{
			RemoveSprite(this);
		}
	}

}