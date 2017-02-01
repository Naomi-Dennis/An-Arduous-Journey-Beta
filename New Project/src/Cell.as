package
{
	import Assets.Utility.AddSound;
	import Assets.Utility.CenterObjRelTo;
	import Assets.Utility.ChangeColor;
	import Assets.Utility.ConvertEmbedToBitmapData;
	import Assets.Utility.ConvertEmbedToSprite;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.DrawBorder;
	import Assets.Utility.DrawSquare;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.SpriteToBitmapData;
	import Assets.Utility.Swap;
	import flash.display.BitmapData;
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import Assets.Utility.GlowObj;
	import Assets.Utility.RemoveFilters;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class Cell extends SpriteWrapper
	{
		public var bkgrnd:Sprite = new Sprite();
		public var border:Sprite = new Sprite();
		public var highlightSpr:Sprite = new Sprite();
		public var cell_type:String = "FLOOR";
		public var currentColor:Number = 0x0044400;
		[Embed(source="pics/floor/grass_flowers_yellow1.png")]
		public var grass_flowers:Class;
		[Embed(source="pics/floor/grass0.png")]
		public var grass:Class;
		[Embed(source="pics/floor/grass0-dirt-mix1.png")]
		public var grass_dirt:Class;
		[Embed(source="pics/floor/stone_brick12.png")]
		public var stone_brick:Class;
		[Embed(source="pics/floor/stone_brick6.png")]
		public var stone_brick_broken:Class;
		[Embed(source="pics/floor/tree1_yellow.png")]
		public var tree:Class;
		[Embed(source="pics/floor/tutorial_pad.png")]
		public var tutorial_pad:Class;
		[Embed(source="pics/floor/cobble_blood4.png")]
		public var cobblestone:Class;
		[Embed(source="pics/floor/cobble_blood12.png")]
		public var cobblestoneBlood:Class;
		[Embed(source="pics/floor/dirt2.png")]
		public var dirt:Class;
		[Embed(source="pics/floor/hive0.png")]
		public var mudFloor:Class;
		[Embed(source="pics/floor/volcanic_wall0.png")]
		public var hellCell:Class;
		[Embed(source="pics/floor/tree1_yellow.png")]
		public var yellowTree:Class;
		[Embed(source = "pics/floor/tree2_red.png")]
		public var redTree:Class; 
		[Embed(source = "pics/floor/sandstone_floor1.png")]
		public var prisonFloor:Class; 
		[Embed(source = "pics/floor/mesh2.png")]
		public var meshFloor:Class; 
		[Embed(source = "pics/blood_red3.png")]
		private var bloodstain:Class; 
		
		public var WALL_TYPE:Object = {cell_type: "WALL", cell_color: 0x777777}
		public var FLOOR_TYPE:Object = {cell_type: "FLOOR", cell_color: 0x004400}
		public var GRASS_FLOWERS:Object = {imgClass: grass_flowers};
		public var GRASS:Object = {imgClass: grass};
		public var GRASS_DIRT:Object = {imgClass: grass_dirt};
		public var STONE_BRICK:Object = {imgClass: stone_brick};
		public var STONE_BRICK_BROKEN:Object = {imgClass: stone_brick_broken};
		public var TREE:Object = {imgClass: tree};
		public var COBBLESTONE:Object = {imgClass: cobblestone};
		public var DIRT:Object = {imgClass: dirt};
		public var PRISON:Object = {imgClass: prisonFloor};
		public var HELL:Object = {imgClass: hellCell};
		public var YELLOW_TREE:Object = {imgClass: yellowTree};
		public var RED_TREE:Object = { imgClass: redTree };
		public var PRISON_FLOOR:Object = { imgClass: prisonFloor }; 
		public var COBBLE_BLOOD:Object = { imgClass: cobblestoneBlood }; 
		public var MESH_FLOOR:Object = {imgClass: meshFloor };
		public var MUD_FLOOR:Object = {imgClass: mudFloor }; 
		private var POISON_STATE:Object = {imgClass:new EffectsIco(0x9900ff), type:"POISON"}; 
		private var FIRE_STATE:Object = {imgClass:new EffectsIco(0xff9933), type:"FIRE"};
		private var FROZEN_STATE:Object = {imgClass:new EffectsIco(0x0066ff, false), type:"FROZEN"}; 
		private var cell_state_icon:Sprite = new Sprite(); 
		public var cell_state:String = ""; 
		public var tentDistance:int = 1;
		public var canMove:Boolean = false;
		public var canAttack:Boolean = false;
		public var loc:Object = {row: 0, col: 0};
		public var subAttack:Boolean = false; 
		public var piece_spr_full:Boolean = false; 
		public var currentType:Object = {imgClass: null};
		public var currentPiece:BattlePiece = null;
		public var pieceSpr:BitmapData = new BitmapData(32, 32);
		public var visited:Boolean = false;
		public var dirNeighbors:Object = {"north": null, "south": null, "east": null, "west": null};
		public var point:Point = new Point();
		public var neighbors:Array = [];
		public var prev:Cell = null;
		public var tileSize:Object = {width: 32, height: 32};
		public var hDistance:int = 0;
		public var gDistance:int = 0
		public var timer:Timer = new Timer(1000);
		public var isIndicator:Boolean = false;
		public var currentForeground:Object;
		private var bloodStainImg:Sprite = new Sprite(); 
		public var clearSlate:Boolean = false; 
		private var initTime:int; 
		private var difference:int = 0;
		private var hasBloodStain:Boolean = false; 
		private var currentBattlePiece:BattlePiece; 
		public var default_type:Boolean = false; 
		public function Cell(pos:Object = null)
		{
			loc = pos;
			bkgrnd = DrawSquare(tileSize.width, tileSize.height, 0x00aa00);
			highlightSpr = DrawSquare(tileSize.width, tileSize.height, 0xffdd00);
			highlightSpr.alpha = 0.0;
			border.graphics.lineStyle(1, 0xffffff, 1);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(tileSize.width, 0);
			border.graphics.lineTo(tileSize.width, tileSize.height);
			border.graphics.lineTo(0, tileSize.height);
			border.graphics.lineTo(0, 0);
			border.alpha = 0.0;
			alpha = 1; 
			//generateWalls();
			addEventListener(MouseEvent.MOUSE_OVER, highlight);
			addEventListener(MouseEvent.MOUSE_OUT, unHighlight);
			
		}

		public function addBloodStain():void{
			if(!hasBloodStain){
				var bloodStainBmd:BitmapData = ConvertEmbedToBitmapData(bloodstain);
				addToBitmapData(bloodStainBmd, "bloodstain");
			}
		}
		public function isImmooveableObject():Boolean
		{
			return tentDistance > 1;
		}
		
		public function createTree():void
		{
			var rand:int = RandomNumber(100, 0);
			tentDistance = 99;
			if (rand <= 50)
			{
				currentForeground = RED_TREE;
				addForeground();
			}
			else
			{
				currentForeground = YELLOW_TREE
				addForeground();
			}
		}
		
		public function createCobblestoneFloor():void
		{
			tentDistance = 1;
			changeCellType(COBBLESTONE);
		}
		
		public function createGrassFloor():void
		{
			tentDistance = 1;
			changeCellType(GRASS);
		}
		
		public function createFadedGrassFloor():void
		{
			tentDistance = 1;
			changeCellType(GRASS_DIRT);
		}
		public function createMudFloor():void{
			tentDistance = 1; 
			changeCellType(MUD_FLOOR);
		}
		public function createGrassFlowers():void
		{
			tentDistance = 1;
			changeCellType(GRASS_FLOWERS);
		}
		public function createMeshFloor():void{
			tentDistance = 1;
			changeCellType(MESH_FLOOR);
		}
		public function createDirtFloor():void
		{
			tentDistance = 1;
			changeCellType(DIRT);
		}
		
		public function createBloodyCobblestone():void {
			tentDistance = 1;
			changeCellType(COBBLE_BLOOD);
		}
		
		public function createPrisonFloor():void
		{
			tentDistance = 1;
			changeCellType(PRISON);
		}
		public function getCellState():String{
			return cell_state.toLowerCase(); 
		}
		public function setVonNeighborsToElement(string:String):void{
			var currentNeighbor:Cell; 
			for (var i:* in neighbors){
				currentNeighbor = neighbors[i]; 
				if(string == "fire"){
					currentNeighbor.setFireState();
				}
				else if (string == "poison"){
					currentNeighbor.setPoisonState();
				}
				else if (string == "ice"){
					currentNeighbor.setFrozenState(); 
				}
			}
		}
		private function setCellState(state:Object):void{
			cell_state = state.type;
			cell_state_icon = state.imgClass
		}
		public function setPoisonState():void{
			setCellState(POISON_STATE); 
		}
		public function setFireState():void{
			setCellState(FIRE_STATE);
		}
		public function setFrozenState():void{
			setCellState(FROZEN_STATE); 
		}
		public function clearCellState():void{
			cell_state = "";
			cell_state_icon = new Sprite(); 
		}
		public function createHellFloor():void
		{
			tentDistance = 2; 
			changeCellType(HELL);
		}
		
		public function cantDoAnything():void
		{
			ChangeColor(bkgrnd, 0xff0000);
			currentColor = 0xff0000;
		}
		
		public function highlightCellAsTurn():void
		{
			Field(this.parent).swapChildren(this, Field(this.parent).getChildAt(this.parent.numChildren - 1));
			border.alpha = 1;
			addChildAt(border, numChildren);
			isIndicator = true;
		}
		public function unHighlightCellAsTurn():void{
			RemoveSprite(border); 
		}
		private function autoChangeStatus(e:Event):void{
			if (canMove){
				isPath();
			}
		}
		public function flashCellHighlight():void
		{
			if(isIndicator){
				if (initTime %  2 == 0)
				{
					border.alpha = 1;
				}
			}
			
		}
		
		public function restoreCell():void
		{
			hDistance = 0;
			canMove = false;
			canAttack = false;
			subAttack = false; 
			prev = null;
			visited = false;
			(!isIndicator) ? border.alpha = 0.0 : highlightCellAsTurn();
			removeColor();
			reset();
		}
		public function resetToDefault():void{
			clear();
			clearCellState();
			hasBloodStain = false; 
			restoreCell();
		}
		
		public function clearIndicator():void
		{
			RemoveSprite(border);
			isIndicator = false;
		}
		
		public function isMoveable():Boolean
		{
			return canMove;
		}
		
		public function isAttackable():Boolean
		{
			return canAttack;
		}
		public function isSubAttackable():Boolean{
			return subAttack;
		}
		
		public function canMoveHere():void
		{
			canMove = true;
			isPath();
		}
		
		public function canAttackHere():void
		{
			canAttack = true;
			isPath();
		}
		public function canSubAttackHere():void{
			canAttack = false; 
			subAttack = true;
			isPath();
		}
		
		public function getPiece():BattlePiece
		{
			if(piece_spr_full){
				return currentBattlePiece
			}
			else{
				return null;
			}
		}
		
		// end constructor // 
		public function getLocation():Object
		{
			return loc;
		}
		
		public function setPiece(piece:BattlePiece):void
		{
			if (currentType == GRASS || currentType == DIRT || currentType == GRASS_DIRT || currentType == GRASS_FLOWERS)
			{
				SndLib.walkingSnd();
			}
			currentBattlePiece = piece; 
			addChild(currentBattlePiece);
			currentBattlePiece.y = 0; 
			piece.activateHpBar();
			piece_spr_full = true; 
			piece.changeCellLocation(this);
			tentDistance = 5;
			changeCellType(currentType);
			transform.colorTransform = new ColorTransform();
		}
		// end set piece // 
		public function hasPiece():Boolean
		{
			return piece_spr_full; 
		}
		
		// end has piece //
		public function clearPiece():void
		{
			RemoveSprite(currentBattlePiece);
			isIndicator = false;
			piece_spr_full = false; 
			tentDistance = 1; 
			changeCellType(currentType);
		}
		
		// end clear piece //
		public function generateWalls():void
		{
			var rand:int = RandomNumber(100, 0);
			if (rand <= 5)
			{
				changeType(WALL_TYPE);
			}
		}
		
		// end generate walls // 
		public function highlight(e:MouseEvent):void
		{
			var currentCell:Cell = e.currentTarget as Cell;
			if (!currentCell.hasPiece()){
				this.alpha = 0.3; 
			}
		}
		
		// end highlight // 
		public function unHighlight(e:MouseEvent):void
		{
			var currentCell:Cell = e.currentTarget as Cell;
			if (!currentCell.hasPiece()){
				this.alpha = 1;
			}
		}
		
		public function isWall():Boolean
		{
			return cell_type == "WALL";
		}
		
		// end unhighlight // 
		public function changeType(type:Object):void
		{
			cell_type = type.cell_type;
			currentColor = type.cell_color;
			var newBmd:BitmapData = ConvertEmbedToBitmapData(cell_type); 
			changeBitmapData(newBmd);
			this.applyColor(currentColor);
		}
		
		// end change type // 
		public function getSortedNeighbors(goal:Point):Array
		{
			var sortedData:Array = []; // vec of { str : num }
			var sortedNeighbors:Array = [];
			if (dirNeighbors.north != null && dirNeighbors.north.tentDistance == 1)
			{
				var distNorth:Number = distanceFormula(dirNeighbors.north.point, goal);
				sortedData.push(["north", distNorth]);
			}
			else
			{
				
			}
			if (dirNeighbors.south != null && dirNeighbors.south.tentDistance == 1)
			{
				var distSouth:Number = distanceFormula(dirNeighbors.south.point, goal);
				sortedData.push(["south", distSouth]);
			}
			else
			{
				
			}
			if (dirNeighbors.east != null && dirNeighbors.east.tentDistance == 1)
			{
				var distEast:Number = distanceFormula(dirNeighbors.east.point, goal);
				sortedData.push(["east", distEast]);
			}
			else
			{
				
			}
			if (dirNeighbors.west != null && dirNeighbors.west.tentDistance == 1)
			{
				var distWest:Number = distanceFormula(dirNeighbors.west.point, goal);
				sortedData.push(["west", distWest]);
			}
			else
			{
				
			}
			for (var i:*in sortedData)
			{
				for (var j:*in sortedData)
				{
					if (sortedData[i][1] > sortedData[j][1])
					{
						Swap(sortedData, i, j);
					}
				}
			}
			var currentDir:String = "";
			for (var k:*in sortedData)
			{
				currentDir = sortedData[k][0];
				sortedNeighbors.push(dirNeighbors[currentDir]);
			}
			
			return sortedNeighbors;
		}
		
		// end get sorted neighbors // 
		public function distanceFormula(pointA:Point, pointB:Point):Number
		{
			/////////////^^^^^^^^^^^^^^/////////////////////////////////////
			var distX:Number = pointA.x - pointB.x
			distX = Math.pow(distX, 2);
			var distY:Number = pointA.y - pointB.y;
			distY = Math.pow(distY, 2);
			var dist:Number = distX + distY;
			dist = Math.sqrt(dist);
			return dist;
		}
		
		// end distance formula // 
		public function addNeighbors(map:Array):void
		{
			////////////^^^^^^^^^^^^//////////////////
			point = new Point(loc.col, loc.row);
			
			var cols:int = loc.col;
			var rows:int = loc.row;
			
			var north:int = rows - 1;
			var south:int = rows + 1;
			var east:int = cols + 1;
			var west:int = cols - 1;
			//north neighbor
			if (north >= 0)
			{
				neighbors.push(map[north][cols]);
				dirNeighbors.north = map[north][cols];
			}
			
			//south
			if (south < map.length)
			{
				neighbors.push(map[south][cols]);
				dirNeighbors.south = map[south][cols];
			}
			//west
			if (west >= 0)
			{
				neighbors.push(map[rows][west]);
				dirNeighbors.west = map[rows][west];
			}
			
			//east 
			if (east < map[0].length)
			{
				neighbors.push(map[rows][east]);
				dirNeighbors.east = map[rows][east];
			}
		}
		
		// end add neighbors // 
		public function getTentDistance():int{
			return tentDistance
		}
		public function isPath():void
		{
			//////////// Note that the cell is a path ////////////////////////
				if (canMove)
				{
					applyColor(0x145A32);
					this.alpha = 1;
				}
				else if (canAttack)
				{
					applyColor(0x0066ff);
					this.alpha = 1;
				}
				else if (subAttack){
					applyColor(0xBB8FCE);
					this.alpha = 1;
				}
		}
		
		// end isPath // 
		public function reset():void
		{
			///////////// change it back to the current color /////////////
			changeToDefaultColor();
		}
		
		// end reset //
		public function changeToDefaultColor():void
		{
			changeCellType(currentType);
		}
		
		public function changeCellType(newType:Object):void
		{
			if(!default_type){
				var newBmd:BitmapData = ConvertEmbedToBitmapData(newType.imgClass);
				changeDefaultData(newBmd);
				changeBitmapData(newBmd);
				default_type = true; 
			}
			if (cell_state != ""){
				addToBitmapData( SpriteToBitmapData(cell_state_icon), "cell_state"); 
			}
			if (!clearSlate && hasBloodStain){
				addToBitmapData(ConvertEmbedToBitmapData(bloodstain), "bloodstain"); 
			}
			
			if (piece_spr_full){
				RemoveSprite(currentBattlePiece);
				addChild(currentBattlePiece);
			}
			
			if (currentForeground != null){
				addToBitmapData(ConvertEmbedToBitmapData(currentForeground.imgClass), "foreground");
			}
		}
		
		public function addForeground():void
		{
			if (tentDistance > 1 && !hasPiece())
			{
				var frgrnd:BitmapData = ConvertEmbedToBitmapData(currentForeground.imgClass);
				if(!default_type){
					addToBitmapData(ConvertEmbedToBitmapData(currentForeground.imgClass), "foreground");
				}
			}
			changeCellType(currentType);
		}
//* */;
	}

}
import Assets.Utility.DrawSquare;
import flash.events.Event;
import flash.display.Sprite; 
class EffectsIco extends Sprite{
	private var color:Number; 
	private var nFrame:int = 0; 
	public function EffectsIco(_color:Number, flicker:Boolean = true){
		var sqr:Sprite = DrawSquare(32, 32, _color) 
		sqr.alpha = 0.3; 
		addChild(sqr); 
		
	}
	private function activate(e:Event):void{
		//addEventListener(Event.ENTER_FRAME, animate); 
	}
	private function deactivate(e:Event):void{
		removeEventListener(Event.ENTER_FRAME, animate); 
	}
	private function animate(e:Event):void{
		(nFrame % 5 == 0) ? alpha = 0.4 : alpha = 0.3;  
		nFrame++; 
	}
}