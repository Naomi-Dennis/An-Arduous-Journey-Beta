package Screens
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ChangeColor;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.MessageBox;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.PlaceObjNextTo;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import items.armor.RoyalChainmail;
	import mobs.CampaignEnemies.RoyalArcher;
	import mobs.Enemies.Rat;
	 
	import items.armor.*;
	import items.weapon.*;
	import items.*;
	import ProcessLevel;
	
	/**
	 * ...
	 * @author lk
	 */
	public class TownScreen extends Sprite
	{
		[Embed(source = "../pics/backgrounds/Main Game Background.png")]
		public var img:Class;
		public var bkgrnd:Sprite = ConvertEmbedToSprite(img);
		[Embed(source = "../pics/backgrounds/Shop Icon.png")]
		public var shopImg:Class;
		[Embed(source = "../pics/backgrounds/dngn_entrance.png")]
		public var dungeonImg:Class;
		
		public var shopIco:Sprite = new Sprite();
		public var dungeonIco:Sprite = new Sprite();
		public var partyIco:Sprite = new Sprite();
		public var header:TextField = DrawText("Prepare for Battle!", 36, "center");
		public var partyPreview:Sprite = new Sprite();
		public var levels:Array = [];
		public var shop:TravelingSalesman;
		public var overscreen:Sprite = DrawSquare(540, 540);
		public var closeBtn:Sprite = DrawButton("Close", 25); 
		private var processLevels:ProcessLevel = new ProcessLevel();
		public function TownScreen()
		{
			overscreen.alpha = 0.5; 
			var itemSlots:Array = [];
			itemSlots.push({item: new HealthPotion(), value: 200});
			itemSlots.push({item: new Antidote(), value: 500});
			itemSlots.push({item: new DexterityPotion(), value: 500});
			itemSlots.push({item: new WisdomPotion(), value: 500});
			itemSlots.push({item: new Chainmail(), value: 1000});
			itemSlots.push({item: new ElvenScalemail(), value: 3000});
			itemSlots.push({item: new GreenRobe(), value: 2300});
			itemSlots.push({item: new HatStraw(), value: 60});
			itemSlots.push({item: new LeatherArmor(), value: 600});
			itemSlots.push({item: new IronLeggings(), value: 1100});
			itemSlots.push({item: new PlateMail(), value: 2000});
			itemSlots.push({item: new BookBlue(), value: 1000});
			itemSlots.push({item: new BookRed(), value: 3600});
			itemSlots.push({item: new BookBlack(), value: 2000});
			itemSlots.push({item: new BookWhite(), value: 3000});
			itemSlots.push({item: new Crossbow(), value: 2000});
			itemSlots.push({item: new Bow(), value: 1000});
			itemSlots.push({item: new Katana(), value: 3000});
			itemSlots.push({item: new Morningstar(), value: 2000});
			shop = new TravelingSalesman( itemSlots, 100, Main.glblPlayer.inventory);
			
			bkgrnd.width = 540;
			bkgrnd.height = 540;
			
			partyIco = new RoyalChainmail().getIcon();
			addChild(bkgrnd);
			
			shopIco = ConvertEmbedToSprite(shopImg);
			dungeonIco = ConvertEmbedToSprite(dungeonImg);
			
			partyIco.width += 20;
			partyIco.height += 20;
			
			dungeonIco.width += 50;
			dungeonIco.height += 50;
			
			shopIco.width += 50;
			shopIco.height += 50;
			
			CenterObjRelTo(header, bkgrnd);
			header.y = 20;
			
			PlaceObjBelowRel(shopIco, header, 100);
			shopIco.x = 100;
			
			dungeonIco.y = shopIco.y;
			PlaceObjNextTo(dungeonIco, shopIco, 150);
			
			PlaceObjBelowRel(partyIco, dungeonIco, 80);
			CenterObjRelTo(partyIco, bkgrnd);
			
			partyIco.x -= 15;
			
			DropShadow(partyIco);
			
			//setCurrentArmyIcon();
			CenterObjRelTo(partyPreview, bkgrnd);
			partyPreview.y = 540 - partyPreview.height - 30;
			
			CenterObjRelTo(closeBtn, bkgrnd); 
			closeBtn.y = 30; 
			
			addChild(header)
			addChild(shopIco);
			addChild(partyIco);
			addChild(dungeonIco);
			
			
			
			
			
			
		
			partyIco.addEventListener(MouseEvent.CLICK, gotoHanger);
			dungeonIco.addEventListener(MouseEvent.CLICK, gotoDungeonScreen);
			shopIco.addEventListener(MouseEvent.CLICK, gotoShop);
			shopIco.addEventListener(MouseEvent.CLICK, addShop);
			
			addEventListener(Event.ADDED_TO_STAGE, loadingLevels);
			
			
		}
		private function clear():void {
			while (numChildren > 0) {
				removeChild(getChildAt(0));
			}
		}
		private function loadingLevels(e:Event):void {
			processLevels.processLevelData();
			var overshadow:Sprite = DrawSquare(540, 540);
			addChild(overshadow);
			var loadingTf:TextField = DrawText("Loading...", 40, "center");
			loadingTf.x = 540 / 2 - loadingTf.width / 2; 
			loadingTf.y = 540 / 2 - loadingTf.height / 2; 
			addChild(loadingTf);
			var timer:Timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, loadLevelData);
			timer.start();
		}
		private function loadLevelData(e:TimerEvent):void {
			e.currentTarget.reset();
			var lvls:Array = processLevels.aLevels; 
			levels.push(new lvl1(lvls[0]));
			clear();
			loadScreen();
		}
		private function loadScreen():void {
			addChild(bkgrnd);
			
			addChild(header)
			addChild(shopIco);
			addChild(partyIco);
			addChild(dungeonIco);
			
			var functor1:ApplyBtn = new ApplyBtn(shopIco, "Shop");
			var functor2:ApplyBtn = new ApplyBtn(partyIco, "Change Party");
			var functor3:ApplyBtn = new ApplyBtn(dungeonIco, "Next Mission");
		}
		public function addShop(e:MouseEvent):void {
			CenterObjRelTo(shop, bkgrnd); 
			shop.y = (bkgrnd.height / 2 - shop.height / 2)
			addChild(overscreen);
			addChild(shop);
			shop.addEventListener(Event.REMOVED_FROM_STAGE, removeShop);
		}
		public function removeShop(e:Event):void {
			RemoveSprite(overscreen);
		}
		public function setCurrentArmyIcon():void
		{
			var current:Array = Main.army.getCurrent();
			var currentIcon:Sprite = new Sprite();
			for (var i:* in current)
			{
				currentIcon = current[i].getIcon();
				if (i > 0)
				{
					currentIcon.x = current[i - 1].getIcon().x + current[i - 1].getIcon().width + 10;
				}
				partyPreview.addChild(currentIcon);
			}
			addChild(partyPreview);
		}
		
		public function clearPartyPreview():void
		{
		}
		
		public function switchScreens(newScreen:*):void
		{
			
			this.parent.addChild(newScreen);
			RemoveSprite(this);
		}
		
		public function gotoHanger(e:MouseEvent):void
		{
			switchScreens(new ArmyHangerGUI());
		}
		
		public function remove(spr:Sprite):Function
		{
			return function(e:Event):void
			{
				RemoveSprite(spr);
			}
		}
		
		public function gotoDungeonScreen(e:MouseEvent):void
		{
			if (Main.army.getCurrent().length >= 1)
			{
				clearPartyPreview();
				var win:* = levels[Main.glblPlayer.currentLevel - 1];
				
				CenterObjRelTo(win, bkgrnd);
				var spr:Sprite = DrawSquare(540, 540);
				spr.alpha = 0;
				addChild(spr);
				win.y = (bkgrnd.height / 2 - win.height / 2);
				win.addEventListener(Event.REMOVED_FROM_STAGE, remove(spr));
				addChild(win);
				win.refresh();
			}
			else
			{
				var box:MessageBox = new MessageBox({width: 200, height: 150}, "You need at least 1 person in your party to proceed!");
				CenterObjRelTo(box, bkgrnd);
				box.y = (bkgrnd.height / 2 - box.height / 2);
				addChild(box);
			}
		}
		public function disable():void {
			addChild(overscreen);
			overscreen.alpha = 1; 
		}
		public function enable():void {
			removeChild(overscreen);
			overscreen.alpha = 0; 
			alpha = 1; 
		}
		public function gotoShop(e:MouseEvent):void
		{
			//switchScreens(new GeneralShop());
		}
	
	}

}
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import Assets.Utility.DrawText;
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import mobs.CampaignEnemies.BanditBoss;
import Screens.MissionDialog;
import Towns.*;
import mobs.Enemies.*;

class ApplyBtn
{
	public var txt:TextField;
	
	public function ApplyBtn(spr:Sprite, txtContent:String)
	{
		spr.addEventListener(MouseEvent.ROLL_OVER, rollOver);
		spr.addEventListener(MouseEvent.ROLL_OUT, rollOut);
		txt = DrawText(txtContent, 30, "center");
		txt.x = (spr.width / 2 - txt.width / 2) + spr.x;
		txt.y = spr.y - 30;
		spr.parent.addChild(txt);
	}
	
	public function rollOver(e:MouseEvent):void
	{
		var spr:Sprite = e.currentTarget as Sprite;
		spr.alpha = 0.7;
		GlowObj(txt, 0xffffff);
	}
	
	public function rollOut(e:MouseEvent):void
	{
		var spr:Sprite = e.currentTarget as Sprite;
		spr.alpha = 1;
		RemoveFilters(txt);
	}
}

class lvl1 extends MissionDialog
{
	public function lvl1(mission:MissionStruct)
	{
		super(new Rat().getIcon(),mission, "boss");
	}
}
