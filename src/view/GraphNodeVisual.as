package view{
	
	import astar.GraphNode;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GraphNodeVisual extends Sprite{
		
		private static const SIDE:Number = 15;
		private static const GAP:Number = 2;
		
		private var _highlighted:Boolean = false;
		public var graphNode:GraphNode = null;
		
		public function GraphNodeVisual(graphNode:GraphNode):void{
			this.graphNode = graphNode;
			redrawBackground(0xFF3344);
			
			highlight = false;
			buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		
		public function onAddedToStage(event:Event):void{
			this.x = (SIDE+GAP)*graphNode.x+(stage.stageWidth - (SIDE+GAP)*39)/2;
			this.y = (SIDE+GAP)*graphNode.y;
		}
		
		public function set highlight(value:Boolean):void{
			buttonMode = !graphNode.isWall;
			if(graphNode.isWall){
				redrawBackground(0xC9CED3, 0xA1A6AD);
			}else{
				redrawBackground(value?0xFF6B60:0xFFFFFF);
			}
			_highlighted = value;
		}
		
		public function get highlight():Boolean{
			return _highlighted;
		}
		
		private function redrawBackground(color:int,hatching:int = int.MAX_VALUE):void{
			graphics.clear();
			graphics.lineStyle(1,0x8A8F96);
			graphics.beginFill(color);
			graphics.drawRect(0,0,SIDE,SIDE);
			graphics.endFill();
			
			if(hatching!=int.MAX_VALUE){
				graphics.lineStyle(1,hatching);
				for (var i:int = 0; i <= SIDE; i+=5) {
					graphics.moveTo(i,0);
					graphics.lineTo(0,i);
					graphics.moveTo(SIDE,SIDE-i);
					graphics.lineTo(SIDE-i,SIDE);
				}
			}
			
		}
		
	}
}