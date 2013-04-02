package view{
	import astar.Graph;
	import astar.GraphNode;
	
	import flash.display.Sprite;
	
	public class GraphRenderer extends Sprite{
		
		public function draw(graph:Graph):void{
			removeChildren()
			for (var x:int = 0; x < graph.width; x++) {
				for (var y:int = 0; y < graph.height; y++) {
					addChild(new GraphNodeVisual(graph.getNodeAt(x,y)))
				}
			}
		}
		
		public function show(graph:Graph,path:Vector.<GraphNode>):void{
			for (var x:int = 0; x < graph.width; x++) {
				for (var y:int = 0; y < graph.height; y++) {
					var node:GraphNode = graph.getNodeAt(x,y);
					var visual:GraphNodeVisual = getVisualNode(node);
					
					visual.highlight = path && path.indexOf(node)!=-1;
					
				}
			}
		}
		
		private function getVisualNode(node:GraphNode):GraphNodeVisual{
			for (var i:int = 0; i < numChildren; i++) {
				var curVisualNode:GraphNodeVisual = getChildAt(i) as GraphNodeVisual;
				if(curVisualNode.graphNode.x == node.x && curVisualNode.graphNode.y == node.y){
					return curVisualNode
				}
			}
			return null;
		}
		
		public function invertNodeHighlight(node:GraphNode):void{
			var visual:GraphNodeVisual = getVisualNode(node);
			visual.highlight = !visual.highlight;
		}
		
	}
}