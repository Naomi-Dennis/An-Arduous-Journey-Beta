package 
{
	import flash.display.Sprite;
	import mobs.Enemies.*
	import mobs.Players.*
	/**
	 * ...
	 * @author Naomi J. Dennis

	 */
	public class LevelTemplate extends Sprite
	{
		
		[Embed(source="battles/Prison/background.png")]
		private var prisonImg:Class; 
		[Embed(source="battles/Sewers.png")]
		private var sewersImg:Class; 
		[Embed(source="battles/Crypt/crypt.png")]
		private var cryptImg:Class; 
		[Embed(source="battles/StrangePlace/bkgrnd.png")]
		private var strangePlaceImg:Class; 
		[Embed(source = "battles/Hell.png")]
		private var hellImg:Class; 
		private var player:*;
		private var enemies:Array = [];
		private var field:Field = new Field();
		private var battleClass:BattleClass; 
		private var nextFoo:Function; 
		private var bkgrnd:Class; 
		private var prompt:String = "";
		public function LevelTemplate(_player:*, _enemies:Array,  setting:String = "", _prompt:String="") 
		{
			
			enemies = _enemies;
			player = _player; 
			prompt = _prompt; 
			setBackground(setting); 
			/*
			field.createPrisonField();
			
			battleClass = new BattleClass(field, [player], [ bandit2 ], bkgrnd); 
			
			battleClass.showFightSignal(11, "");
			addChild(battleClass);
			*/
		}
		public function setBackground(str:String):void {
			str = str.toLowerCase();
			if (str == "prison") {
				bkgrnd = prisonImg; 
				field.createPrisonField();
			}
			else if (str == "sewer") {
				bkgrnd = sewersImg; 
				field.createDirtField();
			}
			else if (str == "crypt") {
				bkgrnd = cryptImg;
				field.createPrisonField();
			}
			else if (str == "strange") {
				bkgrnd = strangePlaceImg;
				field.createCobblestoneField();
			}
			else if (str == "hell") {
				bkgrnd = hellImg;
				field.createFireField();
			}
		}
		public function loadBattle(lvlNum:int):void {
			battleClass = new BattleClass(field, [player], enemies , bkgrnd); 
			battleClass.showFightSignal(lvlNum, prompt);
			addChild(battleClass);
		}
		public function setNextFoo(foo:Function):void {
			nextFoo = foo; 
			battleClass.setNextFoo(nextFoo);
		}
		
	}

}