package Screens 
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.DrawBorder;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Effects.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveSprite;
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.text.TextField;
     import flash.filters.BitmapFilterQuality;
     import flash.filters.BitmapFilterType;
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class StatsScreen extends Sprite
	{
		public var bkgrnd:Sprite = new Sprite();
		public var owner:Mob = null; 
		public var playerIco:Sprite = DrawSquare(100, 100);
		public var tfStats:TextField = new TextField();
		public var header:TextField = DrawText("Stats", 40); 
		public var inventoryBtn:Sprite = DrawButton("View Inventory", 13); 
		public var skillsBtn:Sprite = DrawButton("View Skills", 13); 
		public var closeBtn:Sprite = DrawButton("Close"); 
		public function StatsScreen(_owner:Mob) 
		{
	
			owner = _owner; 
			// header //
			header.textColor = 0xffdd00; 
			GlowObj(header, 0xffffff);
			header.x = Math.abs(bkgrnd.width / 2 - header.width / 2) + 60
			header.y = 5; 
			//bkgrnd//
			bkgrnd = DrawSquare(300, 270);
			DrawBorder(bkgrnd, 0.1, 0xffffff); 
			// close btn // 
			closeBtn.x = bkgrnd.width - closeBtn.width - 10; 
			closeBtn.y = header.y; 
			//player icon //
			playerIco.x = bkgrnd.width - playerIco.width - 20; 
			PlaceObjBelowRel(playerIco, header); 
			playerIco.y += 10;
			GlowObj(playerIco, 0x000000, 20);
			// stats box //
			tfStats = DrawTextArea(400, 300, 30, "center"); 
			tfStats.x = bkgrnd.width / 2 - tfStats.width / 2; 
			tfStats.y = 40; 
			DropShadow(tfStats);
			// skills btn //
			skillsBtn.y = bkgrnd.height - inventoryBtn.height - 10; 
			skillsBtn.x = 180;
			// inventory btn //
			inventoryBtn.y = bkgrnd.height - inventoryBtn.height - 10; 
			inventoryBtn.x = 40; 
			//add children //
			addChild(bkgrnd); 
			//addChild(playerIco); 
			addChild(tfStats);
			addChild(header);
			//addChild(inventoryBtn);
			//addChild(skillsBtn);
			addChild(closeBtn);
			//initial stats // 
			addEventListener(Event.ENTER_FRAME, loadStats);
			closeBtn.addEventListener(MouseEvent.CLICK, closeHandle); 
			
		}
		
		public function closeHandle(e:MouseEvent):void {
			RemoveSprite(this); 
		}
		public function loadStats(e:Event):void {
			/*
			 *  "strength":0, 
				"constitution":0,
				"wisdom":0, 
				"intelligence":0, 
				"defense":0
			 * */
			var stats:Object = owner.getStatus(); 
			var str:String = "";
			str += "\nName: " + owner.getName() + "\n"; 
			str += "Hp: " + (owner.getHp() / owner.getMaxHp() * 100).toString() + "%\n"; 
			str += "Gold: " + owner.getGold() + "gp\n";
			str += "Str: " + stats.strength.toString() + "\n";
			str += "Def: " + stats.defense.toString() + "\n"; 
			str += "Wisdom: " + stats.constitution.toString() + "\n";
			tfStats.text = str;
		}
		
		
		
	}

}