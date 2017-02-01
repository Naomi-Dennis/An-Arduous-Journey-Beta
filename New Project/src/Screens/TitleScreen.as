package Screens
{
	import Assets.Effects.DropShadow;
	import Screens.OptionScreen;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Assets.Utility.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.globalization.LastOperationStatus;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import mobs.PlayersLibrary;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TitleScreen extends Sprite
	{
		[Embed(source = "../pics/backgrounds/dark background.png")]
		private var titleBkgrnd:Class;
		private var bkgrnd:Sprite = new Sprite();
		private var title_tf:TextField = DrawText("An Arduous Journey", 40, "center",  "unzialish");
		private var beginBtn:Sprite = DrawButton("Begin", 28);
		private var continueBtn:Sprite = DrawButton("Continue", 28);
		private var optionsBtn:Sprite = DrawButton("Options", 24);
		private var tutorial:Sprite = DrawButton("Tutorial", 28);
		private var cpyright:TextField = DrawText("Developed by Naomi Dennis", 12, "center");
		private var df:TextFormat = new TextFormat();
		private var par:*;
		private var overshadow:Sprite = DrawSquare(540, 540);
		private var map:Map = new Map();
		private var battle:BattleClass;
		private var fireflyEffect:FireFlyEffect = new FireFlyEffect();
		public function TitleScreen()
		{
			
			par = Main;
			bkgrnd = ConvertEmbedToSprite(titleBkgrnd);
			bkgrnd.y = 40;
			bkgrnd.width = 540;
			bkgrnd.height = 450;
			
			CenterObjRelTo(title_tf, bkgrnd);
			CenterObjRelTo(continueBtn, bkgrnd);
			CenterObjRelTo(beginBtn, title_tf);
			CenterObjRelTo(optionsBtn, title_tf);
			CenterObjRelTo(tutorial, title_tf);
			
			title_tf.y = 80;
			PlaceObjBelowRel(continueBtn, title_tf, 60);
			PlaceObjBelowRel(beginBtn, title_tf, 60);
			PlaceObjBelowRel(optionsBtn, beginBtn, 20);
			
			cpyright.y = 540 - cpyright.height - 5;
			tutorial.y = optionsBtn.y;
			addChild(bkgrnd);
			addChild(title_tf);
			addChild(cpyright);
			addChild(fireflyEffect);
			DropShadow(title_tf); 
			//addChild(tutorial);
			if (Main.checkIfGameExist())
			{
				addChild(continueBtn);
			}
			else
			{
				addChild(beginBtn);
			}
			optionsBtn.addEventListener(MouseEvent.CLICK, optionsGame);
			beginBtn.addEventListener(MouseEvent.CLICK, newGame);
			continueBtn.addEventListener(MouseEvent.CLICK, loadGame);
			tutorial.addEventListener(MouseEvent.CLICK, goToTutorial);
		}
		
		private function newGame(e:MouseEvent):void
		{
			addMap();
		}
		
		private function addMap():void
		{
			this.parent.addChild(map);
			this.addEventListener(Event.REMOVED_FROM_STAGE, loadMapLevels);
			RemoveSprite(this);
		
		}
		
		private function loadMapLevels(e:Event):void
		{
			map.loadLevels(Main.glblPlayer.missionStatuses);
		}
		
		private function loadGame(e:MouseEvent):void
		{
			Main.loadGame();
			addMap();
		}
		
		private function optionsGame(e:MouseEvent):void
		{
			var options:OptionScreen = new OptionScreen();
			CenterObjRelTo(options, bkgrnd);
			options.y = 540 / 2 - options.height;
			options.addEventListener(Event.REMOVED_FROM_STAGE, removeOptions);
			overshadow.alpha = 0.4;
			addChild(overshadow);
			addChild(options);
		}
		
		private function removeOptions(e:Event):void
		{
			RemoveSprite(overshadow);
		}
		
		private function goToTutorial(e:MouseEvent):void
		{
			//This is just the battle tutorial.
			var bkgrnd:Object = BackgroundList.swamp();
			battle = new BattleClass(bkgrnd.field, [PlayersLibrary.Goury(), PlayersLibrary.createLina()], [new (EnemiesList.bandit())(), new (EnemiesList.bandit())()], bkgrnd.background, true);
			battle.setNextFoo(notify);
			battle.signalFight();
			addChild(battle);
		
		}
		
		private function notify():void
		{
			RemoveSprite(battle);
			var notifyWin:TownDescriptionScreen = new TownDescriptionScreen(null, "That's the gist of the battle system. \n\nYou can play the tutorial as often as you'd like, when you are ready to start the campaign click 'Begin'");
			CenterObjRelTo(notifyWin, this);
			notifyWin.y = 540 / 2 - notifyWin.height / 2;
			addChild(notifyWin);
		}
	}

}
import flash.display.Sprite;
import Assets.Utility.GlowObj;
import flash.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;

