package  
{
	/**
	 * ...
	 * 获得单双等及其数组
	 * @author IJUST
	 */
	public class CheckType 
	{
		public var CardsAll:Array = [];
		public var SingleArr:Array = [];
		public var DoubleArr:Array = [];
		public var TripleArr:Array = [];
		public var QuadrupleArr:Array = [];
		public var HasJokerVoice:Boolean;
		public var HasJoker:Boolean;
		public function CheckType(arr:Array)
		{
			CardsAll = arr.sortOn("CardValue",Array.NUMERIC);
			CheckSort();
		}
		
		public function CheckSort():void 
		{
			for (var i:int = 0; i < CardsAll.length; i++) 
			{
				var item:Card = CardsAll[i] as Card;
				var rePeat:int = NumberOf(item);
				switch (rePeat) 
				{
					case 1:
						SingleArr.push(item);
					break;
					case 2:
						DoubleArr.push(item);
						i += 1;
					break;
					case 3:
						TripleArr.push(item);
						i += 2;
					break;
					case 4:
						QuadrupleArr.push(item);
						i += 3;
					break;
					default:
						//trace("00000000000000000");
					break;
				}
			}
		}
		
		public function NumberOf(card:Card):int 
		{
			var totalRepeat:int = 0;
			for (var i:int = 0; i < CardsAll.length; i++) 
			{
				var item:Card = CardsAll[i] as Card;
				if (item.CardNumber==card.CardNumber) 
				{
					totalRepeat += 1;
				}
			}
			return totalRepeat;
		}
		
		
		public function CheckHasJoker():Boolean 
		{
			for (var i:int = 0; i < SingleArr.length; i++) 
			{
				var item:Card = SingleArr[i] as Card;
				if (item.CardNumber==54) 
				{
					return true;
				}
			}
			return false;
		}
		
		
		public function CheckHasJokerVoice():Boolean 
		{
			for (var i:int = 0; i < SingleArr.length; i++) 
			{
				var item:Card = SingleArr[i] as Card;
				if (item.CardNumber==53) 
				{
					return true;
				}
			}
			return false;
		}
		
	}

}