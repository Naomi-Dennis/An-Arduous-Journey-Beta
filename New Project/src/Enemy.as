package
{
	import Assets.Item;
	import Assets.Utility.DeepCopy;
	import Assets.Utility.GetAliasInformation;
	import Assets.Utility.Swap;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.globalization.DateTimeNameContext;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import mobs.Players.Beserker_Tristan;
	
	import skills.SingleShot;
	
	/**
	 * ...
	 * @author Naomi J. Dennis
	
	 */
	public class Enemy extends Mob
	{
		protected var actions:Array = [];
		public var shouldMove:Boolean = true;
		public var shouldAttack:Boolean = true;
		public var chosenAttack:Boolean = false;
		public var fieldMoveHandle:Function;
		public var fooActivated:Boolean = false;
		public var turnComplete:Boolean = false;
		private var foundCell:Boolean = false;
		private var timeout:uint = 0; 
		public function Enemy(_name:String = "None")
		{
			name = _name;
			mobType = "enemy";
		}
		
		public function brainTicking(ai_mode:String, field:Field, player:Mob, allies:Array):void
		{
			var mode:String = ai_mode.toLowerCase();
			if (mode == "tactical")
			{
				AI_TACTICAL(field, null, null)
			}
			else if (mode == "practical")
			{
				AI_PRACTICAL(field, null, null)
			}
			else if (mode == "spartan")
			{
				AI_SPARTAN(field, null)
			}
		}
		
		protected function AI_TACTICAL(field:Field, player:Mob, skill:Skill):void
		{
			var playerTarget:Mob;
			if (player == null)
			{
				playerTarget = getPlayerWithLowestHp(field);
			}
			else
			{
				playerTarget = player;
			}
			
			if (!chosenAttack)
			{
				skill = orderOfAttack();
				chosenAttack = true;
			}
			
			var distFromAttackRange:Number = distanceBetweenCells(playerTarget.getBattlePiece().getCellLocation(), getBattlePiece().getCellLocation());
			if (distFromAttackRange < skill.getRange())
			{
				attack(field, skill, playerTarget);
				shouldAttack = false;
				setTimeout(function():void{ }, 1000); 
			}
			else
			{
				if (mp > 0 && !hasMoved)
				{
					if (distFromAttackRange >= 1 && distFromAttackRange > 0.8)
					{
						moveTowardsPlayer(field, playerTarget);
						hasMoved = true
					}
					else
					{
						var destCell:Cell = meleeAttackCheck(getBattlePiece().getCellLocation(), playerTarget.getBattlePiece().getCellLocation())
						if (destCell != null)
						{
							getBattlePiece().getCellLocation().clearPiece();
							destCell.setPiece(battlePiece);
						}
						shouldAttack = false;
					}
				}
				else
				{
					shouldAttack = false;
				}
			}
			
			if (shouldAttack)
			{
				AI_PRACTICAL(field, playerTarget, skill);
			}
			else
			{
				shouldAttack = true;
				chosenAttack = false;
				turnComplete = true;
			}
		}
		
		protected function AI_PRACTICAL(field:Field, player:Mob, skill:Skill):void
		{
			var playerTarget:Mob;
			if (player == null)
			{
				playerTarget = getClosestPlayer(field);
			}
			else
			{
				playerTarget = player;
			}
			
			if (!chosenAttack)
			{
				skill = orderOfAttack();
				chosenAttack = true;
			}
			
			var distFromAttackRange:Number = distanceBetweenCells(playerTarget.getBattlePiece().getCellLocation(), getBattlePiece().getCellLocation());
			if (distFromAttackRange <= skill.getRange())
			{
				attack(field, skill, playerTarget);
				shouldAttack = false;
				setTimeout(function():void{ }, 1000); 
			}
			else
			{
				if (mp > 0 && !hasMoved)
				{
					if (distFromAttackRange >= 1 && distFromAttackRange > 0.8)
					{
						moveTowardsPlayer(field, playerTarget);
						hasMoved = true
					}
					else
					{
						var destCell:Cell = meleeAttackCheck(getBattlePiece().getCellLocation(), playerTarget.getBattlePiece().getCellLocation())
						if (destCell != null)
						{
							getBattlePiece().getCellLocation().clearPiece();
							destCell.setPiece(battlePiece);
						}
						shouldAttack = false;
					}
				}
				else
				{
					shouldAttack = false;
				}
			}
			
			if (shouldAttack)
			{
				AI_PRACTICAL(field, playerTarget, skill);
			}
			else
			{
				shouldAttack = true;
				chosenAttack = false;
				turnComplete = true;
			}
		
		}
		
		protected function AI_SPARTAN(field:Field, player:Mob):void
		{
			var playerTarget:Mob;
			if (player == null)
			{
				playerTarget = getClosestPlayer(field);
			}
			else
			{
				playerTarget = player;
			}
			if (shouldMove)
			{
				if (mp <= 0 || distanceBetweenCells(getBattlePiece().getCellLocation(), playerTarget.getBattlePiece().getCellLocation()) <= 1)
				{
					shouldMove = false;
					hasMoved = true;
				}
				else
				{
					shouldMove = false;
					moveTowardsPlayer(field, playerTarget);
					hasMoved = true
				}
			}
			if (shouldAttack && hasMoved)
			{
				var skill:Skill = orderOfAttack()
				if (skill != null)
				{
					attack(field, skill, playerTarget)
					shouldAttack = false;
					setTimeout(function():void{ }, 1000); 
				}
				else
				{
					shouldAttack = false;
				}
			}
			
			if (!hasMoved)
			{
				AI_SPARTAN(field, playerTarget);
			}
			else
			{
				if (shouldAttack)
				{
					AI_SPARTAN(field, playerTarget);
				}
				else
				{
					shouldAttack = true;
					shouldMove = true;
					hasMoved = false;
					turnComplete = true;
				}
			}
		}
		
		public function meleeAttackCheck(cell:Cell, playerCell:Cell):Cell
		{
			var currentCell:Cell = cell;
			var goalCell:Cell;
			var neighbors:Array = currentCell.neighbors;
			for (var i:* in neighbors)
			{
				currentCell = neighbors[i];
				if (!foundCell)
				{
					if (currentCell != null)
					{
						if (currentCell.hasPiece())
						{
							if (currentCell.getPiece().mob.mobType.toLowerCase() == "player")
							{
								goalCell = currentCell;
								foundCell = true;
								break;
							}
							else if (currentCell.getPiece().mob.mobType.toLowerCase() != "enemy")
							{
								continue;
							}
						}
						else if (distanceBetweenCells(currentCell, playerCell) <= 1)
						{
							meleeAttackCheck(currentCell, playerCell);
						}
						else
						{
							continue;
						}
					}
				}
			}
			
			if (foundCell)
			{
				return goalCell;
			}
			else
			{
				return null;
			}
		}
		
		public function orderOfAttack():Skill
		{
			var canUse:Skill = null;
			for (var i:* in actions)
			{
				if (!actions[i].onCooldown() && this.getAp() >= actions[i].getAp())
				{
					return actions[i]
				}
			}
			return null;
		}
		
		public function sumStats():int
		{
			var total:int = 0;
			for (var i:* in status)
			{
				total += status[i];
			}
			return total;
		}
		
		public function brainTick(player:Mob, field:Field, allies:Array):void
		{
		/*
		   var attk:Skill = orderOfAttack();
		
		   if (!doSkill(field, player, attk))
		   {
		   moveTowardsPlayer(field, player);
		   }
		 */
		}
		
		protected function attack(field:Field, skill:Skill, player:Mob):Boolean
		{
			//if the skill cannot be done return false
			if (skill != null)
			{
				var flag:Boolean = doSkill(field, player, skill);
				clearTimeout(timeout); 
				return flag; 
			}
			return false;
		}
		
		protected function moveAround(foo:Function):Boolean
		{
			return foo();
		}
		
		protected function useInventory(item:*, itemClass:Class):Boolean
		{
			var itemName:String = item.getName();
			var potion:* = inventory.getItemByName(itemName) as itemClass;
			if (potion != null)
			{
				potion.useItem();
				return true;
			}
			return false
		}
		
		protected function addAction(obj:*):void
		{
			obj.setOwner(this);
			actions.push(obj);
		}
		
		public override function processCooldowns():void
		{
			for (var i:* in actions)
			{
				Skill(actions[i]).deductCooldown();
			}
		}
		
		protected function doSkill(field:Field, player:Mob, skill:Skill):Boolean
		{
			var allies:Array = detectAllies(field);
			if (skill.getRangeShape() == "line")
			{
				return doLineSkill(field, player, skill);
			}
			else if (skill.getRangeShape() == "von")
			{
				return doVonSkill(field, skill, player);
			}
			else if (skill.getRangeShape() == "allies")
			{
				return useOnAllAllies(field, skill);
			}
			else if (skill.getRangeShape() == "self")
			{
				useOnMyself(skill);
			}
			
			//draw path 
			return false;
		}
		
		protected function useItem(item:Item):void
		{
			item.setOwner(this);
			item.useItem();
		}
		
		protected function detectAllies(field:Field):Array
		{
			return field.getPieceLocations([])[1];
		}
		
		// ************************************ //
		protected function detectPlayers(field:Field):Array
		{
			return field.getPieceLocations([])[0];
		}
		
		// ***********************************************************   Enemies  ************************************************************************** //
		protected function useOnMyself(skill:Skill):void
		{
			skill.perform(this);
		}
		
		protected function useOnAllAllies(field:Field, skill:Skill):Boolean
		{
			var allies:Array = detectAllies(field);
			if (this.getAp() >= skill.getAp())
			{
				for (var i:* in allies)
				{
					skill.perform(allies[i].mob);
				}
				this.changeAp(skill.getAp() * -1);
				return true;
			}
			else
			{
				return false;
			}
		}
		
		// ************************************ //
		protected function getClosestAlly(field:Field):Mob
		{
			var allies:Array = detectAllies(field);
			var myPos:Cell = this.getBattlePiece().getCellLocation();
			var lowestDistance:Number = 0.0;
			var closestAlly:Mob = null;
			var distance:Number = 999;
			var currentAllyCell:Cell = null;
			for (var i:* in allies)
			{
				currentAllyCell = allies[i].getCellLocation();
				distance = distanceBetweenCells(myPos, currentAllyCell);
				if (distance < lowestDistance)
				{
					lowestDistance = distance;
					closestAlly = currentAllyCell.getPiece().mob;
				}
			}
			return closestAlly;
		}
		
		// ************************************ //
		protected function getFarthestAlly(field:Field):Mob
		{
			var allies:Array = detectAllies(field);
			var myPos:Cell = this.getBattlePiece().getCellLocation();
			var highestDistance:Number = 0.0;
			var farthestAlly:Mob = null;
			var distance:Number = 0;
			var currentAllyCell:Cell = null;
			for (var i:* in allies)
			{
				currentAllyCell = allies[i].getCellLocation();
				distance = distanceBetweenCells(myPos, currentAllyCell);
				if (distance > highestDistance)
				{
					highestDistance = distance;
					farthestAlly = currentAllyCell.getPiece().mob;
				}
			}
			return farthestAlly;
		}
		
		// ************************************ //
		protected function getAllyWithLowestHp(field:Field):Mob
		{
			var allies:Array = detectAllies(field);
			var lowestHp:int = 999;
			var currentHp:int = 0;
			var weakestAlly:Mob = null;
			var currentAllyCell:Cell = null;
			for (var i:* in allies)
			{
				currentAllyCell = allies[i].getCellLocation();
				currentHp = currentAllyCell.getPiece().mob.getHp();
				if (currentHp < lowestHp)
				{
					lowestHp = currentHp;
					weakestAlly = currentAllyCell.getPiece().mob;
				}
			}
			return weakestAlly;
		}
		
		// ************************************ //
		protected function getAllyWithHighestHp(field:Field):Mob
		{
			var allies:Array = detectAllies(field);
			var highestHp:int = 999;
			var currentHp:int = 0;
			var strongestAlly:Mob = null;
			var currentAllyCell:Cell = null;
			for (var i:* in allies)
			{
				currentAllyCell = allies[i].getCellLocation();
				currentHp = currentAllyCell.getPiece().mob.getHp();
				if (currentHp < highestHp)
				{
					highestHp = currentHp;
					strongestAlly = currentAllyCell.getPiece().mob;
				}
			}
			return strongestAlly;
		}
		
		// ************************************ //
		// ***********************************************************   Players  ************************************************************************** //
		protected function getClosestPlayer(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var myPos:Cell = this.getBattlePiece().getCellLocation();
			var lowestDistance:Number = 999;
			var closestPlayer:Mob = null;
			var distance:Number = 0;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				distance = distanceBetweenCells(myPos, currentPlayerCell);
				if (distance < lowestDistance)
				{
					lowestDistance = distance;
					closestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return closestPlayer;
		}
		
		// ************************************ //
		protected function getFarthestPlayer(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var myPos:Cell = this.getBattlePiece().getCellLocation();
			var farthestDistance:Number = 0.0;
			var farthestPlayer:Mob = null;
			var distance:Number = 0;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				distance = distanceBetweenCells(myPos, currentPlayerCell);
				if (distance > farthestDistance)
				{
					farthestDistance = distance;
					farthestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return farthestPlayer;
		}
		
		// ************************************ //
		protected function getPlayerWithLowestHp(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var lowestHp:int = 999;
			var currentHp:int = 0;
			var weakestPlayer:Mob = null;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				currentHp = currentPlayerCell.getPiece().mob.getHp();
				if (currentHp < lowestHp)
				{
					lowestHp = currentHp;
					weakestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return weakestPlayer;
		}
		
		// ************************************ //
		protected function getPlayerWithHighestHp(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var highestHp:int = 0;
			var currentHp:int = 0;
			var strongestPlayer:Mob = null;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				currentHp = currentPlayerCell.getPiece().mob.getHp();
				if (currentHp > highestHp)
				{
					highestHp = currentHp;
					strongestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return strongestPlayer;
		}
		
		// ************************************ //	
		protected function getPlayerWithHighestDef(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var highestDef:int = 0;
			var currentDef:int = 0;
			var strongestPlayer:Mob = null;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				currentDef = currentPlayerCell.getPiece().mob.getStatus().defense;
				if (currentDef > highestDef)
				{
					highestDef = currentDef;
					strongestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return strongestPlayer;
		}
		
		// ************************************ //	
		protected function getPlayerWithLowestDef(field:Field):Mob
		{
			var players:Array = detectPlayers(field);
			var lowestDef:int = 999;
			var currentDef:int = 0;
			var weakestPlayer:Mob = null;
			var currentPlayerCell:Cell = null;
			for (var i:* in players)
			{
				currentPlayerCell = players[i].getCellLocation();
				currentDef = currentPlayerCell.getPiece().mob.getStatus().defense;
				if (currentDef > lowestDef)
				{
					lowestDef = currentDef;
					weakestPlayer = currentPlayerCell.getPiece().mob;
				}
			}
			return weakestPlayer;
		}
		
		// ************************************ //	
		protected function getDistanceFromPlayer(skill:Skill, field:Field, range:String = "close"):Array
		{
			var myBattlePiece:BattlePiece = this.getBattlePiece();
			var players:Array = field.getPieceLocations([])[0];
			var locations:Array = [];
			var currentPiece:BattlePiece = null;
			var dist:Number = 0.0;
			for (var i:* in players)
			{
				currentPiece = players[i];
				dist = Math.abs(distanceBetweenCells(currentPiece.getCellLocation(), myBattlePiece.getCellLocation()));
				locations.push([currentPiece.getCellLocation(), dist]);
			}
			i = 0;
			for (i in locations)
			{
				for (var j:* in locations)
				{
					if (range == "close")
					{
						if (locations[i][1] > locations[j][1])
						{
							Swap(locations, i, j);
						}
					}
					else if (range == "far")
					{
						if (locations[i][1] < locations[j][1])
						{
							Swap(locations, i, j);
						}
					}
				}
			}
			var sortedData:Array = [];
			var playerLoc:Cell = null;
			for (var k:* in locations)
			{
				playerLoc = locations[k][0];
				sortedData.push(playerLoc);
			}
			
			return sortedData;
		}
		
		public override function resetMob(noItems:Boolean = false):void
		{
			getBattlePiece().removeEffects();
			inventory.setItems(initialState.inventory);
			actions = initialState.actions;
			for (var i:* in actions)
			{
				actions[i].setOwner(this);
			}
			status = initialState.status;
			maxHp = initialState.maxHp;
			hp = maxHp;
			maxAp = initialState.maxAp;
			ap = maxAp;
			affliction = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0};
			afflictionDmg = {"burning": 0, "frozen": 0, "stunned": 0, "poisoned": 0}
			if (useTempStats)
			{
				useTempStats = false;
			}
			var lastCell:Cell = getBattlePiece().getCellLocation();
			getBattlePiece().alpha = 1;
			lastCell.setPiece(getBattlePiece());
		}
		
		public override function setInitialState():void
		{
			var getPath:Object = {};
			initialState = {};
			initialState.actions = copyArray(actions);
			initialState.inventory = copyArray(inventory.getItems());
			initialState.status = DeepCopy(status, Object, "Object");
			initialState.maxHp = maxHp;
			initialState.maxAp = maxAp;
			for (var i:* in aQuickSlots)
			{
				if (aQuickSlots[i] != null && aQuickSlots[i].getType().toLowerCase() == "skill")
				{
					aQuickSlots[i].resetCooldown();
				}
			}
			//***//
		}
		
		protected function getDistanceFromPlayerBasedOnHp(skill:Skill, field:Field, condition:String = "close"):Array
		{
			var myBattlePiece:BattlePiece = this.getBattlePiece();
			var players:Array = field.getPieceLocations([])[0];
			var locations:Array = [];
			var currentPiece:BattlePiece = null;
			var dist:Number = 0.0;
			for (var i:* in players)
			{
				currentPiece = players[i];
				dist = Math.abs(distanceBetweenCells(currentPiece.getCellLocation(), myBattlePiece.getCellLocation()));
				locations.push([currentPiece.getCellLocation(), dist]);
			}
			i = 0;
			for (i in locations)
			{
				for (var j:* in locations)
				{
					if (condition == "weakest")
					{
						if (locations[i][0].getPiece().mob.getHp() > locations[j][0].getPiece().mob.getHp())
						{
							Swap(locations, i, j);
						}
					}
					else if (condition == "strongest")
					{
						if (locations[i][0].getPiece().mob.getHp() < locations[j][0].getPiece().mob.getHp())
						{
							Swap(locations, i, j);
						}
					}
					
				}
			}
			var sortedData:Array = [];
			var playerLoc:String = "";
			for (var k:* in locations)
			{
				playerLoc = locations[k][0];
				sortedData.push(playerLoc);
			}
			
			return sortedData;
		}
		
		protected function doVonSkill(field:Field, skill:Skill, player:Mob):Boolean
		{
			var neighbors:Object = field.getVonNeighbors(this.getBattlePiece().getCellLocation());
			var skillMultiplicity:String = skill.getName().split(" ")[0];
			var n:int = 0; 
			for (var i:* in neighbors)
			{
				if (neighbors[i] != null && neighbors[i].hasPiece() && neighbors[i].getPiece() == player.getBattlePiece())
				{
					if (skillMultiplicity == "Double" || skillMultiplicity == "Triple")
					{
						skill.callback = field.resetFieldCells;
					}
					skill.perform(neighbors[i].getPiece().mob);
					return true;
				}
			}
			return false;
		}
		
		protected function doLineSkill(field:Field, player:Mob, skill:Skill):Boolean
		{
			var myPos:Cell = getBattlePiece().getCellLocation();
			var playerPos:Cell = player.getBattlePiece().getCellLocation();
			var distance:Number = Math.round(distanceBetweenCells(myPos, playerPos));
			var skillMultiplicity:String = skill.getName().split(" ")[0]; 
			if (distance <= skill.getRange())
			{
				if (skillMultiplicity == "Double" || skillMultiplicity == "Triple")
				{
					skill.callback = field.resetFieldCells;
				}
				skill.perform(player);
				

				return true;
			}
			
			return false;
		}
		
		protected function doCircleSkill(field:Field, player:Mob, skill:Skill):Boolean
		{
			var areaOfAttack:Array = field.showAvailableAttackRange(this.getBattlePiece(), skill);
			var currentCell:Cell = null;
			for (var i:* in areaOfAttack)
			{
				currentCell = areaOfAttack[i];
				if (currentCell.getPiece() == player.getBattlePiece())
				{
					break;
				}
				else
				{
					currentCell = null;
				}
			}
			
			if (currentCell != null)
			{
				field.enemyAttackAtGoal(skill, currentCell);
				field.resetFieldCells();
				return true;
			}
			field.resetFieldCells();
			return false;
		}
		
		protected function move(player:Mob, field:Field, condition:String = "close"):void
		{
			var goalCell:Cell = player.getBattlePiece().getCellLocation();
			field.moveEnemy(battlePiece, goalCell, function():void
			{
			});
		}
		
		protected function moveAwayFromPlayer(field:Field, player:Mob):Boolean
		{
			var myBattlePiece:BattlePiece = this.getBattlePiece();
			var myCell:Cell = myBattlePiece.getCellLocation();
			var vonNeighbors:Object = field.getVonNeighbors(myCell);
			var currentCell:Cell = null;
			var moveAround:Boolean = true;
			for (var i:* in vonNeighbors)
			{
				currentCell = vonNeighbors[i];
				if (currentCell.hasPiece() && currentCell.getPiece().mob.mobType.toLowerCase() == "player")
				{
					moveAround = false;
					return false;
				}
			}
			if (moveAround)
			{
				move(player, field, "far");
			}
			return true
		}
		
		protected function moveTowardsPlayer(field:Field, player:Mob):Boolean
		{
			var myBattlePiece:BattlePiece = this.getBattlePiece();
			var myCell:Cell = myBattlePiece.getCellLocation();
			var vonNeighbors:Object = field.getVonNeighbors(myCell);
			var currentCell:Cell = null;
			var moveAround:Boolean = true;
			for (var i:* in vonNeighbors)
			{
				currentCell = vonNeighbors[i];
				if (currentCell != null)
				{
					if (currentCell.hasPiece() && currentCell.getPiece().mob.mobType.toLowerCase() == "player")
					{
						moveAround = false;
						return false;
					}
				}
			}
			if (moveAround)
			{
				move(player, field, "close");
			}
			return true
		}
		
		protected function getFarthestPositionFromPlayer(field:Field, player:Mob):Cell
		{
			var movementTiles:Array = field.getEnemyMovementRadius(this.getBattlePiece());
			var farthestTile:Cell;
			var pos:Number = 999;
			var currentTile:Cell;
			for (var i:* in movementTiles)
			{
				currentTile = movementTiles[i];
				currentTile.restoreCell();
				if (distanceBetweenCells(currentTile, player.getBattlePiece().getCellLocation()) < pos)
				{
					farthestTile = currentTile;
				}
			}
			return farthestTile;
		}
		
		public function moveTo(field:Field, cell:Cell):void
		{
			field.moveEnemy(battlePiece, cell);
		}
		
		protected function distanceFormula(pointA:Point, pointB:Point):Number
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
		
		protected function distanceBetweenCells(pointA:Cell, pointB:Cell):Number
		{
			var cellA:Object = pointA.getLocation();
			var cellB:Object = pointB.getLocation();
			var pA:Point = new Point(cellA.col, cellA.row);
			var pB:Point = new Point(cellB.col, cellB.row);
			var distance:Number = Math.abs(distanceFormula(pA, pB));
			return distance;
		}
	
	}

}