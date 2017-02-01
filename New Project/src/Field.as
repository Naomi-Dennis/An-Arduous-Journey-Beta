package
{
	import Assets.Item;
	import Assets.Utility.RandomNumber;
	import Assets.Utility.RemoveFromArray;
	import Assets.Utility.RemoveSprite;
	import Assets.Utility.Swap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	   The Battle Field
	 */
	public class Field extends Sprite
	{
		// constraints // 
		public var rows:int = 13;
		public var cols:int = 14;
		//utility // 
		public var aTiles:Array = [];
		// path finding stuff // 
		public var frontier:Array = [];
		public var startPoint:Cell = null;
		public var endPoint:Cell = null;
		public var pathList:Array = [];
		public var isAttacking:Boolean = false;
		public var isMoving:Boolean = false;
		public var nStartingPieces:int = 1;
		private var pieceMovmentHandle:Function;
		private var pieceMovementCompleteHandle:Function;
		private var nFrame:int = 0;
		
		public function Field()
		{
			// intitate the field // 
			initField();
			//sorted neighbors to every cell (von)
			firstState();
		}
		
		// end field constructor // 
		public function getTileAt(row:int, col:int):Cell
		{
			//self explanatory 
			return aTiles[row][col];
		}
		
		// end get tile at //
		public function setPieceAt(piece:BattlePiece, cell:Cell):Boolean
		{
			//set the piece at a specific cell, that is provided
			var chosenTile:Cell = cell;
			if (!chosenTile.hasPiece() && chosenTile.getTentDistance() == 1)
			{
				nStartingPieces++;
				chosenTile.setPiece(piece);
				//change the cell to the top child so it is easier to see
				var topChild:* = this.getChildAt(this.numChildren - nStartingPieces);
				this.swapChildren(chosenTile, topChild);
				return true;
			}
			return false;
		}
		
		public function setCellAtTop(cell:Cell):void
		{
			var topChild:* = this.getChildAt(this.numChildren - 1);
			//this.swapChildren(cell, topChild);
		}
		
		public function checkCells(aCells:Array):Array
		{
			var currentCell:Cell = null;
			var currentPoint:Point = null;
			for (var i:* in aCells)
			{
				currentPoint = aCells[i];
				currentCell = getTileAt(currentPoint.y - 1, currentPoint.x - 1);
				if (currentCell.isImmooveableObject())
				{
					(i == 0) ? aCells.splice(0, 1) : aCells.splice(i, 1);
				}
			}
			return aCells;
		}
		
		// end set tile at //
		public function getPieceLocations(nullPieces:Array):Array
		{
			
			//compile a list of cells with pieces on it. 
			//null pieces are pieces that can be ignored.
			var locations:Array = [];
			var currentCell:Cell = null;
			var playerTargets:Array = [];
			var enemyTargets:Array = [];
			//gather all pieces
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					if (currentCell != null && currentCell.hasPiece())
					{
						if (currentCell.getPiece().mob.mobType != "enemy")
						{
							playerTargets.push(currentCell.getPiece());
						}
						else
						{
							enemyTargets.push(currentCell.getPiece());
						}
						
					}
						//(currentCell != null && currentCell.hasPiece()) ? locations.push(currentCell.getPiece()) : null;
				}
			}
			/*
			   i = 0;
			   j = 0;
			   var comparePiece:BattlePiece = null;
			   var locPiece:BattlePiece = new BattlePiece(new Sprite(), new Mob());
			
			   //remove the pieces that are to be ignored, if there are pieces to be ignored
			   for (i in locations)
			   {
			   locPiece = locations[i].getPiece();
			   if (locPiece.mob.mobType != "enemy")
			   {
			   playerTargets.push(locPiece);
			   }
			   else
			   {
			   enemyTargets.push(locPiece);
			   }
			
			   }
			 */
			
			return [playerTargets, enemyTargets];
		}
		
		// end move piece // 
		public function initField():void
		{
			// create the tiles on the screen 
			// add the tiles to the array (aTiles)
			var currentCell:Cell = null;
			var offsetX:int = 5;
			var offsetY:int = 5; 
			for (var i:int = 0; i < rows; i++)
			{
				aTiles[i] = new Array();
				for (var j:int = 0; j < cols; j++)
				{
					currentCell = new Cell({row: i, col: j});
					currentCell.x = (j * 32) + offsetX
					currentCell.y = (i * 32) + offsetY
					aTiles[i].push(currentCell);
				}
			}
		}
		
		// end init field //
		public function firstState():void
		{ //assign neighbors to each cell (von, sorted) 
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.addNeighbors(aTiles);
				}
			}
		}
		
		// end create dead cells //
		public function renderField():void
		{
			//add the tiles to the field
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					addChild(currentCell);
				}
			}
		}
		
		// end render field //
		public function removeField():void
		{ //remove the tiles from the field, leave them on the lsit
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					RemoveSprite(currentCell);
				}
			}
		}
		
		// end remove field // 
		public function refreshField():void
		{ // self explanatory // 
			removeField();
			renderField();
		}
		
		public function getVonNeighbors(cell:Cell):Object
		{
			//return (don't assign) an object that holds the standard Von Neighborhood paradigm based on the passed cell
			var row:int = 0;
			row = cell.getLocation().row;
			var col:int = cell.getLocation().col;
			var north:Cell = null;
			var south:Cell = null;
			var east:Cell = null;
			var west:Cell = null;
			var neighbors:Object = {};
			//north
			if (row - 1 >= 0)
			{
				north = getTileAt(row - 1, col);
			}
			//west
			if (col - 1 >= 0)
			{
				west = getTileAt(row, col - 1);
			}
			//east
			if (col + 1 < cols)
			{
				east = getTileAt(row, col + 1);
			}
			//south
			if (row + 1 < rows)
			{
				south = getTileAt(row + 1, col);
			}
			return neighbors = {"west": west, "east": east, "south": south, "north": north};
		}
		
		//***********************************************************/
		//***********************************************************/
		//***********************************************************/
		//***********************************************************/
		//************** end utilty                  ****************/
		//************** begin primary functions     ****************/
		//***********************************************************/
		//***********************************************************/
		//***********************************************************/
		//***********************************************************/
		public function drawPathFromEnemy(startCell:Cell, _endPoint:Cell):Array
		{
			/** the previous iteration has been commented out of the enemy code, in the move function */
			//draw a path from the enemy
			startPoint = startCell;
			endPoint = _endPoint;
			drawPath(startPoint);
			return reconstructPath(startPoint, endPoint);
		}
		
		public function getEnemyMovementRadius(enemy:BattlePiece):Array
		{
			startPoint = enemy.getCellLocation();
			var movementTiles:Array = fillMovement(enemy.getCellLocation(), enemy.getCellLocation(), enemy.mob.getMp(), "noFill");
			return movementTiles;
		}
		
		// end refresh field //
		public function showAvailableMovement(piece:BattlePiece):Array
		{
			//self explanatory
			startPoint = piece.getCellLocation();
			isMoving = true;
			var movementTiles:Array = fillMovement(piece.getCellLocation(), piece.getCellLocation(), piece.mob.getMp());
			var movementEvents:Array = [];
			/*
			 * Each element in an object { obj:[Cell], foo:Function }
			 * */
			var evtObj:Object = {};
			var currentCell:Cell = null;
			for (var i:* in movementTiles)
			{
				currentCell = movementTiles[i];
				if (!currentCell.hasPiece() && !currentCell.isImmooveableObject())
				{
					evtObj = {obj: currentCell, foo: movePlayerPiece(piece)}
					movementEvents.push(evtObj);
					evtObj.obj.addEventListener(MouseEvent.CLICK, evtObj.foo);
				}
				else
				{
					currentCell.restoreCell();
				}
			}
			return movementEvents;
		}
		
		public function clearMovementTiles(movementEvts:Array):void
		{
		
		}
		
		public function showAvailableAttackRange(piece:BattlePiece, skill:Skill, mode:String = "player", allyPieces:Array = null, attkFoo:Function=null):Array
		{
			//shows the attack range based on the 
			//skill's getRangeShape() method
			var shape:String = skill.getRangeShape();
			var skillName:String = skill.getName().toLowerCase();
			if (shape == "line" || shape == "von")
			{
				(allyPieces == null) ? allyPieces = [] : null;
				startPoint = piece.getCellLocation();
				var areaOfAttack:Array = fillRange(startPoint, startPoint, skill.getRange());
				//return drawMultipleLines(piece, allyPieces, skill, mode);
				var attackEvts:Array = [];
				/*
				 * Each element in an object { obj:[Cell], foo:Function }
				 * */
				var evtObj:Object = {};
				var currentCell:Cell = null;
				for (var i:* in areaOfAttack)
				{
					currentCell = areaOfAttack[i];
					if (!currentCell.hasPiece() || (currentCell.hasPiece() && currentCell.getPiece().mob.mobType.toLowerCase() == "enemy"))
					{
						evtObj = {obj: currentCell, foo: attkFoo}
						if (skillName == "pressure points" || skillName == "nail arrow" || skillName == "poison arrow" || skillName == "fire arrow")
						{
							evtObj.obj.addEventListener(MouseEvent.MOUSE_OVER, showVonAttackRange);
							evtObj.obj.addEventListener(MouseEvent.MOUSE_OUT, clearVonAttackRange);
							var elementType:String = skillName.split(" ")[0];
							evtObj.foo = attkFoo;
						}
						attackEvts.push(evtObj);
						evtObj.obj.addEventListener(MouseEvent.CLICK, evtObj.foo);
					}
					else
					{
						currentCell.restoreCell();
					}
				}
				return attackEvts;
			}
			else if (shape == "allies")
			{
				startPoint = piece.getCellLocation();
				var healPoints:Array = getPieceLocations([])[0];
				var currentHealCell:Cell;
				var cells:Array = [];
				for (var j:* in healPoints)
				{
					currentHealCell = BattlePiece(healPoints[j]).getCellLocation();
					cells.push({obj: currentHealCell, foo: attkFoo});
					currentHealCell.canAttackHere();
					currentHealCell.addEventListener(MouseEvent.CLICK, cells[j].foo);
				}
				return cells;
			}
			else if (shape == "self")
			{
				return affectMyself(piece, skill);
			}
			
			return [];
		}

		public function showVonAttackRange(e:MouseEvent):void
		{
			var cell:Cell = e.currentTarget as Cell;
			var neighbors:Object = getVonNeighbors(cell);
			var currentCell:Cell = null;
			for (var i:* in neighbors)
			{
				currentCell = neighbors[i];
				if (currentCell != null)
				{
					if (currentCell.isAttackable())
					{
						currentCell.canSubAttackHere();
					}
				}
			}
		}
		
		public function clearVonAttackRange(e:MouseEvent):void
		{
			var cell:Cell = e.currentTarget as Cell;
			var neighbors:Object = getVonNeighbors(cell);
			var currentCell:Cell = null;
			for (var i:* in neighbors)
			{
				currentCell = neighbors[i];
				if (currentCell != null && currentCell.isSubAttackable())
				{
					currentCell.canAttackHere();
				}
			}
			cell.canAttackHere();
		}
		
		private function clearVonAttackRangeNonHandle(cell:Cell):void
		{
			var neighbors:Object = getVonNeighbors(cell);
			var currentCell:Cell = null;
			for (var i:* in neighbors)
			{
				currentCell = neighbors[i];
				if (currentCell != null)
				{
					if (currentCell.isSubAttackable())
					{
						currentCell.canAttackHere();
					}
				}
			}
			cell.canAttackHere();
		}
		
		public function fillMovement(playerCell:Cell, currentCell:Cell, mp:int, mode:String = "none", DIST:int = 0):Array
		{
			var cells:Array = [];
			if (currentCell != null)
			{
				if (!currentCell.visited)
				{
					if (currentCell == playerCell)
					{
						DIST += 0;
					}
					else
					{
						DIST += currentCell.tentDistance;
					}
					currentCell.visited = true;
					currentCell.hDistance = DIST;
				}
				else
				{
					if (currentCell == playerCell)
					{
						return [];
					}
					else if (currentCell.hDistance > (DIST + currentCell.tentDistance))
					{
						currentCell.hDistance = (DIST + currentCell.tentDistance);
					}
					else
					{
						return [];
					}
				}
				
				if (currentCell.hDistance > mp)
				{
					return [];
				}
				else
				{
					currentCell.canMoveHere();
					cells.push(currentCell);
					var neighbors:Object = getVonNeighbors(currentCell);
					cells = cells.concat(fillMovement(playerCell, neighbors.west, mp, mode, currentCell.hDistance));
					cells = cells.concat(fillMovement(playerCell, neighbors.east, mp, mode, currentCell.hDistance));
					cells = cells.concat(fillMovement(playerCell, neighbors.north, mp, mode, currentCell.hDistance));
					cells = cells.concat(fillMovement(playerCell, neighbors.south, mp, mode, currentCell.hDistance));
					return cells;
				}
			}
			else
			{
				return [];
			}
		}
		
		public function attackOpportunity(cell:Cell, enemies:String = "player"):void
		{
			var neighbors:Object = getVonNeighbors(cell);
			var current:Cell = null;
			var myPiece:BattlePiece = cell.getPiece();
			var myMob:* = myPiece.mob;
			var piece:BattlePiece = null;
			var rand:int = RandomNumber(100, 0);
			for (var i:* in neighbors)
			{
				current = neighbors[i];
				if (current.hasPiece())
				{
					rand = RandomNumber(100, 0);
					piece = current.getPiece();
					if (enemies == "player")
					{
						if (rand <= 50)
						{
							(piece.mob.mobtype == "player") ? myMob.changeHp(piece.mob.getStatus().strength * -1) : null
						}
					}
					else
					{
						if (rand <= 50)
						{
							(piece.mob.mobtype == "enemy") ? myMob.changeHp(piece.mob.getStatus().strength * -1) : null
						}
					}
				}
			}
		}
		
		public function affectMyself(piece:BattlePiece, skill:Skill, pieceType:String = "player"):Array
		{
			var currentCell:Cell = piece.getCellLocation();
			if (pieceType == "player")
			{
				skill.perform(piece.mob);
			}
			return [currentCell];
		}
		

		
		public function fillRange(playerCell:Cell, currentCell:Cell, skillRange:int, DIST:int = 0):Array
		{
			var cells:Array = [];
			if (currentCell != null)
			{
				if (!currentCell.visited)
				{
					if (currentCell == playerCell)
					{
						DIST += 0;
					}
					else
					{
						DIST += currentCell.tentDistance;
					}
					currentCell.visited = true;
					currentCell.hDistance = DIST;
				}
				else
				{
					if (currentCell == playerCell)
					{
						return [];
					}
					else if (currentCell.hDistance > (DIST + currentCell.tentDistance))
					{
						currentCell.hDistance = (DIST + currentCell.tentDistance);
					}
					else
					{
						return [];
					}
				}
				
				if (currentCell.hDistance > skillRange)
				{
					if (currentCell.hasPiece())
					{
						if (Mob(currentCell.getPiece().mob).mobType.toLowerCase() == "enemy")
						{
							currentCell.canAttackHere()
							cells.push(currentCell);
							return cells;
						}
					}
					return [];
				}
				else
				{
					currentCell.canAttackHere();
					cells.push(currentCell);
					var neighbors:Object = getVonNeighbors(currentCell);
					cells = cells.concat(fillRange(playerCell, neighbors.west, skillRange, currentCell.hDistance));
					cells = cells.concat(fillRange(playerCell, neighbors.east, skillRange, currentCell.hDistance));
					cells = cells.concat(fillRange(playerCell, neighbors.north, skillRange, currentCell.hDistance));
					cells = cells.concat(fillRange(playerCell, neighbors.south, skillRange, currentCell.hDistance));
					return cells;
				}
			}
			else
			{
				return [];
			}
		}
		
		// end getConNeighbors // 
		public function moveEnemy(piece:BattlePiece, playerLoc:Cell, callback:Function = null):void
		{
			var mp:int = piece.mob.getMp();
			endPoint = piece.getCellLocation();
			var closestCellToPlayer:Array = playerLoc.getSortedNeighbors(endPoint.point).reverse();
			startPoint = closestCellToPlayer[0];
			var closestCellToEnemy:Array = endPoint.getSortedNeighbors(startPoint.point).reverse();
			endPoint = closestCellToEnemy[0];
			drawPath(playerLoc);
			var pathList:Array = reconstructPath(startPoint, endPoint);
			var pathListLength:int = pathList.length;
			var movementPathList:Array = [];
			movementPathList.push(closestCellToEnemy[0]);
			mp -= 1;
			var currentCell:Cell = null; //placeholder for the current cell 
			for (var i:int = 1; (mp > 0) && i < pathListLength; i++)
			{ //start from 1 after the start point, and go until all movement points are used, or until an obstacle is found
				if (pathList.length > 1)
				{
					mp -= 1;
					movementPathList.push(pathList[i]);
					currentCell = pathList[i];
				}
				else
				{
					currentCell = pathList[0];
					break;
				}
			}
			
			if (currentCell != null)
			{
				if (currentCell != endPoint && !currentCell.hasPiece()) //security reasons, double check that the endpoint isn't the start point
				{
					/*
					   endPoint.clearPiece();
					   currentCell.setPiece(piece);
					   setCellAtTop(piece.getCellLocation());
					 */
					piece.mob.setMp(mp);
					movePiece(piece, movementPathList, callback);
					
				}
			}
			else
			{
				Mob(piece.mob).setMp(0);
			}
		}
		
		private function movePiece(piece:BattlePiece, shortenedPathList:Array, callback:Function = null):void
		{
			resetFieldCells();
			var initTimer:int = getTimer();
			var pathLength:int = shortenedPathList.length;
			piece.mob.movementBegun = true;
			shortenedPathList = shortenedPathList.reverse();
			Mob(piece.mob).movementBegun = true; 
			movePieceHandle(piece, shortenedPathList, Mob(piece.mob).getMp(), callback);
		}
		private function letPieceMove(piece:BattlePiece, callback:Function = null):void
		{
			piece.mob.hasMoved = true;
			startPoint = null;
			endPoint = null;
			Mob(piece.mob).movementBegun = false;
			if (callback != null)
			{
				callback();
			}
			resetFieldCells(); // reset the field
		}
		
		private function movePieceHandle(piece:BattlePiece, shortenedPathList:Array, mp:int, callback:Function = null):void
		{
			
			var currentCell:Cell = new Cell();
			currentCell.clearIndicator();
			if (shortenedPathList.length > 0)
			{
				currentCell = shortenedPathList.pop();
				if (currentCell.getCellState() == "ice")
				{
					var rand:int = RandomNumber(100, 1)
					if (rand <= 50)
					{
						Mob(piece.mob).changeMp(-1)
						piece.showSlipped();
					}
				}
				else if (currentCell.getCellState() == "fire"){
					Mob(piece.mob).changeHp( -3 );
					piece.showDamage( 3 );
					piece.showBurning();
				}
				else if (currentCell.getCellState() == "poison"){
					Mob(piece.mob).changeHp( -3 );
					piece.showDamage( 3 );
					piece.showPoisoned(); 
				}
				
				piece.getCellLocation().clearPiece();
				currentCell.setPiece(piece);
				Mob(piece.mob).setMp(mp);
				
				setTimeout(movePieceHandle, 200, piece, shortenedPathList, mp - 1, callback);
			}
			else if (shortenedPathList.length == 0 || Mob(piece.mob).getMp() == 0)
			{
				piece.mob.hasMoved = true
				nFrame = 0;
				letPieceMove(piece, callback);
			}
		}
		
		public function stepOnFire(piece:Mob):void
		{
			environmentAttack(piece, "fire");
		}
		
		public function stepOnIce(piece:Mob):void
		{
			environmentAttack(piece, "ice");
		}
		
		public function stepOnPoison(piece:Mob):void
		{
			environmentAttack(piece, "poison");
		}
		
		public function environmentAttack(piece:Mob, type:String):void
		{
			var max:int = piece.getMaxHp();
			var dmg:int = max * (RandomNumber(5, 3) / 100);
			var cell:Cell = piece.getBattlePiece().getCellLocation()
			var cellElementType:String = cell.getCellState();
			if (type == "fire")
			{
				if (cellElementType == "ice")
				{
					cell.clearCellState();
					cell.restoreCell();
					return;
				}
				else if (cellElementType == "poison")
				{
					cell.setVonNeighborsToElement("fire");
				}
				else
				{
					cell.setFireState();
				}
			}
			else if (type == "ice")
			{
				if (cellElementType == "fire")
				{
					cell.clearCellState();
					cell.restoreCell();
				}
				else
				{
					cell.setFrozenState();
				}
				return;
			}
			else if (type == "poison")
			{
				if (cellElementType == "fire")
				{
					cell.setVonNeighborsToElement("fire");
				}
				else
				{
					cell.setPoisonState();
				}
			}
			piece.changeHp(dmg, "magic");
		}
		
		public function drawPath(start:Cell):void
		{
			///////  Draw a path using the depth first search method ////////////
			frontier = [];
			markAllAsUnvisited();/* Mark all as unvisited */
			frontier.push(start); /* add the start node to the checking list */
			start.visited = true; /* set start to visited */
			var current:Cell = null;  /*init */
			var neighbors:Array = [];/* init*/
			var currentNeighbor:Cell = null;  /* init */
			var tent_g_score:Number = 0;
			start.hDistance = distanceBetweenCells(start, endPoint);
			while (frontier.length > 0)
			{
				if (current == endPoint)
				{
					break;
				}
				current = findLowesetFScoreNode() /* get the last node added */
				neighbors = current.getSortedNeighbors(endPoint.point); /* Sort the neighbors, from least to greatest distance from it to the goal */
				current.gDistance = distanceBetweenCells(current, start);
				for (var i:* in neighbors)
				{
					currentNeighbor = neighbors[i];
					if (currentNeighbor == endPoint)
					{
						FlashConnect.trace("GOAL");
					}
					tent_g_score = current.gDistance + currentNeighbor.tentDistance;
					if (!currentNeighbor.visited) /* If the node hasn't been visited*/
					{
						currentNeighbor.visited = true; /* set visited to true */
						frontier.push(neighbors[i]); /*add it to the checking list */
					}
					else if (tent_g_score >= currentNeighbor.gDistance)
					{
						{
							continue;
						}
					}
					
					currentNeighbor.prev = current; /* the neighbor came from the current node */
					currentNeighbor.gDistance = tent_g_score;
					currentNeighbor.hDistance = currentNeighbor.gDistance + distanceBetweenCells(current, endPoint);
				}
			}
		}
		
		private function findLowesetFScoreNode():Cell
		{
			var lowestScore:int = Cell(frontier[0]).hDistance;
			var currentScore:int = 0;
			var bestNode:Cell = Cell(frontier[0]);
			var currentCell:Cell;
			var bestIndex:int = 0;
			for (var i:int = 0; i < frontier.length; i++)
			{
				currentCell = frontier[i];
				currentScore = currentCell.hDistance;
				if (currentScore < lowestScore)
				{
					bestIndex = i;
					lowestScore = currentScore;
					bestNode = frontier[i];
				}
				if (currentCell == endPoint)
				{
					return endPoint;
				}
			}
			(bestIndex == 0) ? frontier.splice(0, 1) : frontier.splice((bestIndex - 1), 1);
			return bestNode
		}
		
		public function markAllAsUnvisited():void
		{
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					aTiles[i][j].visited = false;
					aTiles[i][j].prev = null;
					aTiles[i][j].reset();
				}
			}
		}
		
		// end draw path //
		public function reconstructPath(start:Cell, goal:Cell):Array
		{
			/////////// Reconstruct the path based on the cell before the 'goal' cell visited before the current one ////////////////////
			var path:Array = [];
			var current:Cell = null;
			current = goal;
			path.push(current);
			while (current != start && current.prev != null)
			{
				current = current.prev;
				path.push(current);
				current.isPath();
			}
			start.reset();
			return path;
		}
		
		public function restoreField():void
		{
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					Cell(aTiles[i][j]).clearSlate = true;
					Cell(aTiles[i][j]).resetToDefault();
					Cell(aTiles[i][j]).clearSlate = false;
				}
			}
		}
		
		//end reconstruct path // 
		
		public function clear():void
		{
			var currentCell:Cell = null;
			var nested:Boolean;
			if (pathList.length > 0)
			{
				nested = pathList[0].hasOwnProperty("length");
				for (var i:* in pathList)
				{
					
					if (nested)
					{
						for (var j:* in pathList[i])
						{
							currentCell = pathList[i][j];
							currentCell.visited = false;
							currentCell.reset();
						}
					}
					else
					{
						currentCell = pathList[i];
						currentCell.visited = false;
						currentCell.reset();
					}
					
				}
				
			}
		
		}
		
		public function resetFieldCells(mode:String = "null"):void
		{
			var currentCell:Cell = null;
			isAttacking = false;
			for (var i:int = 0; i < rows; i++)
			{
				for (var j:int = 0; j < cols; j++)
				{
					currentCell = aTiles[i][j];
					currentCell.restoreCell();	
				}
			}
			pathList = new Array();
		}
		
		// end clear // 
		public function movePieceToEnemy(piece:BattlePiece):void
		{
			var currentCell:Cell = null;
			this.addChildAt(piece, numChildren - 1);
			startPoint.clearPiece();
			endPoint.setPiece(piece);
			setCellAtTop(piece.getCellLocation());
			resetFieldCells();
		}
		
		public function movePlayerPiece(playerPiece:BattlePiece):Function
		{
			var self:Field = this;
			return function(e:MouseEvent):void
			{
				if (isMoving)
				{
					isMoving = false;
					var player:Mob = playerPiece.mob;
					var destination:Cell = e.currentTarget as Cell;
					var closestToDestination:Array = player.getBattlePiece().getCellLocation().getSortedNeighbors(destination.point).reverse();
					endPoint = closestToDestination[0]
					//endPoint = player.getBattlePiece().getCellLocation();
					startPoint = destination;
					drawPath(destination);
					var path:Array = reconstructPath(destination, endPoint);
					var shortenedPath:Array = [endPoint];
					for (var i:* in path)
					{
						if (player.getMp() == 0)
						{
							break;
						}
						else
						{
							shortenedPath.push(path[i]);
						}
					}
					movePiece(player.getBattlePiece(), shortenedPath);
					
				}
			}
		}
		
		// end move piece to enemy //
	
		
		public function enemyAttackAtGoal(skill:Skill, goal:Cell):void
		{
			var currentCell:Cell = null;
			if (goal != null && startPoint != null)
			{
				if (goal.hasPiece())
				{
					var targetPiece:BattlePiece = goal.getPiece();
					var target:Mob = targetPiece.mob;
					skill.perform(target);
				}
				else
				{
					skill.perform(null);
				}
				endPoint = null;
				goal = null;
				resetFieldCells();
			}
		}
		
		public function playerAttackHandle(skill:Skill, areaOfAttack:Array):Function
		{
			return function(e:MouseEvent):void
			{
				if (!isAttacking)
				{
					var cell:Cell = e.currentTarget as Cell;
					if (cell.hasPiece() && cell.getPiece().mob.mobType.toLowerCase() == "enemy")
					{
						attackSingleGoal(skill, cell);
						for (var i:* in areaOfAttack)
						{
							areaOfAttack[i].removeEventListener(MouseEvent.CLICK, playerAttackHandle);
						}
					}
					isAttacking = false;
					resetFieldCells();
				}
			
			}
		}
		
		public function attackSingleGoal(skill:Skill, goal:Cell):void
		{
			if (goal.hasPiece())
			{
				var targetPiece:BattlePiece = goal.getPiece();
				var target:Mob = targetPiece.mob;
				skill.perform(target);
			}
			else
			{
				skill.getOwner().changeAp(skill.getAp() * -1)
			}
			resetFieldCells();
		}
		
		// end attack piece at goal //
		public function distanceBetweenCells(pointA:Cell, pointB:Cell):Number
		{
			var cellA:Object = pointA.getLocation();
			var cellB:Object = pointB.getLocation();
			var pA:Point = new Point(cellA.col, cellA.row);
			var pB:Point = new Point(cellB.col, cellB.row);
			var distance:Number = Math.abs(distanceFormula(pA, pB));
			return distance;
		}
		
		public function tentDistanceBetweenCells(pointA:Cell, pointB:Cell):Number
		{
			var cellA:Object = pointA.getLocation();
			var cellB:Object = pointB.getLocation();
			var pA:Point = new Point(cellA.col, cellA.row);
			var pB:Point = new Point(cellB.col, cellB.row);
			var distance:Number = Math.abs(distanceFormula(pA, pB));
			if (pointA.tentDistance > 1)
			{
				distance += 1;
			}
			if (pointB.tentDistance > 1)
			{
				distance += 1;
			}
			return distance;
		}
		
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
		
		public function positionalDifference(pointA:Cell, pointB:Cell):Number
		{
			var cellA:Object = pointA.getLocation();
			var cellB:Object = pointB.getLocation();
			
			var diffCol:int = Math.abs(cellA.col - cellB.col)
			var diffRow:int = Math.abs(cellA.row - cellB.row)
			
			return diffCol + diffRow;
		}
		
		public function createCobblestoneField():void
		{
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createCobblestoneFloor();
				}
			}
		}
		
		public function createPrisonField():void
		{
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createPrisonFloor();
				}
			}
		}
		
		public function createFireField():void
		{
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createHellFloor();
				}
			}
		}
		
		public function createMudFloor():void
		{
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createMudFloor();
				}
			}
		}
		
		public function createMeadowField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 60)
					{
						currentCell.createGrassFloor();
					}
					else
					{
						currentCell.createGrassFlowers();
					}
				}
			}
		}
		
		public function createFadedMixedField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 70)
					{
						currentCell.createGrassFloor();
					}
					else
					{
						currentCell.createFadedGrassFloor();
					}
				}
			}
		}
		
		public function placeTrees():void
		{
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					rand = RandomNumber(100, 0);
					if (rand > 90)
					{
						aTiles[i][j].createTree();
					}
				}
			}
		}
		
		public function placeHellSpots():void
		{
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					rand = RandomNumber(100, 0);
					if (rand > 85)
					{
						Cell(aTiles[i][j]).createHellFloor();
					}
				}
			}
		}
		
		public function createGrassLandWithTreesField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 95)
					{
						currentCell.createGrassFloor();
					}
					else
					{
						currentCell.createGrassFloor();
						currentCell.createTree();
					}
				}
			}
		}
		
		public function createDirtyField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 90)
					{
						currentCell.createFadedGrassFloor();
					}
					else
					{
						currentCell.createDirtFloor();
					}
				}
			}
		}
		
		public function createSwampFloor():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 90)
					{
						currentCell.createGrassFloor();
					}
					else
					{
						currentCell.createDirtFloor();
					}
				}
			}
		}
		public function createMeshFloor():void
		{
			var currentCell:Cell = null;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createMeshFloor();
				}
			}
		}
		
		public function createBloodyCobblestone():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					if (rand <= 70)
					{
						currentCell.createCobblestoneFloor();
					}
					else
					{
						currentCell.createBloodyCobblestone();
					}
				}
			}
		}
		
		public function createTressWithDirtyGrassField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			var treechance:int;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					rand = RandomNumber(100, 0);
					treechance = RandomNumber(100, 0);
					if (rand <= 75)
					{
						currentCell.createFadedGrassFloor();
					}
					else if (rand > 75)
					{
						currentCell.createDirtFloor();
					}
					
					if (treechance < 10)
					{
						currentCell.createTree();
					}
				}
			}
		}
		
		public function createDirtField():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createDirtFloor();
				}
			}
		}
		
		public function createPrisonFloor():void
		{
			var currentCell:Cell = null;
			var rand:int = 0;
			for (var i:* in aTiles)
			{
				for (var j:* in aTiles[i])
				{
					currentCell = aTiles[i][j];
					currentCell.createPrisonFloor();
				}
			}
		}
	
	}

}