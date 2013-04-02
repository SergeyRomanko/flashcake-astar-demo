package astar{
	
	public class Graph{
		
		private var _width:uint = 0;
		private var _height:uint = 0;
		
		private var _widthMinusOne:int = 0;
		private var _heightMinusOne:int = 0;
		private var _area:uint = 0;
		
		private var _graph:Vector.<GraphNode> = null;
		private var _neighbors:Vector.<GraphNode> = new Vector.<GraphNode>();
		
		public function Graph(width:uint, height:uint){
			_width = width;
			_height = height;
			
			_widthMinusOne = width-1;
			_heightMinusOne = height-1;
			_area = width*height;
			
			_graph = new Vector.<GraphNode>(_area,true);
			
			for (var i:int = 0; i < _area; i++) {
				_graph[i] = new GraphNode(int(i/_height),i%_height);
			}
		}

		public function get width():uint{
			return _width;
		}
		
		public function get height():uint{
			return _height;
		}
		
		public function getNeighbors(currentNode:GraphNode):Vector.<GraphNode>{
			_neighbors.length = 0;
			
			var x:uint = currentNode.x;
			var y:uint = currentNode.y;
			
			if (y > 0)
				var top:GraphNode = _neighbors[_neighbors.length] = getNode(x,y - 1);
			if (y < _heightMinusOne)
				var bottom:GraphNode = _neighbors[_neighbors.length] = getNode(x,y + 1);
			
			if (x > 0) {
				var left:GraphNode = _neighbors[_neighbors.length] = getNode(x - 1,y);
				if(!left.isWall){
					if (y > 0 && !top.isWall)
						_neighbors[_neighbors.length] = getNode(x - 1,y - 1);
					if (y < _heightMinusOne && !bottom.isWall)
						_neighbors[_neighbors.length] = getNode(x - 1,y + 1);
				}
			}
			if (x < _widthMinusOne) {
				var right:GraphNode = _neighbors[_neighbors.length] = getNode(x + 1,y);
				if(!right.isWall){
					if (y > 0 && !top.isWall)
						_neighbors[_neighbors.length] = getNode(x + 1,y - 1);
					if (y < _heightMinusOne && !bottom.isWall)
						_neighbors[_neighbors.length] = getNode(x + 1,y + 1);
				}
			}
			
			return _neighbors;
		}
		
		public function getNodeAt(x:int,y:int):GraphNode{
			var index:int = (x*_height)+y;
			return (index>=0 && index<_area) ? _graph[index] : null;
		}
		
		private function getNode(x:int,y:int):GraphNode{
			return _graph[(x*_height)+y];
		}
		
	}
}