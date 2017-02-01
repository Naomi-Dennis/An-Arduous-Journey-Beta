package
{
	import Assets.Item;
	import Assets.Utility.ConvertEmbedToBitmapData;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.ConvertFromByteArray;
	import Assets.Utility.ConvertToByteArray;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.GetAliasInformation;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveSprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author kljjlk
	 */
	public class MobIcon extends Sprite
	{
		[Embed(source="images/human_m.png")]
		private var baseImg:Class;
		[Embed(source = "black hair.png")]
		private var blackHair:Class;
		[Embed(source = "brown hair.png")]
		private var brownHair:Class;
		[Embed(source = "long hair and beard.png")]
		private var longHair:Class;
		[Embed(source = "short hair and beard black.png")]
		private var shortHair:Class;
		private var shield:Sprite = new Sprite();
		private var weapon:Sprite = new Sprite();
		private var armor:Sprite = new Sprite();
		private var leggings:Sprite = new Sprite();
		private var shoes:Sprite = new Sprite();
		private var mob:Mob = null;
		private var base:Sprite = new Sprite();
		private var hair:Sprite = new Sprite();
		private var cape:Sprite = new Sprite();
		private var hairData:Object ; 
		private var shoesData:Object;
		private var capeData:Object;
		private var inUse:Boolean = false;
		private var data:Object = {hair:"", shoes:"", cape:""}; 
		
		private var shieldClass:Class;
		private var weaponClass:Class;
		private var armorClass:Class;
		private var leggingsClass:Class;
		private var shoesClass:Class;
		private var baseClass:Class;
		private var hairClass:Class;
		private var capeClass:Class; 
		private var bitmapData:BitmapData = new BitmapData(32, 32, true, 0x0);
		public function MobIcon(_mob:Mob)
		{
			mob = _mob;
			base = ConvertEmbedToSprite(baseImg);
			base.width = 32;
			base.height = 32;
			baseClass = baseImg; 
			addChild(base);
		}
		public function getBitmapData():BitmapData{
			return bitmapData;
		}
		public function saveData():Object
		{
			data = { };
			if(shoesData != null){
				data.shoes = GetAliasInformation(shoesData);
			}
			if(capeData != null){
				data.cape = GetAliasInformation(capeData);
			}
			if(hairData != null){
				data.hair = GetAliasInformation(hairData);
			}
			return data;
		}
		public function loadData(newData:Object):void{
			var className:* = getDefinitionByName(newData.hair.path);
			if(newData.hair != null){
				hairData = getDefinitionByName(newData.hair.path);
				hair = ConvertEmbedToSprite(hairData);
				hairClass = Class(hairData); 
			}
			if (newData.shoes != null){
				shoesData = getDefinitionByName(newData.shoes.path);
				shoes = ConvertEmbedToSprite(shoesData);
				shoesClass = Class(shoesData);
			}
			if (newData.cape != null){
				capeData = getDefinitionByName(newData.cape.path);
				cape = ConvertEmbedToSprite(capeData);
				capeClass = Class(capeData); 
			}
			checkCanEquip( mob.getWeapon() );
			checkCanEquip( mob.getArmor() );
			checkCanEquip( mob.getShield() );
			checkCanEquip( mob.getLeggings() );
			refresh();
		}
		public function loadIcon(datum:*, _mob:Mob):void
		{
			hairClass = datum; 
			hair = ConvertEmbedToSprite(datum); 
			mob = _mob;
			checkCanEquip( mob.getWeapon() );
			checkCanEquip( mob.getArmor() );
			checkCanEquip( mob.getShield() );
			checkCanEquip( mob.getLeggings() );
			refresh();
		}
		public function checkCanEquip(obj:Item):void{
			if (obj != null){
				equip(obj); 
			}
		}
		
		
		public function isInUse():Boolean
		{
			return inUse;
		}
		
		public function setInUse(bool:Boolean):void
		{
			inUse = bool
		}
		
		public function setHair(newHair:Class):void
		{
			hairClass = newHair; 
			loadIcon(newHair, mob);
			hairData = newHair;
		}
		
		public function genHair():void
		{
			var array:Array = [blackHair, brownHair, longHair, shortHair];
			var rand:int = RandomNumber(array.length, 1);
			hairData = array[rand - 1]; 
			hairClass = array[rand - 1]; 
			refresh();
		}
		
		public function setNewBase(newBase:Sprite):void
		{
			base = newBase;
			refresh();
		}
		
		public function equip(item:Item):void
		{
			var itemType:String = item.getType().toLowerCase();
			if (itemType == "armor")
			{
				RemoveSprite(armor);
				armor = item.getMobVersion();
				armorClass = item.getMobVersionClass();
			}
			else if (itemType == "weapon")
			{
				RemoveSprite(weapon);
				weapon = item.getMobVersion();
				weaponClass = item.getMobVersionClass();
			}
			else if (itemType == "shield")
			{
				RemoveSprite(shield);
				shield = item.getMobVersion();
				shieldClass = item.getMobVersionClass();
			}
			else if (itemType == "leggings")
			{
				RemoveSprite(leggings);
				leggings = item.getMobVersion();
				leggingsClass = item.getMobVersionClass();
			}
			else if (itemType == "shoes")
			{
				RemoveSprite(shoes);
				shoes = item.getMobVersion();
				shoesData = item.getMobVersionClass();
				shoesClass = item.getMobVersionClass();
			}
			else if (itemType == "cape")
			{
				RemoveSprite(cape);
				cape = item.getMobVersion();
				capeData = item.getMobVersionClass();
				capeData = item.getMobVersionClass();
			}
			else if (itemType == "hair"){
				/* Equip hat, not hair, hair is not an item. */
				RemoveSprite(hair);
				hair = item.getMobVersion();
				hairData = item.getMobVersionClass();
				hairClass = item.getMobVersionClass();
			}
			refresh();
		}
		
		public function unEquip(item:Item):void
		{
			var itemType:String = item.getType().toLowerCase();
			if (itemType == "armor")
			{
				RemoveSprite(armor);
				armor = new Sprite();
				armorClass = null;
			}
			else if (itemType == "weapon")
			{
				RemoveSprite(weapon);
				weapon = new Sprite();
				weaponClass = null;
			}
			else if (itemType == "shield")
			{
				RemoveSprite(shield);
				shield = new Sprite();
				shieldClass = null;
			}
			else if (itemType == "leggings")
			{
				RemoveSprite(leggings);
				leggings = new Sprite();
				leggingsClass = null;
			}
			else if (itemType == "shoes")
			{
				RemoveSprite(shoes);
				shoes = new Sprite();
				shoes = null;
				shoesClass = null; 
			}
			else if (itemType == "cape")
			{
				RemoveSprite(cape);
				cape = new Sprite();
				cape = null;
				capeClass = null;
			}
			else if (itemType == "hair")
			{
				RemoveSprite(hair);
				hair = new Sprite();
				hairData = null;
				hairClass = null;
			}
			refresh();
		}
		
		private function refresh():void
		{
			bitmapData = new BitmapData(32, 32, true, 0x0);
			if (capeClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData(capeClass) );
			}
			if (baseClass != null){
				bitmapData.draw(  ConvertEmbedToBitmapData(baseClass) );
			}
			if (shoesClass != null){
				bitmapData.draw(  ConvertEmbedToBitmapData(shoesClass) );
			}
			if (leggingsClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData( leggingsClass ) );
			}
			if (armorClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData(armorClass) );
			}
			if (shieldClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData(shieldClass) );	
			}
			if (weaponClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData(weaponClass) );	
			}
			if (hairClass != null){
				bitmapData.draw( ConvertEmbedToBitmapData(hairClass) );	
			}
			addChild( new Bitmap(bitmapData) );
			mob.getBattlePiece().replaceBitmapData( bitmapData );
		}
	
	}

}