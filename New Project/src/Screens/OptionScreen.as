package Screens
{
	import Assets.Inventory;
	import Assets.Item;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.CheckBox;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Effects.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.VerticalScrollBar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Screens.TitleScreen;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	 *
	 * Complete 12/6/15
	 *
	
	 */
	public class OptionScreen extends Sprite
	{
		// phenotype //
		public var bkgrnd:Sprite = new Sprite();
		public var header:TextField = new TextField();
		public var closeBtn:Sprite = new Sprite();
		public var saveBtn:Sprite = new Sprite();
		public var menuBtn:Sprite = new Sprite();
		public var musicHeader:TextField = new TextField();
		public var soundHeader:TextField = new TextField();
		public var musicCheckBox:CheckBox = new CheckBox();
		public var sndCheckBox:CheckBox = new CheckBox();
		public var musicSlider:VerticalScrollBar = new VerticalScrollBar();
		public var sndSlider:VerticalScrollBar = new VerticalScrollBar();
		public var ORIG_MUSIC_VOL:Number = 0;
		public var ORIG_SND_VOL:Number = 0;
		
		public function OptionScreen()
		{
			/// set up phenotype 
			bkgrnd = new ScreenBackground({width: 250, height: 200}, 0x777777, 0x444444);
			/// header /// 
			header = DrawText("Options", 20);
			header.textColor = 0xffdd00;
			GlowObj(header, 0xffffff);
			
			header.y = 5;
			header.x = 10;
			// close btn //
			closeBtn = DrawButton("Close");
			closeBtn.x = bkgrnd.width - closeBtn.width - 10;
			closeBtn.y = header.y;
			// music header //
			musicHeader = DrawText("Music", 12);
			PlaceObjBelowRel(musicHeader, header, 10);
			musicHeader.x = 30
			//soundd header // 
			soundHeader = DrawText("Sound", 12);
			soundHeader.y = musicHeader.y;
			soundHeader.x = musicHeader.x + musicHeader.width + 110;
			//sound slider // 
			CenterObjRelTo(sndSlider, soundHeader);
			PlaceObjBelowRel(sndSlider, soundHeader);
			//sound checkbox // 
			sndCheckBox.width -= 5;
			sndCheckBox.height -= 5;
			CenterObjRelTo(sndCheckBox, soundHeader);
			PlaceObjBelowRel(sndCheckBox, sndSlider);
			sndCheckBox.x -= 5;
			//music slider // 
			CenterObjRelTo(musicSlider, musicHeader);
			PlaceObjBelowRel(musicSlider, musicHeader);
			//music checkbox // 
			musicCheckBox.width -= 5;
			musicCheckBox.height -= 5;
			CenterObjRelTo(musicCheckBox, musicHeader);
			PlaceObjBelowRel(musicCheckBox, musicSlider);
			musicCheckBox.x -= 5;
			//save btn //
			saveBtn = DrawButton("Save Game");
			saveBtn.x = musicHeader.x + 55;
			saveBtn.y = 70;
			//menu btn //
			menuBtn = DrawButton("Main Menu");
			CenterObjRelTo(menuBtn, saveBtn);
			PlaceObjBelowRel(menuBtn, saveBtn);
			//add children //
			addChild(bkgrnd);
			addChild(closeBtn);
			addChild(header);
			addChild(menuBtn);
			addChild(musicSlider);
			addChild(sndSlider);
			addChild(sndCheckBox);
			addChild(musicHeader);
			addChild(soundHeader);
			addChild(musicCheckBox);
			
			//event listeners //
			closeBtn.addEventListener(MouseEvent.CLICK, closeHandle);
			menuBtn.addEventListener(MouseEvent.CLICK, mainMenu);
			addEventListener(Event.ENTER_FRAME, sliderControl);
			addEventListener(Event.ENTER_FRAME, sndSliderControl);
			musicCheckBox.addEventListener(MouseEvent.CLICK, musicCheckBoxHandle);
			sndCheckBox.addEventListener(MouseEvent.CLICK, sndCheckBoxHandle);
		}
		
		public function closeHandle(e:MouseEvent):void
		{
			RemoveSprite(this);
		}
		
		//end close handle ///
		public function saveHandle(e:MouseEvent):void
		{
			//call save function 
		}
		
		public function mainMenu(e:MouseEvent):void
		{
			if (this.parent.numChildren > 2)
			{
				while (this.parent.numChildren > 2)
				{
					RemoveSprite(this.parent.getChildAt(this.parent.numChildren - 2));
				}
				this.parent.addChild(new TitleScreen());
			}
			RemoveSprite(this);
		
		}
		
		public function sliderControl(e:Event):void
		{
			Main.musicConfig.adjustSoundVolume(musicSlider.ratio)
		}
		
		public function sndSliderControl(e:Event):void
		{
			Main.sndConfig.adjustSoundVolume(sndSlider.ratio)
		}
		
		public function sndCheckBoxHandle(e:MouseEvent):void
		{
			if (sndCheckBox.checked)
			{
				ORIG_SND_VOL = sndSlider.ratio;
				sndSlider.setPercentage(0);
				Main.sndConfig.adjustSoundVolume(0)
			}
			else
			{
				sndSlider.setPercentage(ORIG_SND_VOL);
				Main.sndConfig.adjustSoundVolume(ORIG_SND_VOL);
			}
		}
		
		public function musicCheckBoxHandle(e:MouseEvent):void
		{
			if (!musicCheckBox.checked)
			{
				ORIG_MUSIC_VOL = musicSlider.ratio;
				Main.musicConfig.adjustSoundVolume(0);
				musicSlider.setPercentage(0);
			}
			else
			{
				musicSlider.setPercentage(ORIG_MUSIC_VOL);
				Main.musicConfig.adjustSoundVolume(ORIG_MUSIC_VOL);
			}
		}
	}
}