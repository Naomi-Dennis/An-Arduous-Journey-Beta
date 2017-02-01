package Screens
{
	import Assets.Utility.RemoveSprite;
	import flash.display.Sprite;
	import items.Antidote;
	import org.flashdevelop.utils.FlashConnect;
	import flash.events.MouseEvent; ;
	
	/**
	 * ...
	 * @author Naomi J Dennis
	 */
	public class ArmyHangerWindows extends Sprite
	{
		private var nCol:int = 5;
		public var aSlots:Array = [];
		private var pieces:Array = [];
		public var currentPiece:BattlePiece;
		public var outsideWin:ArmyHangerWindows;
		private var bkgrnd:Sprite;
		
		public function ArmyHangerWindows(nSlots:int = 15, maxCols:int=5, maxRows:int=3)
		{
			
			var newSlot:ArmySlot = new ArmySlot();
			var nWidth:int = newSlot.width * maxCols; 
			var nHeight:int = newSlot.height * maxRows; 
			var nX:Number = 2
			var nY:Number = 2
			bkgrnd = new ScreenBackground({width:nWidth + 4, height:nHeight + 4}, 0x000000, 0x000000); 
			addChild(bkgrnd); 
			for (var row:int = 0; row < maxRows; row++)
			{
				aSlots[row] = new Array();
				for (var col:int = 0; col < maxCols; col++)
				{
					newSlot = new ArmySlot();
					newSlot.x = nX + (col * newSlot.width);
					newSlot.y = nY + (row * newSlot.height);
					aSlots[row].push(newSlot);
					bkgrnd.addChild(newSlot);
				}
			}
			selectOnlyOne();
			
			
		}
		
		private function refreshSlots():void
		{
			var currentSlot:ArmySlot = new ArmySlot();
			var nSlots:int = aSlots.length;
			for (var i:int = 0; i < nSlots; i++)
			{
				for (var j:int = 0; j < 5; j++)
				currentSlot = aSlots[i][j];
				currentSlot.x = (j * currentSlot.width) + 4;
				currentSlot.y = (i * currentSlot.height) + 4;
				RemoveSprite(currentSlot);
				addChild(currentSlot);
			}
		}
		
		public function setPieces(newPieces:Array)
		{
			/* Take array of mobs */
			pieces = [];
			for (var i:* in newPieces)
			{
				pieces.push(newPieces[i].getBattlePiece());
			}
		}
		private function selectOnlyOne():void{
			for (var i:* in aSlots){
				for (var j:* in aSlots[i]){
					aSlots[i][j].addEventListener(MouseEvent.CLICK, checkClicked); 
				}
			}
		}
		private function checkClicked(e:MouseEvent):void{
			var tgt:ArmySlot = ArmySlot(e.currentTarget); 
			for (var i:* in aSlots){
				for (var j:* in aSlots[i]){
					ArmySlot(aSlots[i][j]).isSelected = false; 
					ArmySlot(aSlots[i][j]).deselectManual();
				}
			}
			ArmySlot(tgt).select();
			
			if(ArmySlot(tgt).hasPiece()){
				currentPiece = ArmySlot(tgt).getPiece();
			}
			RemoveSprite(tgt);
			addChild(tgt); 
		}
		public function removeFromSlot(piece:BattlePiece):Boolean{
			var pieceRemoved:Boolean = false;
			for (var i:* in aSlots){
				for (var j:* in aSlots[i]){
					if (piece == ArmySlot(aSlots[i][j]).getPiece()){
						ArmySlot(aSlots[i][j]).removePiece(); 
						pieceRemoved = true; 
						break; 
					}
				}
				if (pieceRemoved){
					break;
				}
			} 
			return pieceRemoved;
		}
		public function addPiece(newPiece:Mob):void
		{
			pieces.push(newPiece.getBattlePiece());
			var pieceStored:Boolean = false;
			for (var i:* in aSlots){
				for (var j:* in aSlots[i]){
					if (!ArmySlot(aSlots[i][j]).hasPiece()){
						ArmySlot(aSlots[i][j]).addPiece(newPiece.getBattlePiece());
						pieceStored = true;
						break; 
					}
				}
				if (pieceStored){
					break;
				}
			}
		}
		
		public function clearPieces():void
		{
			removePieces();
			pieces = [];
		}
		public function deselectAll():void{
			currentPiece = null; 
			var currentSlot:ArmySlot = new ArmySlot();
			for (var i:* in aSlots)
			{
				for (var j:* in aSlots[i])
				{
					currentSlot = aSlots[i][j];
					currentSlot.isSelected = false; 
					currentSlot.deselectManual();
				}
			}
		}
		public function removePieces():void
		{
			var currentSlot:ArmySlot = new ArmySlot();
			for (var i:* in aSlots)
			{
				for (var j:* in aSlots[i])
				{
					currentSlot = aSlots[i][j];
					currentSlot.removePiece();
				}
			}
		}
	}
}
import Assets.Utility.BlurObj;
import Assets.Utility.ChangeColor;
import Assets.Utility.GlowObj;
import Assets.Utility.RemoveFilters;
import Assets.Utility.RemoveSprite;
import flash.display.Sprite;
import flash.events.*;
import Assets.Utility.ConvertEmbedToSprite;
import flash.geom.ColorTransform;
import org.flashdevelop.utils.FlashConnect;

class ArmySlot extends Sprite
{
	private var bkgrnd:Sprite = new Sprite();
	[Embed(source = "../pics/Window Slot.png")]
	private var imgClass:Class;
	private var piece:BattlePiece = null; 
	public var isSelected:Boolean = false; 
	public function ArmySlot()
	{
		bkgrnd = ConvertEmbedToSprite(imgClass);
		bkgrnd.width = 64;
		bkgrnd.height = 64; 
		addChild(bkgrnd);
		addEventListener(Event.ENTER_FRAME, shadeSelected); 
		addEventListener(MouseEvent.ROLL_OVER, onOver)
		addEventListener(MouseEvent.ROLL_OUT, onOut)
		alpha = 0.5;
	}
	public function onOver(e:MouseEvent):void{
		alpha = 1; 
	}
	public function onOut(e:MouseEvent):void{
		(isSelected) ? alpha = 1.0 : alpha = 0.5;
	}
	public function select():void{
		if(hasPiece()){
			if(isSelected){
				isSelected = false ;
			}
			else{
				isSelected = true; 
			}
		}
	}
	public function deselectManual():void{
		RemoveFilters(bkgrnd);
		alpha = 0.5;
	}
	private function shadeSelected(e:Event):void{
			if (isSelected){
				GlowObj(bkgrnd, 0xffdd00, 10, 10, 10 ); 
				alpha = 1; 
			}
			else{
				RemoveFilters(bkgrnd);
			}
	}
	public function addPiece(_piece:BattlePiece):void
	{
		bkgrnd.width = 64;
		bkgrnd.height = 64; 
		piece = _piece;
		piece.resetBattlePiece();
		piece.width = 80
		piece.height = 64
		piece.x = 10
		piece.y = 8
		addChild(piece); 
	}
	
	public function removePiece():void
	{
		RemoveSprite(piece);
		piece = null;
	}
	
	public function getPiece():BattlePiece
	{
		return piece;
	}
	public function hasPiece():Boolean{
		return piece != null; 
	}
}
