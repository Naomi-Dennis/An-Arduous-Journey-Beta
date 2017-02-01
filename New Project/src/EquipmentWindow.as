package
{
	import Assets.Effects.DropShadow;
	import Assets.Item;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DrawText;
	import Assets.Utility.GlowObj;
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author kljjlk
	 */
	public class EquipmentWindow extends Sprite
	{
		[Embed(source = "pics/EquipmentWindow/ArmorImg.png")]
		private var armorImg:Class;
		[Embed(source = "pics/EquipmentWindow/ShieldImg.png")]
		private var shieldImg:Class;
		[Embed(source = "pics/EquipmentWindow/WeaponImg.png")]
		private var weaponImg:Class;
		[Embed(source = "pics/EquipmentWindow/PantsImg.png")]
		private var leggingsImg:Class; 
		//slots/
		private var armorSlot:Sprite = new Sprite();
		private var weaponSlot:Sprite = new Sprite();
		private var shieldSlot:Sprite = new Sprite();
		private var leggingSlot:Sprite = new Sprite();
		//items//
		private var armor:Sprite = new Sprite();
		private var weapon:Sprite = new Sprite();
		private var shield:Sprite = new Sprite();
		private var leggings:Sprite = new Sprite();
		//mob //
		private var mob:Mob = null
		//item to place//
		public var currentItem:Item = null;
		private var fooArmor:Function;
		private var fooWeapon:Function;
		private var fooShield:Function;
		private var fooLeggings:Function
		public var hoveredItem:* = null;
		// how to use//
		/*
		 *  set the drag to the icon being dragged, depending on the type, let it be checkArmorSlot/checkWeaponSlot/etc
		 * */
		public function EquipmentWindow(_mob:Mob)
		{
			mob = _mob;
			armorSlot = ConvertEmbedToSprite(armorImg);
			weaponSlot = ConvertEmbedToSprite(weaponImg);
			shieldSlot = ConvertEmbedToSprite(shieldImg);
			
			armorSlot.x = weaponSlot.x + weaponSlot.width;
			shieldSlot.x = armorSlot.x + armorSlot.width;
			
			addChild(armorSlot)
			addChild(weaponSlot);
			addChild(shieldSlot);
			
			refresh();
		}
		
		private function refresh():void
		{
			RemoveSprite(armor);
			RemoveSprite(weapon);
			RemoveSprite(shield);
			setArmor();
			setShield();
			setWeapon();
			
		
			
			addChild(armor);
			addChild(weapon);
			addChild(shield);
			
			armor.x = armorSlot.x + 1;
			armor.y = armorSlot.y + 1
			
			weapon.x = weaponSlot.x + 1;
			weapon.y = weaponSlot.y + 1;
			
			shield.x = shieldSlot.x + 1;
			shield.y = shieldSlot.y + 1;
			
		}
		
		private function setWeapon():void
		{
			if (mob.getWeapon() != null)
			{
				weapon = mob.getWeapon().getIcon();
				weapon.width = weaponSlot.width - 2;
				weapon.height = weaponSlot.height - 2;
				GlowObj(weapon, 0xffffff, 6);
				fooWeapon = showTooltip(mob.getWeapon());
				weapon.addEventListener(MouseEvent.ROLL_OVER, fooWeapon);
			}
		}
		
		private function setArmor():void
		{
			if (mob.getArmor() != null)
			{
				armor = mob.getArmor().getIcon();
				armor.width = armorSlot.width - 2;
				armor.height = armorSlot.height - 2;
				GlowObj(armor, 0xffffff, 6);
				fooArmor = showTooltip(mob.getArmor());
				armor.addEventListener(MouseEvent.ROLL_OVER, fooArmor);
			}
		}
		
		private function setShield():void
		{
			if (mob.getShield() != null)
			{
				shield = mob.getShield().getIcon();
				shield.width = shieldSlot.width - 2;
				shield.height = shieldSlot.height - 2;
				GlowObj(shield, 0xffffff, 6);
				shield.addEventListener(MouseEvent.ROLL_OVER, showTooltip(mob.getShield()));
			}
		}
		
		private function setLeggings():void
		{
			if (mob.getLeggings() != null)
			{
				leggings = mob.getLeggings().getIcon();
				leggings.width = leggingSlot.width - 2;
				leggings.height = leggingSlot.height - 2;
				GlowObj(leggings, 0xffffff, 6);
				leggings.addEventListener(MouseEvent.ROLL_OVER, showTooltip(mob.getLeggings()));
			}
		}
		
		
		public function checkArmorSlot(e:Event):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			var par:* = spr.parent;//the inventory slot
			if (currentItem.getIcon().hitTestObject(armorSlot))//if the item is hitting the equipment window
			// and if the player has space in their inventory. 
			{
				par.eraseItem();//erase the item from the slot
				par.parent.addToInventory(mob.getArmor())
				//armor.removeEventListener(MouseEvent.ROLL_OVER, fooArmor);
				mob.equip(currentItem);//equip the current item
				par.parent.removeFromInventory(currentItem);//remove the current item from the player's inventory
				par.parent.setSlotItems();//reset the slot items of the inventory 
				RemoveSprite(currentItem.getIcon());//clear the icon from the inventory 
				setArmor();
				currentItem.getIcon().stopDrag(); 
				currentItem.getIcon().x = 0;//reset the x
				currentItem.getIcon().y = 0;//reset the y
				RemoveSprite(weaponSlot);
				RemoveSprite(armorSlot);
				RemoveSprite(shieldSlot);
				setWeapon();
				setArmor();
				setShield();
				addChild(weaponSlot);
				addChild(armorSlot); 
				addChild(shieldSlot); 
				refresh(); 
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkArmorSlot);
				currentItem = null;
			}
		
		}
		
		public function checkWeaponSlot(e:Event):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			var par:* = spr.parent;//the inventory slot 
			if (currentItem.getIcon().hitTestObject(weaponSlot))//if the item is hitting the equipment window
			// and if the player has space in their inventory. 
			{
				par.eraseItem();//erase the item from the slot
				par.parent.addToInventory(mob.getWeapon())
				//armor.removeEventListener(MouseEvent.ROLL_OVER, fooArmor);
				mob.equip(currentItem);//equip the current item
				par.parent.removeFromInventory(currentItem);//remove the current item from the player's inventory
				par.parent.setSlotItems();//reset the slot items of the inventory 
				RemoveSprite(currentItem.getIcon());//clear the icon from the inventory 
				setWeapon();
				currentItem.getIcon().stopDrag(); 
				currentItem.getIcon().x = 0;//reset the x
				currentItem.getIcon().y = 0;//reset the y
				RemoveSprite(weaponSlot);
				RemoveSprite(armorSlot);
				RemoveSprite(shieldSlot);
				setWeapon();
				setArmor();
				setShield();
				addChild(weaponSlot);
				addChild(armorSlot); 
				addChild(shieldSlot); 
				refresh(); 
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkWeaponSlot);
				currentItem = null;
			}
		}
		
		public function checkShieldSlot(e:Event):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			var par:* = spr.parent;//the inventory slot 
			if (currentItem.getIcon().hitTestObject(shieldSlot))//if the item is hitting the equipment window
			// and if the player has space in their inventory. 
			{
				par.eraseItem();//erase the item from the slot
				par.parent.addToInventory(mob.getShield())
				//armor.removeEventListener(MouseEvent.ROLL_OVER, fooArmor);
				mob.equip(currentItem);//equip the current item
				par.parent.removeFromInventory(currentItem);//remove the current item from the player's inventory
				par.parent.setSlotItems();//reset the slot items of the inventory 
				RemoveSprite(currentItem.getIcon());//clear the icon from the inventory 
				setShield();
				currentItem.getIcon().stopDrag(); 
				currentItem.getIcon().x = 0;//reset the x
				currentItem.getIcon().y = 0;//reset the y
				RemoveSprite(weaponSlot);
				RemoveSprite(armorSlot);
				RemoveSprite(shieldSlot);
				setWeapon();
				setArmor();
				setShield();
				addChild(weaponSlot);
				addChild(armorSlot); 
				addChild(shieldSlot); 
				refresh(); 
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkShieldSlot);
				currentItem = null;
			}
		}
		
		public function checkLeggingSlot(e:Event):void
		{
			var spr:Sprite = e.currentTarget as Sprite;
			var par:* = spr.parent;//the inventory slot 
			if (currentItem.getIcon().hitTestObject(leggingSlot))//if the item is hitting the equipment window
			// and if the player has space in their inventory. 
			{
				par.eraseItem();//erase the item from the slot
				par.parent.addToInventory(mob.getLeggings())
				//armor.removeEventListener(MouseEvent.ROLL_OVER, fooArmor);
				mob.equip(currentItem);//equip the current item
				par.parent.removeFromInventory(currentItem);//remove the current item from the player's inventory
				par.parent.setSlotItems();//reset the slot items of the inventory 
				RemoveSprite(currentItem.getIcon());//clear the icon from the inventory 
				currentItem.getIcon().stopDrag(); 
				currentItem.getIcon().x = 0;//reset the x
				currentItem.getIcon().y = 0;//reset the y
				RemoveSprite(weaponSlot);
				RemoveSprite(armorSlot);
				RemoveSprite(shieldSlot);
				setWeapon();
				setArmor();
				setShield();
				addChild(weaponSlot);
				addChild(armorSlot); 
				addChild(shieldSlot); 
				refresh(); 
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkLeggingSlot);
				currentItem = null;
			}
		}
		
		public function showTooltip(item:Item):Function
		{
			var spr:* = this;
			return function(e:MouseEvent):void
			{
				if(item != null && contains(item.getIcon())){
					var txt:TextField = DrawText(item.getName(), 24);
					txt.x -= 25; 
					DropShadow(txt);
					GlowObj(txt, 0xffffff, 4); 
					txt.y = 84; 
					addChild(txt);
					e.currentTarget.addEventListener(MouseEvent.ROLL_OUT, hideToolTip(txt));
					spr.hoveredItem = item; 
				}
			}
		}
		
		public function hideToolTip(tooltip:TextField):Function
		{
			return function(e:MouseEvent):void
			{
				hoveredItem = null; 
				RemoveSprite(tooltip);
			}
		}
		

	
	}

}