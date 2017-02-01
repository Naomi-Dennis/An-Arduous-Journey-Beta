package
{
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Effects.GlowObj;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Screens.*;
	import Assets.Utility.DrawSquare;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class GUI extends Sprite
	{
		// buttons // 
		private var inventoryBtn:Sprite = new RadialButton("Inventory");
		private var optionsBtn:Sprite = new RadialButton("Options");
		// player // 
		private var player:Mob = null;
		// windows // 
		
		private var statsWin:StatsScreen;
		private var optionsWin:OptionScreen;
		// shade //	// shade //
		private var shade:Sprite = DrawSquare(540, 540);
		
		//imbedded images //
		[Embed(source = "pics/status icon.png")]
		private var statsClass:Class;
		[Embed(source = "pics/Inventory Icon.png")]
		private var inventoryClass:Class;
		[Embed(source = "pics/skill icon.png")]
		private var skillClass:Class;
		[Embed(source = "pics/option icon.png")]
		private var optionClass:Class;
		
		public function GUI(_player:Mob)
		{
			inventoryBtn = new SpecialButton(inventoryClass, "Inventory");
			optionsBtn = new SpecialButton(optionClass, "Options");
			player = _player;
			//*** screens ***// 
			// inventory // 
			inventoryBtn.x = 20;
			inventoryBtn.y = 450; 
			
			// options //
			//shade //
			shade.alpha = 0;
			// add children //
			addChild(inventoryBtn);
			addChild(optionsBtn);
			//event listeners // 
		}
		
		private function removeShade(e:Event):void
		{
			(this.contains(shade)) ? removeChild(shade) : null;
		}
		
	
	
	}

}
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.DrawText;
import Assets.Utility.PlaceObjBelowRel;
import Assets.Utility.RemoveSprite;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import Assets.Effects.GlowObj;
import Assets.Utility.RemoveFilters;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.DrawText;
import flash.events.MouseEvent;
import flash.text.TextLineMetrics;

class RadialButton extends Sprite
{
	private var bkgrnd:Sprite = new Sprite();
	private var header:TextField = new TextField();
	
	public function RadialButton(text:String)
	{
		header = DrawText(text);
		bkgrnd.graphics.beginFill(0x444444);
		bkgrnd.graphics.drawCircle(0, 0, 15);
		bkgrnd.graphics.endFill();
		
		header.y = bkgrnd.y - header.height - 15;
		header.x = (bkgrnd.width / 2) - (header.width / 2) - 10;
		addChild(bkgrnd);
		addChild(header);
		addEventListener(MouseEvent.ROLL_OVER, highlight);
		addEventListener(MouseEvent.ROLL_OUT, unHighlight);
	}
	
	private function highlight(e:MouseEvent):void
	{
		GlowObj(this, 0xffffff);
	}
	
	private function unHighlight(e:MouseEvent):void
	{
		RemoveFilters(this);
	}
}

class SpecialButton extends Sprite
{
	[Embed(source = "pics/Button Background State A.png")]
	private var bkgrndStateA:Class;
	[Embed(source = "pics/Button Background State B.png")]
	private var bkgrndStateB:Class;
	private var img:Sprite = new Sprite();
	private var bkgrndImgA:Sprite = new Sprite();
	private var bkgrndImgB:Sprite = new Sprite();
	private var str:String = "";
	private var textField:TextField = new TextField();
	
	public function SpecialButton(imgClass:*, buttonContent:String = "button")
	{
		//initalize variables//
		str = buttonContent;
		//create text field
		textField = DrawText(buttonContent, 13, "center");
		textField.textColor = 0x000000;
		
		//create image icon 
		img = ConvertEmbedToSprite(imgClass);
		img.width = 48;
		img.height = 42;
		//create button background
		bkgrndImgA = ConvertEmbedToSprite(bkgrndStateA);
		bkgrndImgB = ConvertEmbedToSprite(bkgrndStateB);
		//config button state a
		PlaceObjBelowRel(bkgrndImgA, img);
		PlaceObjBelowRel(bkgrndImgB, img);
		
		bkgrndImgA.width = textField.width + 40;
		bkgrndImgA.height = textField.height;
		//config button state b
		bkgrndImgB.x = bkgrndImgA.x;
		bkgrndImgB.y = bkgrndImgA.y;
		
		bkgrndImgB.width = bkgrndImgA.width;
		bkgrndImgB.height = bkgrndImgA.height;
		
		CenterObjRelTo(textField, bkgrndImgA);
		textField.y = (bkgrndImgA.height / 2 - textField.height / 2) + bkgrndImgA.y;
		///var metrics:TextLineMetrics = textField.getLineMetrics(0); 
		CenterObjRelTo(img, bkgrndImgA);
		addEventListener(MouseEvent.ROLL_OVER, onOver);
		addEventListener(MouseEvent.ROLL_OUT, onOut);
		addChild(bkgrndImgA);
		addChild(textField);
		addChild(img);
		
		img.alpha = 0.7;
	}
	
	private function onOver(e:MouseEvent):void
	{
		textField.textColor = 0xffffff;
		GlowObj(this, 0xffffff, 10);
		RemoveSprite(bkgrndImgA);
		addChildAt(bkgrndImgB, 0);
		img.alpha = 1;
	}
	
	private function onOut(e:MouseEvent):void
	{
		textField.textColor = 0x000000;
		RemoveFilters(this);
		img.alpha = 0.7;
		RemoveSprite(bkgrndImgB);
		addChildAt(bkgrndImgA, 0);
	}
}