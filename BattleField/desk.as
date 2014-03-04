package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author IJUST
	 */
	public class desk extends MovieClip 
	{
		public var isPlayer:Boolean = false;
		public var CardArr:Array ;
		public function desk(w:int,h:int)
		{
			CardArr = [];
			graphics.beginFill(1, 0.01);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		public function addCards(card:Card,posY:int=25):void 
		{
			addChild(card);
			if (isPlayer) 
			{
				card.x = this.numChildren * 20 - 20;
				card.y = posY;
			}
			else 
			{
				card.y = this.numChildren * 20-20;
			}
		}
		public function removeAllCards():void 
		{
			getCardArr();
			for (var i:int = CardArr.length - 1; i >= 0; i--) 
			{
				var item:Card = CardArr[i] as Card;
				this.removeChild(item);
				CardArr.splice(i, 1);
			}
		}
		public function addCardArray(arr:Array):void 
		{
			for (var i:int = 0; i < arr.length; i++) 
			{
				var item:Card = arr[i] as Card;
				addCards(item,0);
			}
			sort();
		}
		private function getCardArr():void 
		{
			CardArr = [];
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				var item:Card = getChildAt(i) as Card;
				CardArr.push(item);
			}
			CardArr.sortOn("CardValue",Array.NUMERIC);
		}
		public function sort():void
		{
			getCardArr();
			if (isPlayer) 
			{
				var cardlong = CardArr.length * 20 + 60;
				var beginx = (this.width - cardlong) / 2;
				for (var i:int = 0; i < CardArr.length; i++) 
				{
					var item:Card = CardArr[i] as Card;
					item.x = i * 20+beginx;
					this.setChildIndex(CardArr[i], i);
				}
			}
			else 
			{
				var cardlongs = CardArr.length * 20 + 60;
				var beginys = (this.height - cardlongs) / 2;
				for (var j:int = 0; j < CardArr.length; j++) 
				{
					var items:Card = CardArr[j] as Card;
					items.y = j * 20+beginys;
					this.setChildIndex(CardArr[j], j);
				}
			}
		}
		public function SpliceSelectedCards():void 
		{
			getCardArr();
			for (var i:int = CardArr.length-1; i >=0; i--) 
			{
				var item:Card = CardArr[i] as Card;
				if (item.isselect) 
				{
					removeChild(item);
					CardArr.splice(i, 1);
				}
			}
			sort();
		}
		
	}

}