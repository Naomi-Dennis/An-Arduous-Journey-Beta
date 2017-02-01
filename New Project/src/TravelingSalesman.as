package
{
	import Assets.Inventory;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawBorder;
	import Assets.Utility.DrawButton;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawText;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.GlowObj;
	import Assets.Utility.PlaceObjBelowRel;
	import Assets.Utility.RemoveFromArray;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.VerticalScrollBar;
	import Screens.TownDescriptionScreen;
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import items.weapon.Club;
	import Screens.ScreenBackground;
	import Assets.Item;
	
	/**
	 * ...
	 * @author lk
	 */
	public class TravelingSalesman extends Sprite
	{
		private var maxGold:int = 0;
		private var inventory:Inventory;
		private var aItems:Array = [];
		private var aSlots:Array = [];
		private var bkgrnd:ScreenBackground;
		private var tfBkgrnd:Sprite = DrawSquare(150, 127);
		private var playerGold:int = 0;
		private var shopGold:int = 0;
		private var tfPlayerGold:TextField = DrawTextArea(75, 20, 14, "center");
		private var tfShopGold:TextField = DrawTextArea(75, 20, 14, "center");
		private var buyBtn:Sprite = DrawButton("Buy", 24);
		private var sellBtn:Sprite = DrawButton("Sell", 24);
		private var aItemsTransact:Array = [];
		private var mode:String = "";
		private var BUYING:String = "BUY";
		private var SELLING:String = "SELL";
		private var MENU:String = "MENU";
		private var yesBtn:Sprite = DrawButton("Yes", 24);
		private var noBtn:Sprite = DrawButton("No", 24);
		private var tfDesc:TextField = DrawTextArea(tfBkgrnd.width, tfBkgrnd.height, 13, "center");
		private var playerInventory:Inventory;
		[Embed(source = "pics/gold_pile.png")]
		private var goldImg:Class; 
		private var overshadow:Sprite = DrawSquare(540, 540); 
		private var closeBtn:Sprite = DrawButton("Leave Shop", 22); 
		public var callback:Function = null;
		private var total:int = 0;
		private var sigTotal:int = 0; 
		private var scrollBar:VerticalScrollBar = new VerticalScrollBar(0x000000, 0xa2a2a2, "small");
		private var shopkeepGoldImg:Sprite = ConvertEmbedToSprite(goldImg); 
		private var playerGoldImg:Sprite = ConvertEmbedToSprite(goldImg);
		private var totalGoldImg:Sprite = ConvertEmbedToSprite(goldImg); 
		private var lbl_shop_keep_gold:TextField = DrawText("ShopKeep", 24); 
		private var lbl_player_gold:TextField = DrawText("Player", 24);
		private var lbl_total_gold:TextField = DrawText("Total", 24); 
		private var tf_shop_keep_gold:TextField = DrawText("0000gp", 24, "center");
		private var tf_player_gold:TextField = DrawText("0000gp", 24, "center");
		private var tf_total_gold:TextField = DrawText("0000gp", 24, "center");
		private var tf_confirm:TextField = DrawText("Confirm Sale?", 17, "center");
		private var viewingItem:Boolean = false; 
		public function TravelingSalesman(items:Array, maxGold:int, _playerInventory:Inventory)
		{
			
			aItems = items;
			playerInventory = _playerInventory;
			inventory = new Inventory(12);
			for (var i:* in items)
			{
				inventory.addItem(items[i].item);
			}
			shopGold = maxGold;
			tfShopGold.textColor = 0x9b9b9b;
			tfPlayerGold.textColor = 0xffdd00;
			DrawBorder(tfBkgrnd);
			bkgrnd = new ScreenBackground({width: 520, height: 135}, 0xffffff, 0xffffff);
			bkgrnd.y += 50; 
			tfBkgrnd.x = (bkgrnd.width - tfBkgrnd.width) - 24
			tfBkgrnd.y = bkgrnd.y + 5
			tfBkgrnd.alpha = 0.5;
			CenterObjRelTo(tfPlayerGold, bkgrnd);
			CenterObjRelTo(tfShopGold, bkgrnd);
			tfShopGold.y = 10+bkgrnd.y;
			tfShopGold.x += 14 ;
			tfPlayerGold.y = (bkgrnd.height - tfPlayerGold.height) - 10
			tfPlayerGold.x = tfShopGold.x;
			CenterObjRelTo(buyBtn, bkgrnd);
			CenterObjRelTo(sellBtn, bkgrnd);
			buyBtn.x += (bkgrnd.y + 14);
			sellBtn.x += (bkgrnd.y + 15);
			PlaceObjBelowRel(buyBtn, tfShopGold);
			PlaceObjBelowRel(sellBtn, buyBtn, 5);
			yesBtn.x = buyBtn.x;
			yesBtn.y = buyBtn.y;
			
			CenterObjRelTo(noBtn, yesBtn);
			PlaceObjBelowRel(noBtn, yesBtn);
			
			closeBtn.x = 540 / 2 - closeBtn.width / 2 - 20; 
			closeBtn.y =  300; 
			
			
			tfDesc.x = tfBkgrnd.x;
			tfDesc.y = tfBkgrnd.y;
			tfDesc.text = "";
			scrollBar.x = tfBkgrnd.x + tfBkgrnd.width + 10; 
			scrollBar.y = (tfBkgrnd.y + tfBkgrnd.height / 2) - scrollBar.height / 2; 
			
			shopkeepGoldImg.x = 10; 
			shopkeepGoldImg.y = bkgrnd.y - 40
			lbl_shop_keep_gold.x = shopkeepGoldImg.x + shopkeepGoldImg.width + 5; 
			lbl_shop_keep_gold.y = shopkeepGoldImg.y;
			tf_shop_keep_gold.y = lbl_shop_keep_gold.y; 
			tf_shop_keep_gold.x = lbl_shop_keep_gold.x + lbl_shop_keep_gold.width + 5;
			GlowObj(shopkeepGoldImg, 0xffdd00, 10, 10, 10)
			GlowObj(lbl_shop_keep_gold, 0xffffff, 10, 10, 10)
			GlowObj(tf_shop_keep_gold, 0xffffff, 10, 10, 10)
			
			totalGoldImg.x = (bkgrnd.width + bkgrnd.x) - 170; 
			totalGoldImg.y = shopkeepGoldImg.y; 
			lbl_total_gold.x = totalGoldImg.x + totalGoldImg.width + 5;
			lbl_total_gold.y = totalGoldImg.y; 
			tf_total_gold.x = lbl_total_gold.x + lbl_total_gold.width + 3
			tf_total_gold.y = totalGoldImg.y; 
			GlowObj(totalGoldImg, 0xffdd00, 10, 10, 10)
			GlowObj(lbl_total_gold, 0xffffff, 10, 10, 10)
			GlowObj(tf_total_gold, 0xffffff, 10, 10, 10)
			
			playerGoldImg.x = (bkgrnd.width + bkgrnd.x)/2 - 150/2; 
			playerGoldImg.y = bkgrnd.y + bkgrnd.height + 5; 
			lbl_player_gold.x = playerGoldImg.x + playerGoldImg.width + 5; 
			lbl_player_gold.y = playerGoldImg.y; 
			tf_player_gold.x = lbl_player_gold.x + lbl_player_gold.width + 5; 
			tf_player_gold.y = playerGoldImg.y; 
			GlowObj(playerGoldImg, 0xffdd00, 10, 10, 10)
			GlowObj(lbl_player_gold, 0xffffff, 10, 10, 10)
			GlowObj(tf_player_gold, 0xffffff, 10, 10, 10)
			buyBtn.x = (bkgrnd.width + bkgrnd.x) / 2 - buyBtn.width / 2; 
			sellBtn.x = (bkgrnd.width + bkgrnd.x) / 2 - sellBtn.width / 2; 
			
			noBtn.x = (bkgrnd.width + bkgrnd.x) / 2 - noBtn.width / 2; 
			yesBtn.x = (bkgrnd.width + bkgrnd.x) / 2 - yesBtn.width / 2; 
			tf_confirm.x = (bkgrnd.width + bkgrnd.x) / 2 - (tf_confirm.width / 2 - 1); 
			tf_confirm.y = yesBtn.y - 26; 
			addChild(bkgrnd);
		/*	addChild(tfBkgrnd);
			addChild(tfDesc);
			addChild(tfShopGold);
			addChild(tfPlayerGold);
			addChild(buyBtn);
			addChild(sellBtn);
			addChild(scrollBar);
			*/
			addChild(closeBtn);
			addChild(shopkeepGoldImg);
			addChild(lbl_shop_keep_gold);
			addChild(tf_shop_keep_gold);
			addChild(totalGoldImg);
			addChild(lbl_total_gold);
			addChild(tf_total_gold);
			addChild(playerGoldImg);
			addChild(lbl_player_gold);
			addChild(tf_player_gold); 
			closeBtn.addEventListener(MouseEvent.CLICK, closeWin); 
			initSlots();
			addEventListener(Event.ENTER_FRAME, updateShopInfo);
			buyBtn.addEventListener(MouseEvent.CLICK, buyMenu);
			sellBtn.addEventListener(MouseEvent.CLICK, sellMenu);
			noBtn.addEventListener(MouseEvent.CLICK, backToMainMenu);
			tfPlayerGold.addEventListener(MouseEvent.ROLL_OVER, textDesc);
			tfShopGold.addEventListener(MouseEvent.ROLL_OVER, textDesc2);
			mode = MENU; 
			addEventListener(Event.ENTER_FRAME, useMaxScroll);
			scrollBar.scrubber.addEventListener(MouseEvent.MOUSE_DOWN, useScroll);
			scrollBar.scrubber.addEventListener(MouseEvent.MOUSE_UP, stopUseScroll);
			
			mainMenu();
		
		}
		private function passiveScroll(e:Event):void{
			
		}
		private function closeWin(e:Event):void{
			if(callback != null){
				callback();
			}
			else{
				RemoveSprite(this);
			}
		}
		private function textDesc(e:MouseEvent):void {
		}
		private function textDesc2(e:MouseEvent):void {
		}
		private function sellTransaction():void
		{
			var totalPrice:int = 2 * aItemsTransact.length;
			var hasEverything:Boolean = true; 
			if(total <= shopGold){
				var str:String = "You've sold\n";
				for (var i:* in aItemsTransact)
				{
					if(Main.glblPlayer.inventory.getItemByName(aItemsTransact[i].item.getName())){
						str += aItemsTransact[i].item.getName() + "\n";
						Main.glblPlayer.inventory.removeItem(aItemsTransact[i].item);
						Main.glblPlayer.changeGold(total);
						aItemsTransact = [];
					}
					else {
						hasEverything = false;
					}
				}
				str = "for " + total.toString();
			}
			else{
				sendNotice("\"Sorry, I dont have enough to buy that!\"");
			}
			clearTransaction();
		}
		
		private function buyTransaction():Boolean
		{
			var totalPrice:int = 0;
			var len:int = 0;
			for (var item:* in aItemsTransact)
			{
				len++;
				totalPrice += aItemsTransact[item].value; 
			}
			var playerGold:int = Main.glblPlayer.getGold();
			if (playerGold >= totalPrice)
			{
				var str:String = "You've bought\n";
				for (var i:* in aItemsTransact)
				{
					str += aItemsTransact[i].item.getName() + "\n";
					Main.glblPlayer.inventory.addItem(aItemsTransact[i].item);
					inventory.removeItem(aItemsTransact[i].item); 
					Main.glblPlayer.changeGold( aItemsTransact[i].value * -1 );
					RemoveFromArray(aItems, aItemsTransact[i]);
					
					setBuySlots();
				}
				aItemsTransact = [];
				return true; 
			}
			else if (playerInventory.getsize() < len && playerGold >= totalPrice)
			{
				sendNotice("Your inventory is full!");
			}
			else
			{
				sendNotice("You don't have enough money!"); 
			}
			return false; 
		}
		
		private function confirmTransaction():void
		{
			if (aItemsTransact.length > 0)
			{
				tfDesc.appendText("\nTotal: " + total.toString() + "gp")
				if (mode == BUYING)
				{
					//set shop items
					//buyTransaction();
					total = displayTransactItems();
					tfDesc.appendText("\nTotal: " + total + "gp");
					
					yesBtn.addEventListener(MouseEvent.CLICK, buyItems_MOUSE_HANDLE); 
					
				}
				else if (mode == SELLING)
				{
					//set player items
					//have the player buy the stuff
					yesBtn.addEventListener(MouseEvent.CLICK, sellItems_MOUSE_HANDLE);
				}
			}
		}
		private function setUpSellItems_MOUSE_HANDLE(e:MouseEvent):void {
			if (mode == SELLING) {
				confirmTransaction();
			}
			else {
				mode = SELLING; 
				setSellSlots();
			}
		}
		private function setUpBuyItems_MOUSE_HANDLE(e:MouseEvent):void {
			if (mode == BUYING) {
				confirmTransaction();
				
			}
			else {
				clearTransaction();
				mode = BUYING; 
			}
		}
		private function buyItems_MOUSE_HANDLE(e:MouseEvent):void {
			if (buyTransaction()){
			}
			
		}
		private function sellItems_MOUSE_HANDLE(e:MouseEvent):void {
			sellTransaction();
			setSellSlots();
		}
		private function cancelTransaction():void
		{
			var total:int = displayTransactItems();
			tfDesc.appendText("\nTotal: " + total.toString() + "gp")
			clearTransaction();	
		}
		
		private function displayTransactItems():int
		{
			var str:String = "";
			var currentItem:Object = null;
			total = 0;
			for (var i:* in aItemsTransact)
			{
				currentItem = aItemsTransact[i];
				str = currentItem.item.getName();
				total += currentItem.value;
				tfDesc.appendText("\n" + str + " " + currentItem.value.toString() + "gp"); 
			}
			return total;
		}
		private function sendNotice(str:String):void{
			var win:TownDescriptionScreen = new TownDescriptionScreen(ConvertEmbedToSprite(goldImg), str); 
			win.x = 540 / 2 - win.width / 2; 
			win.y = 540 / 2 - win.height / 2; 
			overshadow.alpha = 0.2; 
			overshadow.x = -16;
			overshadow.y = 0; 
			addChild(overshadow); 
			
			addChild(win); 
			win.addEventListener(Event.REMOVED_FROM_STAGE, removeNotice);
		}
		private function removeNotice(e:Event):void{
			RemoveSprite(overshadow);
		}
		private function updateShopInfo(e:Event):void
		{
			if(!viewingItem){
				tfPlayerGold.text = Main.glblPlayer.getGold().toString() + "gp";
				tfShopGold.text = shopGold.toString() + "gp";
				sigTotal = 0; 
				if (mode == BUYING){
					tfDesc.text = "Items to Buy";
				}
				else if (mode == SELLING){
					tfDesc.text = "Items to Sell"
				}
				sigTotal += displayTransactItems();
				tfDesc.appendText("\n\nTotal: " + sigTotal.toString() + "gp")
			
				tfDesc.scrollV = tfDesc.maxScrollV * (1 - (scrollBar.ratio * -1));
				tf_shop_keep_gold.text = shopGold.toString() + "gp"; 
				tf_player_gold.text = Main.glblPlayer.getGold().toString() + "gp";
				tf_total_gold.text = total.toString() + "gp"; 
			}
		}
		private function useMaxScroll(e:Event):void{
			tfDesc.scrollV = tfDesc.maxScrollV;
		}
		private function useScroll(e:MouseEvent):void{
			removeEventListener(Event.ENTER_FRAME, useMaxScroll);
		}

		private function stopUseScroll(e:MouseEvent):void{
			addEventListener(Event.ENTER_FRAME, useMaxScroll);
		}
		
		private function initSlots():void
		{
			for (var i:int = 0; i < 4; i++)
			{
				
				for (var j:int = 0; j < 6; j++)
				{
					var currentSlot:ShopSlot = new ShopSlot();
					currentSlot.width = 32;
					currentSlot.height = 32;
					currentSlot.x = (j * currentSlot.width) + 4
					currentSlot.y = ((i * currentSlot.height) + 4) + bkgrnd.y;
					currentSlot.addEventListener(MouseEvent.ROLL_OUT, stopViewingItem);		
					currentSlot.addEventListener(MouseEvent.CLICK, selectItem);
					aSlots.push(currentSlot);
				}
			}
		}
		
		private function setBuySlots():void
		{
			/* Set Shop Slots */
			clearSlots();
			RemoveSprite(buyBtn);
			RemoveSprite(sellBtn);
			addChild(yesBtn);
			addChild(noBtn);
			addChild(tfBkgrnd);
			addChild(tfDesc);
			addChild(scrollBar); 
			addChild(tf_confirm);
			var currentSlot:ShopSlot = new ShopSlot();
			var maxItems:Array = aItems;
			var currentItem:int = 0;
			var currentItemObj:Object = null;
			mode = BUYING; 
			for (var i:int = 0; i < aSlots.length; i++)
			{
				currentSlot = aSlots[i];
				currentItemObj = maxItems[i];
				if (maxItems[currentItem] != null)
				{
					currentSlot.setItem(currentItemObj);
					RemoveSprite(currentSlot);
					addChild(currentSlot);
				}
				currentItem++;
			}
		/* End For Loop */
		}
		private function clearSlots():void {
			var currentSlot:ShopSlot = null;
			for (var i:* in aSlots) {
				currentSlot = aSlots[i]; 
				currentSlot.deselect();
				currentSlot.clear();
				RemoveSprite(aSlots[i]);
				addChild(aSlots[i]);
			}
		}
		private function setSellSlots():void
		{
			/* Set Player Slots */
			clearSlots();
			RemoveSprite(buyBtn);
			RemoveSprite(sellBtn);
			addChild(yesBtn);
			addChild(noBtn);
			addChild(tfBkgrnd);
			addChild(tfDesc);
			addChild(scrollBar); 
			addChild(tf_confirm);
			var currentSlot:ShopSlot = new ShopSlot();
			var maxItems:Array = Main.glblPlayer.inventory.getItems();
			var currentItem:int = 0;
			var currentItemObj:Object = null;
			mode = SELLING; 
			for (var i:int = 0; i < aSlots.length; i++)
			{
				currentSlot = aSlots[i];
				currentItemObj = maxItems[i];
				if (i < maxItems.length)
				{
					currentSlot.setItem({item:currentItemObj, value:3});
					RemoveSprite(currentSlot);
					addChild(currentSlot);
				}
				currentItem++;
			}
		/* End For Loop */
		}
		private function stopViewingItem(e:MouseEvent):void{
			viewingItem = false; 
		}
		private function selectItem(e:MouseEvent):void
		{
			var slot:ShopSlot = e.currentTarget as ShopSlot;
			if (!slot.isSelected())
			{
				viewingItem = true; 
				tfDesc.text = slot.getItem().getCompleteDesc();
				slot.select();
				aItemsTransact.push(slot.getItemObj());
				slot.addEventListener(MouseEvent.CLICK, deselectItem);
				slot.removeEventListener(MouseEvent.CLICK, selectItem);
			}
		}
		
		private function deselectItem(e:MouseEvent):void
		{
			var slot:ShopSlot = e.currentTarget as ShopSlot;
			if (slot.isSelected())
			{
				slot.deselect();
				if (mode == BUYING)
				RemoveFromArray(aItemsTransact, slot.getItemObj());
				slot.removeEventListener(MouseEvent.CLICK, deselectItem);
				slot.addEventListener(MouseEvent.CLICK, selectItem);
			}
		}
		
		private function clearTransaction():void
		{
			for (var i:* in aSlots) {
				aSlots[i].deselect(); 
			}
			aItemsTransact = [];
		}
		private function buyMenu(e:MouseEvent):void{
			if(yesBtn.hasEventListener(MouseEvent.CLICK)){
				yesBtn.removeEventListener(MouseEvent.CLICK, sellItems_MOUSE_HANDLE); 
			}
			yesBtn.addEventListener(MouseEvent.CLICK, buyItems_MOUSE_HANDLE);
			setBuySlots();
		}
		private function sellMenu(e:MouseEvent):void{
			if(yesBtn.hasEventListener(MouseEvent.CLICK)){
				yesBtn.removeEventListener(MouseEvent.CLICK, buyItems_MOUSE_HANDLE);
			}
			yesBtn.addEventListener(MouseEvent.CLICK, sellItems_MOUSE_HANDLE);
			setSellSlots();
		}
		private function removeSlots():void{
			var currentSlot:ShopSlot = null;
			for (var i:* in aSlots) {
				currentSlot = aSlots[i]; 
				currentSlot.clear();
				RemoveSprite(aSlots[i]);
			}
		}
		private function mainMenu():void{
			addChild(buyBtn);
			addChild(sellBtn);
		}
		private function backToMainMenu(e:MouseEvent):void{
			removeSlots();
			RemoveSprite(tf_confirm);
			RemoveSprite(yesBtn);
			RemoveSprite(noBtn);
			RemoveSprite(tfDesc);
			RemoveSprite(tfBkgrnd);
			RemoveSprite(scrollBar);
			cancelTransaction();
			mainMenu();
		}
	
	}

}
import Assets.Item;
import Assets.SoundClass;
import Assets.Utility.CenterObjRelTo;
import Assets.Utility.ChangeColor;
import Assets.Utility.DrawSquare;
import flash.display.ColorCorrectionSupport;
import flash.display.Sprite;
import Assets.Utility.ConvertEmbedToSprite;
import Assets.Utility.RemoveSprite;
import Assets.Utility.RemoveFilters;
import Assets.Utility.GlowObj;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import Assets.Utility.DrawText;

