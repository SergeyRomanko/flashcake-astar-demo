package {
	
	import astar.AStar;
	import astar.Graph;
	import astar.GraphNode;
	
	import com.flashcake.overlay.FlashCakeSfwOverlay;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import view.GraphNodeVisual;
	import view.GraphRenderer;
	
	[SWF(width="670", height="435", frameRate="40", backgroundColor="#FFFFFF")]
	public class AStarApp extends Sprite{
		
		private var logic:AStar = new AStar();
		private var graph:Graph = new Graph(39,22);
		private var renderer:GraphRenderer = new GraphRenderer();

		private var start:GraphNode;
		private var end:GraphNode;
		
		private var path:Vector.<GraphNode> = new Vector.<GraphNode>();
		
		private var curAnimationIndex:int = -1;
		private var animationDirection:Boolean = true;
		
		private var notFoundText:TextField = new TextField();
		
		public function AStarApp(){
			addChild(renderer);
			
			var overlay:FlashCakeSfwOverlay = new FlashCakeSfwOverlay();// Feel free to remove this layer
			addChild(overlay);
			overlay.createButton(60,403,'Restart', onRebuildWalls);
			
			notFoundText.defaultTextFormat = new TextFormat('Arial', 20, 0x8E8E8E);
			notFoundText.width = 300;
			notFoundText.height = 25;
			notFoundText.x = 250;
			notFoundText.y = 392;
			notFoundText.alpha = 0;
			notFoundText.mouseEnabled = false;
			notFoundText.embedFonts = true;
			notFoundText.text = 'No path was found.';
			addChild(notFoundText);
			
			
			renderer.draw(graph);
			
			generateWalls();

			addEventListener( MouseEvent.MOUSE_DOWN, onNodeSelected);
		}
		
		protected function onRebuildWalls(event:Event):void{
			generateWalls();
		}
		
		protected function onNodeSelected(event:MouseEvent):void{
			var nodeView:GraphNodeVisual = event.target as GraphNodeVisual;
			if(nodeView && !nodeView.graphNode.isWall){
				end = nodeView.graphNode;
				
				path = logic.search(graph,start,end);
				if(path){
					mouseChildren = mouseEnabled = false;
					curAnimationIndex = -1;
					animationDirection = true;
					renderer.invertNodeHighlight(start);
					addEventListener( Event.ENTER_FRAME, onEnterFrame );
				}else{
					TweenMax.killTweensOf(notFoundText);
					notFoundText.alpha = 0;
					TweenMax.to(notFoundText,0.2,{alpha:1, repeat:1, repeatDelay:1, yoyo:true});
				}
				
				
			}
		}
		
		protected function onEnterFrame(event:Event):void{
			animationIndex++;
		}
		
		public function set animationIndex(index:int):void{
			if(index >= path.length){
				if(animationDirection){
					animationDirection = false;
					curAnimationIndex = -1;
				}else{
					start = end;
					end = null;
					renderer.invertNodeHighlight(start);
					mouseChildren = mouseEnabled = true;
					removeEventListener( Event.ENTER_FRAME, onEnterFrame );	
				}
			}else{
				renderer.invertNodeHighlight(path[index]);
				curAnimationIndex = index; 
			}
		}
		
		public function get animationIndex():int{
			return curAnimationIndex;
		}
		
		private function redrawGraph():void{
			renderer.show(graph, path);
		}
		
		private function generateWalls():void{
			start = null;
			for (var x:int = 0; x < graph.width; x++) {
				for (var y:int = 0; y < graph.height; y++) {
					graph.getNodeAt(x,y).isWall = Math.random()<0.2;
					if(!start && !graph.getNodeAt(x,y).isWall){
						start = graph.getNodeAt(x,y);
					}
				}
			}
			renderer.show(graph,null);
			renderer.invertNodeHighlight(start);
		}

		
	}
}