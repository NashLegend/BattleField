package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import Card;
	/**
	 * ...
	 * @author IJUST
	 */
	public class Player extends MovieClip
	{
		public var CardsPool:Array;
		public var CardArr:Array;//The total cards of the player
		public var CardSelect:Array;
		public var checktype:CheckType;
		public var outArr:Array ;
		
		public function Player() 
		{
			CardArr = [];
			CardSelect = [];
			outArr = [];
			//玩家函数
		}
		public function DispatchCards():Array 
		{
			return [];
		}
		public function CheckSelfCards():Array 
		{
			//从小开始
			outArr = [];
			var CKtype:CheckType = new CheckType(CardArr);
			if (CKtype.SingleArr.length) 
			{
				OutVeryNumber(CKtype.SingleArr[0].CardValue, 1);
				return outArr;
			}
			if (CKtype.DoubleArr.length) 
			{
				OutVeryNumber(CKtype.DoubleArr[0].CardValue, 1);
				return outArr;
			}
			if (CKtype.TripleArr.length) 
			{
				OutVeryNumber(CKtype.TripleArr[0].CardValue, 1);
				return outArr;
			}
			if (CKtype.QuadrupleArr.length) 
			{
				OutVeryNumber(CKtype.QuadrupleArr[0].CardValue, 1);
				return outArr;
			}
			return outArr;
			
		}
		private function getCheckSingle(arrPure:Array,cardPure:Card=null,sliceNum:int=1,checkSelect:Boolean=true):Boolean 
		{
			var flag:Boolean = false;
			var toBig:int = 0;
			if (cardPure!=null) 
			{
				toBig = cardPure.CardValue;
			}
			if (arrPure.length>0) 
			{
				for (var i:int = 0; i < arrPure.length; i++) 
				{
					var item:Card = arrPure[i] as Card;
					//trace(item.isselect, checkSelect, item.isselect != checkSelect, item.CardValue, toBig)
					
					if (item.isselect!=checkSelect&&item.CardValue>toBig) 
					{
						OutVeryNumber(item.CardValue, sliceNum,checkSelect);
						flag = true;
						break;
					}
				}
			}
			return flag;
		}
		private function CheckMsequenceN(arrcon:Array,m:int,n:int,sliceNum:int=1,checkSelect:Boolean=true):Boolean 
		{
			//检查arrcon里面是否有这样的一组，它们至少以m开头，长度为n
			//outArr = [];//看似不需要
			arrcon.sortOn("CardValue",Array.NUMERIC);
			for (var i:int = 0; i < arrcon.length; i++)
			{
				var item:Card = arrcon[i] as Card;
				if (i+n>arrcon.length) 
				{
					return false;
				}
				if (item.CardValue<=m) 
				{
					continue;
				}
				else 
				{
					for (var j:int = i; j < i+n-1; j++) 
					{
						var item1:Card = arrcon[j] as Card;
						var item2:Card = arrcon[j + 1] as Card;
						if (item1.CardValue+1!=item2.CardValue) 
						{
							break;
						}
						if (j==i+n-2)
						{
							for (var k:int = i; k < i+n; k++)
							{
								var car:Card = arrcon[k] as Card;
								OutVeryNumber(car.CardValue, sliceNum,checkSelect);
							}
							return true;
						}
					}
				}
			}
			return false;
		}
		private function pickOutAny(arrAny:Array,num:int,checkSelect:Boolean=true):Boolean 
		{
			var cardPicArr:Array = [];
			if (arrAny.length<num) 
			{
				return false;
			}
			else 
			{
				if (checkSelect) 
				{
					for (var i:int = 0; i < arrAny.length; i++) 
					{
						var item:Card = arrAny[i] as Card;
						if (item.isselect)
						{
							return false;
						}
						else 
						{
							cardPicArr.push(item);
							if (cardPicArr.length>=num) 
							{
								for (var m:int = 0; m < cardPicArr.length; m++) 
								{
									var items:Card = cardPicArr[m] as Card;
									OutVeryNumber(items.CardValue, 1,checkSelect);
								}
								return true;
							}
						}
					}
				}
				else 
				{
					for (var q:int = 0; q < arrAny.length; q++) 
					{
						var itemq:Card = arrAny[q] as Card;
						if (itemq.isOutSelect)
						{
							return false;
						}
						else 
						{
							cardPicArr.push(itemq);
							if (cardPicArr.length>=num) 
							{
								for (var n:int = 0; n < cardPicArr.length; n++) 
								{
									var itemn:Card = cardPicArr[n] as Card;
									OutVeryNumber(itemn.CardValue, 1,checkSelect);
								}
								return true;
							}
						}
					}
				}
				
			}
			return false;
		}
		private function pickOutAnyDouble(arrAnyDouble:Array,num:int,checkSelect:Boolean=true):Boolean 
		{
			var cardPicArr:Array = [];
			if (arrAnyDouble.length<num) 
			{
				return false;
			}
			else 
			{
				if (checkSelect) 
				{
					for (var i:int = 0; i < arrAnyDouble.length; i++) 
					{
						var item:Card = cardPicArr[i] as Card;
						if (item.isselect) 
						{
							continue;
						}
						else 
						{
							for (var j:int = i; j < arrAnyDouble.length; j++) 
							{
								var itemj:Card = cardPicArr[j] as Card;
								if (itemj.CardValue==item.CardValue) //有双
								{
									cardPicArr.push(item, itemj);
									OutVeryNumber(item.CardValue,2);
									if (cardPicArr.length==num*2) 
									{
										return true;
									}
									break;
								}
							}
						}
					}
					return false;
				}
				else 
				{
					for (var k:int = 0; k < arrAnyDouble.length; k++) 
					{
						var itemk:Card = arrAnyDouble[k] as Card;
						if (itemk.isOutSelect) 
						{
							continue;
						}
						else 
						{
							for (var l:int = k; l < cardPicArr.length; l++) 
							{
								var iteml:Card = cardPicArr[l] as Card;
								if (iteml.CardValue==itemk.CardValue) //有双
								{
									cardPicArr.push(itemk, iteml);
									OutVeryNumber(item.CardValue,2);
									if (cardPicArr.length==num*2) 
									{
										return true;
									}
									break;
								}
							}
						}
					}
					return false;
				}
			}
			
		}
		public function OutVeryNumber(val:int,num:int,checkSelect:Boolean=true):void
		{
			var n:int = 0;
			for (var i:int = 0; i < CardArr.length; i++) 
			{
				var item:Card = CardArr[i] as Card;
				if (item.CardValue == val && n < num &&item.isselect!=checkSelect) 
				{
					if (checkSelect) 
					{
						item.isselect = true;
					}
					else 
					{
						item.isOutSelect = true;
					}
					outArr.push(item);
					n++;
				}
			}
		}
		public function CheckHasMatch(arrPool:Array,thisarr:Array,checkSelect:Boolean=true):Array 
		{
			outArr = [];
			//检查是否有Match者  另外  未对应出炸弹
			CardsPool = arrPool;
			var TheType:String = CheckCardType();
			var othCkType:CheckType = new CheckType(arrPool);
			var thisCkType:CheckType = new CheckType(thisarr);//此时排序已成了正序
			var findMatch:Boolean = false;
			var Card2Match:Card = arrPool[0] as Card//第一张
			var CardsLength:int = arrPool.length;
			switch (TheType)
			{
				case data.SINGLE_CARD:
					//菲为单
					//若自己有单 则先出单，此时未考虑顺序因素，应为：出单张且不在顺子里面的
					//检查单张，若单张中无 
					if (!getCheckSingle(thisCkType.SingleArr.concat(thisCkType.DoubleArr,thisCkType.TripleArr), Card2Match,1,checkSelect)) 
					{
						outArr = [];
					}
				break;
				case data.DOUBLE_CARD:
					if (!getCheckSingle(thisCkType.DoubleArr, Card2Match,2,checkSelect)) 
					{
						//现在双张中无，则检查三张 若仍无……
						if (!getCheckSingle(thisCkType.TripleArr, Card2Match,2,checkSelect)) 
						{
							//若仍没有那就撤吧 四的出太有风险
						}
					}
				break;
				case data.TRIPLE_CARD:
					if (!getCheckSingle(thisCkType.TripleArr, Card2Match,3,checkSelect))
					{
						//若仍没有那就撤吧 四的出太有风险
					}
				break;
				case data.QUADRUPLE_CARD:
					if (!getCheckSingle(thisCkType.QuadrupleArr, Card2Match,4,checkSelect)) 
					{
						//若仍没有那就撤吧 四的出太有风险
					}
				break;
				case data.DOUBLE_JOKER_CARD:
					//无解
				break;
				case data.ORDER_CARD:
					//对于有序者来说
					if (!CheckMsequenceN(thisCkType.SingleArr, arrPool[0].CardValue, CardsLength,1,checkSelect)) 
					{
						if (!CheckMsequenceN(thisCkType.SingleArr.concat(thisCkType.DoubleArr), arrPool[0].CardValue, CardsLength,1,checkSelect))  
						{
							if (!CheckMsequenceN(thisCkType.SingleArr.concat(thisCkType.DoubleArr,thisCkType.TripleArr), arrPool[0].CardValue, CardsLength,1,checkSelect))  
							{
								
							}
						}
					}
				break;
				case data.DOUBLE_ORDER_CARD:
					if (!CheckMsequenceN(thisCkType.DoubleArr, arrPool[0].CardValue, CardsLength/2,2,checkSelect))  
					{
						if (!CheckMsequenceN(thisCkType.DoubleArr.concat(thisCkType.TripleArr), arrPool[0].CardValue, CardsLength/2,2,checkSelect))  
						{
							
						}
					}
				break;
				case data.TRIPLE_ORDER_CARD:
					if (!CheckMsequenceN(thisCkType.TripleArr, arrPool[0].CardValue, CardsLength/3,3,checkSelect))  
					{
						
					}
				break;
				case data.QUADRUPLE_ORDER_CARD:
					if (!CheckMsequenceN(thisCkType.QuadrupleArr, arrPool[0].CardValue, CardsLength/4,4,checkSelect))  
					{
						
					}
				break;
				case data.SINGLE_3P1_CARD:
					//先查看是否有三张  若有的话
					if (getCheckSingle(thisCkType.TripleArr, othCkType.TripleArr[0],3,checkSelect)) 
					{
						//现在的情况是有  再找单张的  随便找了
						if (!pickOutAny(thisCkType.SingleArr.concat(thisCkType.DoubleArr,thisCkType.TripleArr),1,checkSelect)) 
						{
							outArr = [];
						}
					}
					
				break;
				case data.DOUBLE_3P1_CARD:
					if (CheckMsequenceN(thisCkType.TripleArr, othCkType.TripleArr[0].CardValue, 2,3,checkSelect))  
					{
						if (!pickOutAny(thisarr,2,checkSelect)) 
						{
							outArr = [];
						}
					}
					//否则bomb it
				break;
				case data.TRIPLE_3P1_CARD:
					if (CheckMsequenceN(thisCkType.TripleArr, othCkType.TripleArr[0].CardValue, 3,3,checkSelect))  
					{
						if (!pickOutAny(thisarr,3,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.QUADRUPLE_3P1_CARD:
					if (CheckMsequenceN(thisCkType.TripleArr, othCkType.TripleArr[0].CardValue, 4,3,checkSelect))  
					{
						if (!pickOutAny(thisarr,4,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.DOUBLE_3P2_CARD:
					if (CheckMsequenceN(thisCkType.TripleArr, othCkType.TripleArr[0].CardValue, 2,3,checkSelect))  
					{
						if (!pickOutAnyDouble(thisarr,2,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.TRIPLE_3P2_CARD:
					if (CheckMsequenceN(thisCkType.TripleArr, othCkType.TripleArr[0].CardValue, 3,3,checkSelect))  
					{
						if (!pickOutAnyDouble(thisarr,3,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.SINGLE_4P2_CARD:
					if (getCheckSingle(thisCkType.QuadrupleArr, othCkType.QuadrupleArr[0],4,checkSelect)) 
					{
						//现在的情况是有  再找单张的  随便找了
						if (!pickOutAnyDouble(thisarr,1,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.DOUBLE_4P2_CARD:
					if (CheckMsequenceN(thisCkType.QuadrupleArr, othCkType.QuadrupleArr[0].CardValue, 2,4,checkSelect))  
					{
						if (!pickOutAnyDouble(thisarr,2,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				case data.TRIPLE_4P2_CARD:
					if (CheckMsequenceN(thisCkType.QuadrupleArr, othCkType.QuadrupleArr[0].CardValue, 3,4,checkSelect))  
					{
						if (!pickOutAnyDouble(thisarr,3,checkSelect)) 
						{
							outArr = [];
						}
					}
				break;
				default:
					
				break;
			}
			return outArr;
		}
		public function CheckMatch(arr:Array):void 
		{
			//检查已经选中者是否符合
			//无需些函数,只需重用CheckHasMatch()即可
		}
		public function CheckValid():Boolean 
		{
			CardsPool = getSelectCard();
			var type:String = CheckCardType();
			if (type==data.UNDEFINED_CARD) 
			{
				return false;
			}
			else 
			{
				return true
			}
		}
		
		public function getSelectCard():Array 
		{
			CardSelect = [];
			for (var i:int = 0; i < CardArr.length; i++) 
			{
				var item:Card = CardArr[i] as Card;
				if (item.isselect) 
				{
					CardSelect.push(item);
				}
			}
			return CardSelect;
		}
		public function cancelSelect():void 
		{
			for (var i:int = 0; i < CardArr.length; i++) 
			{
				var item:Card = CardArr[i] as Card;
				if (item.isselect)
				{
					item.select();
				}
			}
		}
		public function SpliceSelectedCards():void 
		{
			for (var i:int = CardArr.length - 1; i >= 0 ; i-- ) 
			{
				var item:Card = CardArr[i] as Card;
				if (item.isselect) 
				{
					CardArr.splice(i, 1);
				}
			}
			//trace("@@@@@@@@@@@@@@@@@@@@");
			//trace(CardArr.length);
		}
		
		private function CheckCardType():String 
		{
			CardsPool.sortOn("CardValue");
			checktype = new CheckType(CardsPool);
			//下面应该是一堆if
			if (CheckSingle())
			{
				//trace(data.SINGLE_CARD);
				return data.SINGLE_CARD;
			}
			if (CheckDouble())
			{
				//trace(data.DOUBLE_CARD);
				return data.DOUBLE_CARD;
			}
			if (CheckTriple())
			{
				//trace(data.TRIPLE_CARD);
				return data.TRIPLE_CARD;
			}
			if (CheckQuadruple())
			{
				//trace(data.QUADRUPLE_CARD);
				return data.QUADRUPLE_CARD;
			}
			if (CheckDoubleJoker()) 
			{
				//trace(data.DOUBLE_JOKER_CARD);
				return data.DOUBLE_JOKER_CARD;
			}
			if (CheckOrder()) 
			{
				//trace(data.ORDER_CARD);
				return data.ORDER_CARD;
			}
			if (CheckDoubleOrder()) 
			{
				//trace(data.DOUBLE_ORDER_CARD);
				return data.DOUBLE_ORDER_CARD;
			}
			if (CheckTripleOrder()) 
			{
				//trace(data.TRIPLE_ORDER_CARD);
				return data.TRIPLE_ORDER_CARD;
			}
			if (CheckQuadrupleOrder()) 
			{
				//trace(data.QUADRUPLE_ORDER_CARD);
				return data.QUADRUPLE_ORDER_CARD;
			}
			if (Check3P1()) 
			{
				//trace(data.SINGLE_3P1_CARD);
				return data.SINGLE_3P1_CARD;

			}
			if (CheckDouble3P1()) 
			{
				//trace(data.DOUBLE_3P1_CARD);
				return data.DOUBLE_3P1_CARD;
			}
			if (CheckTriple3P1()) 
			{
				//trace(data.TRIPLE_3P1_CARD);
				return data.TRIPLE_3P1_CARD;
			}
			if (CheckQuadruple3P1()) 
			{
				//trace(data.QUADRUPLE_3P1_CARD);
				return data.QUADRUPLE_3P1_CARD;
			}
			if (CheckDouble3P2()) 
			{
				//trace(data.DOUBLE_3P2_CARD);
				return data.DOUBLE_3P2_CARD;
			}
			if (CheckTriple3P2()) 
			{
				//trace(data.TRIPLE_3P2_CARD);
				return data.TRIPLE_3P2_CARD;
			}
			if (Check4P2()) 
			{
				//trace(data.SINGLE_4P2_CARD);
				return data.SINGLE_4P2_CARD;
			}
			if (CheckDouble4P2()) 
			{
				//trace(data.DOUBLE_4P2_CARD);
				return data.DOUBLE_4P2_CARD;
			}
			if (CheckTriple4P2()) 
			{
				//trace(data.TRIPLE_4P2_CARD);
				return data.TRIPLE_4P2_CARD;
			}
			return data.UNDEFINED_CARD;
		}
		
		private function CheckSingle():Boolean 
		{
			if (CardsPool.length==1) 
			{
				return true;
			}
			return false;
		}
		private function CheckDouble():Boolean 
		{
			if (CardsPool.length==2) 
			{
				if (CardsPool[0].CardValue==CardsPool[1].CardValue) 
				{
					return true;
				}
				return false;
			}
			return false;
		}
		private function CheckTriple():Boolean 
		{
			if (CardsPool.length==3) 
			{
				if (CardsPool[0].CardValue==CardsPool[1].CardValue&&CardsPool[1].CardValue==CardsPool[2].CardValue) 
				{
					return true;
				}
				return false;
			}
			return false;
		}
		private function CheckQuadruple():Boolean 
		{
			if (CardsPool.length==4) 
			{
				if (CardsPool[0].CardValue==CardsPool[1].CardValue&&CardsPool[1].CardValue==CardsPool[2].CardValue&&CardsPool[2].CardValue==CardsPool[3].CardValue) 
				{
					return true;
				}
				return false;
			}
			return false;
		}
		
		private function CheckDoubleJoker():Boolean 
		{
			if (CardsPool.length==2) 
			{
				if (CardsPool[0].CardValue>14&&CardsPool[1].CardValue>14) 
				{
					return true;
				}
				return false;
			}
			return false;
		}
		
		
		private function CheckOrder():Boolean
		{
			if (CardsPool.length<5||CardsPool.length>12) 
			{
				return false;
			}
			else 
			{
				if (checktype.SingleArr.length==CardsPool.length) 
				{
					for (var j:int = 0; j < checktype.SingleArr.length-1; j++) 
					{
						if (checktype.SingleArr[j].CardValue+1!=checktype.SingleArr[j+1].CardValue) 
						{
							return false;
						}
					}
					return true;
				}
				else 
				{
					return false;
				}
			}
		}
		private function CheckDoubleOrder():Boolean 
		{
			if (CardsPool.length%2!=0||CardsPool.length<6) 
			{
				return false;
			}
			else 
			{
				CardsPool.sortOn("CardValue", Array.NUMERIC);
				if (checktype.DoubleArr.length==CardsPool.length/2) 
				{
					for (var j:int = 0; j < checktype.DoubleArr.length-1; j++) 
					{
						if (checktype.DoubleArr[j].CardValue+1!=checktype.DoubleArr[j+1].CardValue) 
						{
							return false;
						}
					}
					return true;
				}
				else 
				{
					return false;
				}
			}
		}
		private function CheckTripleOrder():Boolean 
		{
			if (CardsPool.length%3!=0||CardsPool.length<6) 
			{
				return false;
			}
			else 
			{
				CardsPool.sortOn("CardValue", Array.NUMERIC);
				if (checktype.TripleArr.length==CardsPool.length/3) 
				{
					for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
					{
						if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
						{
							return false;
						}
					}
					return true;
				}
				else 
				{
					return false;
				}
			}
		}
		private function CheckQuadrupleOrder():Boolean 
		{
			if (CardsPool.length%4!=0||CardsPool.length<8) 
			{
				return false;
			}
			else 
			{
				CardsPool.sortOn("CardValue", Array.NUMERIC);
				if (checktype.QuadrupleArr.length==CardsPool.length/4) 
				{
					for (var j:int = 0; j < checktype.QuadrupleArr.length-1; j++) 
					{
						if (checktype.QuadrupleArr[j].CardValue+1!=checktype.QuadrupleArr[j+1].CardValue) 
						{
							return false;
						}
					}
					return true;
				}
				else 
				{
					return false;
				}
			}
		}
		//3+1
		private function Check3P1():Boolean 
		{
			if (CardsPool.length!=4) 
			{
				return false;
			}
			if (checktype.SingleArr.length==1&&checktype.TripleArr.length==1) 
			{
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(3+1)*2
		private function CheckDouble3P1():Boolean 
		{
			if (CardsPool.length!=8) 
			{
				return false;
			}
			//情况为3 3 1 1 和 4 3 1 暂时只考虑经典的一种
			if (checktype.SingleArr.length==2&&checktype.TripleArr.length==2) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
				{
					if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(3+1)*3
		private function CheckTriple3P1():Boolean 
		{
			if (CardsPool.length!=12) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.SingleArr.length==3&&checktype.TripleArr.length==3) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
				{
					if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(3+1)*4
		private function CheckQuadruple3P1():Boolean 
		{
			if (CardsPool.length!=16) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.SingleArr.length==4&&checktype.TripleArr.length==4) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
				{
					if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(3+2)*2
		private function CheckDouble3P2():Boolean 
		{
			if (CardsPool.length!=10) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.DoubleArr.length==2&&checktype.TripleArr.length==2) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
				{
					if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(3+2)*3
		private function CheckTriple3P2():Boolean 
		{
			if (CardsPool.length!=15) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.DoubleArr.length==3&&checktype.TripleArr.length==3) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.TripleArr.length-1; j++) 
				{
					if (checktype.TripleArr[j].CardValue+1!=checktype.TripleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//4+2
		private function Check4P2():Boolean 
		{
			if (CardsPool.length!=6) 
			{
				return false;
			}
			
			if (checktype.QuadrupleArr.length==1&&checktype.DoubleArr.length==1) 
			{
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(4+2)*2
		private function CheckDouble4P2():Boolean 
		{
			if (CardsPool.length!=12) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.DoubleArr.length==2&&checktype.QuadrupleArr.length==2) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.QuadrupleArr.length-1; j++) 
				{
					if (checktype.QuadrupleArr[j].CardValue+1!=checktype.QuadrupleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		//(4+2)*3
		private function CheckTriple4P2():Boolean 
		{
			if (CardsPool.length!=18) 
			{
				return false;
			}
			//情况为  只考虑经典情况
			if (checktype.DoubleArr.length==3&&checktype.QuadrupleArr.length==3) 
			{
				//3张为连续
				for (var j:int = 0; j < checktype.QuadrupleArr.length-1; j++) 
				{
					if (checktype.QuadrupleArr[j].CardValue+1!=checktype.QuadrupleArr[j+1].CardValue) 
					{
						return false;
					}
				}
				return true;
			}
			else 
			{
				return false;
			}
		}
		
	}

}