class ShopSlot extends Sprite
{
	private var item:Item = new Item();
	private var itemIco:Sprite = new Sprite();
	[Embed(source = "InventorySlot.png")]
	private var slotImg4:Class;
	private var bkgrnd:Sprite = new Sprite();
	private var itemObj:Object = {};
	private var selected:Boolean = false;
	private var price:int = 0; 
	public function ShopSlot():void
	{
		width = 20;
		height = 20;
		bkgrnd = ConvertEmbedToSprite(slotImg4);
		addChild(bkgrnd);
		addEventListener(MouseEvent.ROLL_OVER, glow);
		addEventListener(MouseEvent.ROLL_OUT, stopGlow);
	}
	
	public function getItemObj():Object
	{
		return itemObj;
	}
	
	public function isSelected():Boolean
	{
		return selected;
	}
	
	public function select():void
	{
		selected = true;
		ChangeColor(bkgrnd, 0xffdd00);
		bkgrnd.alpha = 0.2; 
	}
	
	public function deselect():void
	{
		selected = false;
		bkgrnd.transform.colorTransform = new ColorTransform();
	}
	
	public function setItem(_item:Object):void
	{
		itemObj = _item;
		
		item = itemObj.item;
		price = itemObj.value; 
		
		itemIco = item.getIcon();
		
		itemIco.width = width;
		itemIco.height = height; 
		CenterObjRelTo(itemIco, bkgrnd);
		itemIco.y = (bkgrnd.y + bkgrnd.height / 2) - itemIco.height / 2;
		refresh();
	}
	
	public function getPrice():int
	{
		return price;
	}
	
	public function getItem():Item
	{
		return item;
	}
	public function clear():void{
		itemObj = null;
		eraseItem();
	}
	public function getIcon():Sprite
	{
		return itemIco;
	}
	
	public function eraseItem():void
	{
		item = new Item();
		RemoveSprite(itemIco);
		RemoveFilters(this);
	}
	
	public function refresh():void
	{
		RemoveSprite(bkgrnd)
		RemoveSprite(itemIco);
		addChild(bkgrnd);
		
		addChild(itemIco);
	}
	
	public function glow(e:MouseEvent):void
	{
		SndLib.playButtonClick();
		if (!selected)
		{
			ChangeColor(bkgrnd, 0x00ff00);
			bkgrnd.alpha = 0.6
		}
	}
	
	public function stopGlow(e:MouseEvent):void
	{
		if (!selected)
		{
			bkgrnd.transform.colorTransform = new ColorTransform();
			bkgrnd.alpha = 1; 
		}
	}
}
