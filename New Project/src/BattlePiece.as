package
{
	import Assets.Effects.DropShadow;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ChangeColor;
	import Assets.Utility.ConvertEmbedToBitmapData;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.DrawTextArea;
	import Assets.Utility.GlowObj;
	import Assets.Utility.RemoveFilters;
	import Assets.Utility.RemoveSprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ColorCorrection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import Assets.Utility.SpriteToBitmapData;
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class BattlePiece extends Sprite
	{
		private var ico:SpriteWrapper = new SpriteWrapper();
		private var hpBar:Sprite = new Sprite();
		public var moving:Boolean = false;
		public var attacking:Boolean = false;
		public var location:Cell = null;
		private var fieldLoc:Object = {row: 0, col: 0};
		public var mob:* = null;
		private var tfValue:TextField = DrawTextArea(100, 20, 18, "center");
		private var animationTimer:int = 80;
		[Embed(source = "pics/skills icon/bleeding heart.png")]
		private var bleedigHeart:Class;
		[Embed(source = "pics/skills icon/fire strike.png")]
		private var fireStrike:Class;
		[Embed(source = "pics/skills icon/ice attack.png")]
		private var iceAttack:Class;
		[Embed(source = "pics/skills icon/poison.png")]
		private var poison:Class;
		[Embed(source = "pics/strengthUpIcon.png")]
		private var strengthUpIcon:Class;
		[Embed(source = "pics/wisdomUpIcon.png")]
		private var wisdomUpIcon:Class;
		[Embed(source = "pics/defenseDownIcon.png")]
		private var defenseDownIcon:Class;
		[Embed(source = "pics/defenseUpIcon.png")]
		private var defenseUpIcon:Class;
		[Embed(source = "pics/dexterityUpIcon.png")]
		private var dexterityUpIcon:Class;
		[Embed(source = "pics/constitutionDownIcon.png")]
		private var constitutionDownIcon:Class;
		[Embed(source = "pics/consitutionUpIcon.png")]
		private var constitutionUpIcon:Class;
		[Embed(source = "pics/skills icon/stun strike.png")]
		private var stunStrike:Class;
		[Embed(source = "pics/skills icon/rage.png")]
		private var rage:Class;
		[Embed(source = "pics/apUpIcon.png")]
		private var apUpIcon:Class;
		[Embed(source = "pics/apDownIcon.png")]
		private var apDownIcon:Class; 
		[Embed(source = "pics/skills icon/fear.png")]
		private var fearIcon:Class; 
		private var effectsList:Object = {"fear": fearIcon, "ap down":apDownIcon, "ap up": apUpIcon, "wisdom up": wisdomUpIcon, "rage": rage, "strength up": strengthUpIcon, "constitution up": constitutionUpIcon, "constitution down": constitutionDownIcon, "defense up": defenseUpIcon, "defense down": defenseDownIcon, "poisoned": poison, "dexterity up": dexterityUpIcon, "bleeding": bleedigHeart, "frozen": iceAttack, "burning": fireStrike, "stunned": stunStrike};
		private var effectsIco:Object = {"fear":null, "ap down":null, "ap up": null, "wisdom up": null, "rage": null, "strength up": null, "constitution up": null, "constitution down": null, "defense up": null, "defense down": null, "poisoned": null, "dexterity up": null, "bleeding": null, "frozen": null, "burning": null, "stunned": null};
		private var tfName:TextField = DrawTextArea(60, 15, 12, "center");
		private var effectsSprite:Sprite = new Sprite();
		private var boolShowHpBar:Boolean = false;
		private var STATIC_DIM:Object = {w: 0, h: 0};
		private var flickerHandle:Function;
		private var flickerTimer:Timer = new Timer(50);
		private var glowTimer:Timer = new Timer(50);
		private var flickerColor:Number = 0x000000;
		private var valueAnimationTimer:Timer = new Timer(50);
		private var colored:Boolean = false;
		private var turnOnEffect:Boolean = false;
		private var nFlicker:int = 0;
		public var isDead:Boolean = false;
		public var animateOn:Boolean = false;
		private var flickerDifference:int = 0; 
		private var initialFlicker:int; 
		public var pieceMovementHandle:Function;
		public var tfAttack:TextField = DrawTextArea(100, 20, 18, "center");
		public var bitmapData:BitmapData;
		public function BattlePiece(_ico:*, _mob:*)
		{
			//sometimes ico is mobIcon
			mob = _mob;
			
			if (mob.mobType.toLowerCase() == "player"){
				bitmapData = Mob(mob).getMobIcon().getBitmapData();

			}
			else if ( Mob(mob).getName() == "Bandit"){
				bitmapData = Mob(mob).getMobIcon().getBitmapData();
			}
			else{
				bitmapData = ConvertEmbedToBitmapData(mob.img); 
			}
			ico.changeDefaultData(bitmapData); 
			ico.changeBitmapData(bitmapData);
			ico.width = 31;
			ico.height = 31;
			DropShadow(ico);
			hpBar = DrawSquare(ico.width, 2, 0xaa0000);
			hpBar.y -= 10;
			addChild(ico);
			addChild(hpBar);
			tfValue.x = ico.width / 2 - tfValue.width / 2;
			tfValue.y = ico.height / 2;
			hpBar.addEventListener(Event.ENTER_FRAME, updateHpBar);
			addEventListener(MouseEvent.ROLL_OVER, showHpBar);
			addEventListener(MouseEvent.ROLL_OUT, hideHpBar);
			hpBar.alpha = 0;
			tfName.y = (ico.height - tfName.height) + 3;
			tfName.x = (tfName.width / 2 - ico.width / 2) - 30;
			tfName.textColor = 0xffffff;
			tfName.text = mob.getName();
			tfAttack.y = tfName.y + tfName.height + 3; 
			tfAttack.x = tfValue.x; 
			addChild(tfName);
			effectsSprite.y = -2;
			STATIC_DIM.w = 31;
			STATIC_DIM.h = 31;
		}
		private function showInfo(e:MouseEvent):void{
		}
		public function replaceBitmapData(newBmd:BitmapData):void{
			bitmapData = newBmd;
			ico.changeBitmapData(newBmd);
			ico.changeDefaultData(newBmd);
		}
		public function effectsHandle():void
		{
				if (turnOnEffect)
				{
					tfValue.alpha = 1;
					tfAttack.alpha = 1; 
					nFlicker++;
					if (nFlicker < 8)
					{
						if (colored)
						{
							if (nFlicker % 2 == 0)
							{
								ChangeColor(ico, flickerColor);
							}
							else
							{
								ico.transform.colorTransform = new ColorTransform();
							}
						}
						tfValue.y -= 4.5;
					}
					else
					{
						turnOnEffect = false;
					}
					setTimeout(effectsHandle, 50); 
				}
				else
				{
					RemoveSprite(tfValue);
					RemoveSprite(tfAttack);
					tfValue.alpha = 0;
					tfAttack.alpha = 0;
					tfAttack.text = ""; 
					tfValue.text = "";
					nFlicker = 0;
					ico.transform.colorTransform = new ColorTransform();
					tfValue.y = ico.height / 2;
					colored = false;
					animateOn = false 
				}
			
			if (mob.getHp() <= 0 && getCellLocation() != null)
			{
				getCellLocation().addBloodStain();
				getCellLocation().clearPiece();
				resetBattlePiece();
				isDead = true;
			}
			
		}
		
		public function getTextName():TextField
		{
			return tfName;
		}
		
		public function getIcon():Sprite
		{
			return ico;
		}
		
		public function setMob(_mob:Mob):void
		{
			mob = _mob;
			tfName.text = mob.getName();
			ico = mob.getIcon();
		}
		
		public function setIco(_ico:Sprite):void
		{
			ico = new SpriteWrapper(SpriteToBitmapData(_ico)); 
			addChild(ico);
		}
		
		public function resetBattlePiece():void
		{
			ico.transform.colorTransform = new ColorTransform();
			RemoveSprite(tfValue)
			RemoveSprite(tfAttack)
			RemoveSprite(this);
			x = 0;
			y = 0;
			width = 60
			height = 44
		}
		public function resetDimensions():void{
			width = 60
			height = 44
		}
		public function putIconBack():void{
			addChild(ico);
			addChild(tfName);
		}
		
		public function addEffect(effectStr:String):void
		{
			effectStr = effectStr.toLowerCase();
			var spr:Sprite = ConvertEmbedToSprite(effectsList[effectStr]);
			effectsIco[effectStr] = spr;
			effectsIco[effectStr].width = 16
			effectsIco[effectStr].height = 14
			if (effectStr == "poisoned")
			{
				showPoisoned();
			}
			else if (effectStr == "frozen")
			{
				showFrozen();
			}
			else if (effectStr == "stunned")
			{
				showStunned();
			}
			else if (effectStr == "burning")
			{
				showBurning();
			}
			else if (effectStr == "bleeding")
			{
				showBleeding();
				location.addBloodStain();
			}
			showEffects();
		}
		
		public function showEffects():void
		{
			var begY:int = ico.y - 16 - 20;
			var begX:int = ico.x - 25;
			var currentIco:Sprite = null;
			for (var i:* in effectsIco)
			{
				currentIco = effectsIco[i];
				if (currentIco != null)
				{
					if (begX >= ((currentIco.width + 6) * 2) - 30)
					{
						begX = ico.x - 25;
						begY -= (currentIco.height + 10);
					}
					begX += currentIco.width + 6;
					currentIco.y = begY;
					currentIco.x = begX;
					effectsSprite.addChild(currentIco);
				}
			}
		}
		
		public function removeEffects():void
		{
			RemoveSprite(effectsSprite);
		}
		
		public function removeEffectName(effectStr:String):void
		{
			if (effectsIco[effectStr] != null)
			{
				
				RemoveSprite(effectsIco[effectStr]);
				effectsIco[effectStr] = null;
			}
		}
		
		public function removeEffectsPerm():void
		{
			for (var i:* in effectsIco)
			{
				if(effectsIco[i] != null){
					effectsIco[i] = null;
				}
			}
			
			while (effectsSprite.numChildren > 0)
			{
				effectsSprite.removeChildAt(0);
			}
		}
		
		public function getCellLocation():Cell
		{
			return location;
		}
		
		public function getFieldLocation():Object
		{
			return fieldLoc;
		}
		
		public function changeCellLocation(newLocation:Cell):void
		{
			location = newLocation;
			var cellLoc:Object = location.getLocation();
			fieldLoc = cellLoc;
		}
		
		public function changeFieldLoc(rowChange:int, colChange:int):void
		{
			fieldLoc.row += rowChange;
			fieldLoc.col += colChange;
		}
		
		public function setFieldLoc(rowChange:int, colChange:int):void
		{
			fieldLoc = {row: rowChange, col: colChange};
		}
		
		private function showHpBar(e:MouseEvent):void
		{
			if (boolShowHpBar)
			{
				hpBar.alpha = 1;
				showEffects();
				var cellLocation:Cell = getCellLocation();
				var cellIndex:int = cellLocation.parent.getChildIndex(cellLocation)
				var cellPoint:Point = new Point(getCellLocation().x, getCellLocation().y);
				cellLocation.parent.swapChildrenAt( cellIndex, cellLocation.parent.numChildren - 1); 
				effectsSprite.x = hpBar.x; 
				effectsSprite.y = -1; 
				addChild(effectsSprite);
			}
		
		}
		
		public function activateHpBar():void
		{
			boolShowHpBar = true;
		}
		
		public function deactivateHpBar():void
		{
			boolShowHpBar = false;
		}
		
		private function hideHpBar(e:MouseEvent):void
		{
			hpBar.alpha = 0;
			removeEffects();
			RemoveSprite(effectsSprite);
		}
		
		private function takeDamage(color:Number = 0xff0000):void
		{
			flickerColor = color;
			//flickerTimer.start();
			if (Mob(mob).mobType.toLowerCase() == "enemy")
			{
				SndLib.hurtSnd();
			}
			else
			{
				SndLib.manHurt();
			}
		}
		
		private function updateHpBar(e:Event):void
		{
			var percentage:Number = mob.getHp() / mob.getMaxHp();
			if (ico != null)
			{
				hpBar.width = percentage * ico.width + 1
			}
		}
		
		public function parried():void
		{
			tfValue.text = "Parried!";
			tfValue.textColor = 0xffffff;
			valueAnimation();
		}
		public function showFear():void{
			tfValue.text = "Afraid!";
			tfValue.textColor = 0xffffff;
			valueAnimation();
		}
		public function showRage():void
		{
			tfValue.text = "Rage";
			tfValue.textColor = 0x000000;
			valueAnimation();
			takeDamage(0xffffff);
		}
		
		public function showStunned():void
		{
			tfValue.text = "stunned";
			tfValue.textColor = 0xffdd00;
			valueAnimation();
			takeDamage(0xffdd00);
		}
		
		public function showFrozen():void
		{
			tfValue.text = "frozen";
			tfValue.textColor = 0x3366ff;
			valueAnimation();
			takeDamage(0x3366ff);
		}
		
		public function showDamage(n:int):void
		{
			if (!mob.isParrying())
			{
				tfValue.text = n.toString();
				tfValue.textColor = 0xff0000;
				valueAnimation();
				flickerColor = 0xff0000;
				colored = true;
			}
			else
			{
				parried();
				mob.removeParry()
			}
		}
		
		public function showPowerUp(str:String):void
		{
			tfAttack.text = str + " up!";
			tfAttack.textColor = 0x00ff00;
			valueAnimation();
		}
		
		public function showPowerDown(str:String):void
		{
			tfAttack.text = str + " down!";
			tfAttack.textColor = 0xff0000;
			valueAnimation();
		}
		
		public function showHeal(n:int):void
		{
			//tfAttack.text = n.toString();
			//tfAttack.textColor = 0x00ff00;
			valueAnimation();
			SndLib.heal();
			flickerColor = (0x00ff00);
			colored = true;
		}
		
		public function showAnointed():void
		{
			valueAnimation();
			flickerColor = (0x00ff00);
			colored = true;
			
		}
		
		public function showAnointer():void
		{
			tfAttack.text = "Anoint";
			tfAttack.textColor = 0x00ff00;
			valueAnimation();
			flickerColor = (0x00ff00);
			colored = true;
		}
		
		public function showPoisoned():void
		{
			tfAttack.text = "Poisoned";
			tfAttack.textColor = 0xFF00FF;
			valueAnimation();
			flickerColor = (0xFF00FF);
			colored = true;
		}
		public function showSlipped():void{
			tfValue.text = "Slipped!";
			tfValue.textColor = 0xffffff; 
			valueAnimation();
		}
		
		public function showBleeding():void
		{
			tfAttack.text = "Bleeding";
			tfAttack.textColor = 0xff0000;
			valueAnimation();
			flickerColor = (0xff0000);
			colored = true;
		}
		
		public function showBurning():void
		{
			tfAttack.text = "Burning";
			tfAttack.textColor = 0xCC9900
			valueAnimation();
			flickerColor = (0xCC9900);
			colored = true;
		}
		
		public function showAttackCry(cry:String, color:Number = 0xffffff):void
		{
			tfAttack.text = cry;
			tfAttack.textColor = color
			valueAnimation();
		}
		
		public function glow(color:Number):void
		{
			var glowFilter:GlowFilter = new GlowFilter(color, 1, 3, 3, 2, 3);
			ico.filters = [glowFilter];
		}
		
		private function glowAnimation(e:TimerEvent):void
		{
			var i:int = e.currentTarget.currentCount;
			if (tfValue.y >= 10)
			{
				RemoveFilters(ico);
				e.currentTarget.reset();
			}
		}
		
		private function valueAnimation():void
		{
			
			
			var lineWidth:int = tfValue.textWidth;
			tfValue.x = ((location.width / 2 - tfValue.width / 2) + location.x) - 10
			tfValue.y = location.y;
			location.parent.addChild(tfValue);
			location.parent.parent.addChild(tfAttack);
			turnOnEffect = true;
			
			initialFlicker = getTimer(); 
			flickerDifference = initialFlicker + 500; 
			tfAttack.y = location.y + location.height / 2 + 4
			if (tfAttack.width <= location.width){
					tfAttack.x = ((tfAttack.width / 2 - location.width / 2) + location.x)
			}
			else{
				tfAttack.x = ((location.width / 2) + location.x) - tfAttack.width/4
			}
		
			effectsHandle();
		
		}
		public function getBitmapData():BitmapData{
			return bitmapData;
		}
	
	}

}