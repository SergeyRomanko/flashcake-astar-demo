package astar {
	import flash.geom.Point;
	
	public class AStar{
		
		public var openList:Vector.<GraphNode> = new Vector.<GraphNode>();
		public var closedList:Vector.<GraphNode> = new Vector.<GraphNode>();
		
		public function search(graph:Graph, start:GraphNode, end:GraphNode):Vector.<GraphNode> {
			
			openList.length = 0;
			closedList.length = 0;
			
			start.parent = null;
			start.g = 0;
			openList[openList.length] = start;
			
			while(openList.length > 0) {
				
				var currentNode:GraphNode = openList[0];
				for(var i:int = 1; i < openList.length; i++) {
					if(openList[i].f < currentNode.f) { 
						currentNode = openList[i]; 
					}
				}
				
				if(currentNode.x == end.x && currentNode.y == end.y) {
					var result:Vector.<GraphNode> = new Vector.<GraphNode>();
					while(currentNode) {
						result[result.length] = currentNode;
						currentNode = currentNode.parent;
					}
					return result.reverse();
				}
				
				openList.splice( openList.indexOf(currentNode) ,1);
				closedList[closedList.length] = currentNode;
				
				var neighbors:Vector.<GraphNode> = graph.getNeighbors(currentNode);
				for( i = 0; i < neighbors.length; i++) {
					
					var neighbor:GraphNode = neighbors[i];
					if(closedList.indexOf(neighbor) != -1 || neighbor.isWall) {
						continue;
					}
					
					var curG:Number = currentNode.g + 1; 
					var isNew:Boolean = openList.indexOf(neighbor) == -1;
					
					if(isNew) {
						neighbor.h = heuristic(neighbor, end);
						openList.push(neighbor);
					}
					
					if(isNew || curG < neighbor.g) {
						neighbor.parent = currentNode;
						neighbor.g = curG;
						neighbor.f = neighbor.g + neighbor.h;
					}
					
				}
			}
			
			return null;
		}
		
		private function heuristic( pos0 : GraphNode, pos1 : GraphNode ) : int{
			var d1 : int = pos1.x - pos0.x;
			var	d2 : int = pos1.y - pos0.y;
			d1 = d1 < 0 ? -d1 : d1;
			d2 = d2 < 0 ? -d2 : d2;
			return d1 + d2;
		}

	}
}