class FireFlyEffect extends Sprite
{
	private var flies:Array = [];
	public function FireFlyEffect():void
	{
		addEventListener(Event.REMOVED_FROM_STAGE, stopTimers);
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	private function init(e:Event):void{
		createFly();
	}
	private function stopTimers(e:Event):void{
		removeEventListener(Event.ENTER_FRAME, spriteGrowing);
		for (var i:* in flies){
			flies[i].dirTimer.stop();
			flies[i].dirTimer.removeEventListener(TimerEvent.TIMER, flies[i].timerHandle)
		}
	}
	
	public function createSpr(r:int = 1):Sprite
	{
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(0xffdd00);
		spr.graphics.drawCircle(0, 0, 1);
		spr.graphics.endFill();
		spr.alpha = .4;
		GlowObj(spr, 0xffdd00, 10, 8, 8, 1);
		return spr;
	}
	
	public function createFly():Object
	{
		var obj:Object = {spr: createSpr(), degree: 0, grow: false, dirTimer: new Timer(6000), timerHandle: null};
		obj.timerHandle = changeDirectionHandle(obj)
		obj.dirTimer.addEventListener(TimerEvent.TIMER, obj.timerHandle);
		obj.dirTimer.start();
		obj.spr = createSpr(randRadius)
		obj.spr.x = (Math.random() * (500 - 10)) + 100;
		obj.spr.y = (Math.random() * (500 - 10)) + 100;
		
		var randRadius:int = (Math.random() * (6 - 1)) + 1;
		
		obj.degree = Math.floor(Math.random() * (360 - 1)) + 1
		return obj;
	}
	
	public function createFlies():void
	{
		var n:int = 15;
		var fly:Object = {};
		var rand:int;
		for (var i:int = 0; i < n; i++)
		{
			fly = createFly();
			rand = (Math.random() * (100 - 0)) + 0;
			if (i % 3 == 0)
			{
				fly.grow = true;
			}
			growSprite(fly);
			flies.push(fly);
			addChild(flies[i].spr);
		}
	}
	
	public function growSprite(obj:Object):void
	{
		
		addEventListener(Event.ENTER_FRAME, spriteGrowing);
	}
	
	public function spriteGrowing(e:Event):void
	{
		var spr
		var obj
		for (var i:* in flies)
		{
			spr = flies[i].spr;
			obj = flies[i];
			spr.x += Math.cos(obj.degree) * .6
			spr.y += Math.sin(obj.degree) * .6;
			if (spr.x < 0 || spr.x > 500 || spr.y < 0 || spr.y > 500)
			{
				obj.degree *= -1;
			}
			if (obj.grow)
			{
				if (spr.height < 6)
				{
					spr.width += 0.10;
					spr.height += 0.10;
				//	spr.alpha += 0.01; 
				}
				else
				{
					obj.grow = false;
				}
			}
			else
			{
				if (spr.height > 0)
				{
					spr.height -= .1;
					spr.width -= .1;
				//	spr.alpha -= .01;
				}
				else
				{
					obj.grow = true;
				}
			}
		}
	}
	
	public function changeDirection(spr:Object):void
	{
		spr.timer.start();
	}
	
	public function changeDirectionHandle(fly:Object):Function
	{
		return function(e:TimerEvent):void
		{
			fly.degree = Math.floor(Math.random() * (360 - 1)) + 1
		}
	}
}