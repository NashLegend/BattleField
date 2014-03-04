package  
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.*;
	/**
	 * ...
	 * @author IJUST
	 */
	public class BattleField extends MovieClip 
	{
		private var PlayerIndex:Player;//轮流指针
		private var CardsType:String;//主动出牌还是被动出牌
		private var CardOld:Array=[]//已经出完的牌
		private var CardsPool:Array = []//已经出的牌，做为对比
		private var CardNow:Array = [];//刚刚出的牌，与前者比较
		private var AllCards:Array = [];
		private var AllBG:Array = [];
		private var LeftCards:Array = [];
		private var ignoreCount:int = 0;
		//按钮所在Panel
		private var btnPanel:Panel = new Panel();
		private var btnDispatch:btndisp = new btndisp();
		private var btnDismiss:btndim = new btndim();
		private var btnHint:btnhint = new btnhint();
		//建立三个角色,两个电脑,一个玩家
		private var player:Player;
		private var bot1:Player;
		private var bot2:Player;
		//玩家的"小桌",用于放玩家的牌;
		private var sp:Sprite;
		private var DeskLeft:desk;
		//出的牌
		private var DeskPlayerPool:desk;
		private var DeskBot1Pool:desk;
		private var DeskBot2Pool:desk;
		//未出的牌
		private var DeskPlayer:desk;
		private var DeskBot1:desk;
		private var DeskBot2:desk;
		
		private var Pass:pass = new pass();
		
		private var startPoint:Point;
		
		private var checktype:CheckType;
		//牌间隔
		private var dist:int = 20;
		//乱序用Math.random()重排
		public function BattleField() 
		{
			//初始化玩家与电脑
			InitPlayers();
			//洗牌
			InitCards();
			
			addChild(Pass);
		}
		private function InitPlayers():void 
		{
			player = new Player();
			bot1 = new Player();
			bot2 = new Player();
			addChild(player);
			addChild(bot1);
			addChild(bot2);
			//初始化玩家指针
			PlayerIndex = player;
			//初始化desk
			sp = new Sprite();
			
			DeskLeft = new desk(120, 120);
			
			DeskPlayer = new desk(500, 150);
			DeskPlayerPool = new desk(400, 125);
			
			DeskBot1 = new desk(80, 400);
			DeskBot1Pool = new desk(80, 400);
			
			DeskBot2 = new desk(80, 400);
			DeskBot2Pool = new desk(80, 400);
			
			DeskLeft.x = 480;
			DeskLeft.y = 20;
			DeskLeft.mouseChildren = false;
			DeskLeft.isPlayer = true;
			
			DeskPlayer.x = 290;
			DeskPlayer.y = 550;
			DeskPlayer.isPlayer = true;
			//DeskPlayer.CardArr = player.CardArr;
			DeskPlayerPool.x = 340;
			DeskPlayerPool.y = 375;
			DeskPlayerPool.isPlayer = true;
			DeskPlayerPool.mouseChildren = false;
			btnPanel.x = 400;
			btnPanel.y = 500;
			btnDismiss.x = 20 + btnDismiss.width / 2;
			btnDispatch.x = 100+btnDismiss.width/2;
			btnHint.x = 180 + btnHint.width / 2;
			btnDismiss.y = btnDispatch.y = btnHint.y = btnPanel.height / 2;
			
			
			DeskBot1.x = 950;
			DeskBot1.y = 120;
			DeskBot1Pool.x = 850;
			DeskBot1Pool.y = 120;
			DeskBot1.mouseChildren = false;
			DeskBot1Pool.mouseChildren = false;
			
			DeskBot2.x = 50;
			DeskBot2.y = 120;
			DeskBot2Pool.x = 150;
			DeskBot2Pool.y = 120;
			DeskBot2.mouseChildren = false;
			DeskBot2Pool.mouseChildren = false;
			
			addChild(DeskLeft);
			
			addChild(DeskPlayer);
			addChild(DeskPlayerPool);
			addChild(btnPanel);
			btnPanel.addChild(btnDismiss);
			btnPanel.addChild(btnDispatch);
			btnPanel.addChild(btnHint);
			
			addChild(DeskBot1);
			addChild(DeskBot1Pool);
			
			addChild(DeskBot2);
			addChild(DeskBot2Pool);
			
			addChild(sp);
			
			DeskPlayer.addEventListener(MouseEvent.MOUSE_DOWN, deskDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, deskUp);
			addEventListener(BF_EVENT.MATCH_ROUND, MatchRound);
			btnDismiss.addEventListener(MouseEvent.CLICK, Click_Cancel);
			btnDispatch.addEventListener(MouseEvent.CLICK, Click_Dispatch);
			btnHint.addEventListener(MouseEvent.CLICK, Click_Hint);
			
		}
		private function InitCards():void 
		{
			for (var i:int = 1; i < 55; i++) 
			{
				var gameCard:Card = new Card(i);
				AllCards.push(gameCard);
			}
			AllCards.sortOn("rnd");
			//洗牌完毕发牌
			dispatchCards();
		}
		private function dispatchCards():void 
		{
			//保留底牌
			LeftCards = AllCards.slice(51, 54);
			for (var j:int = 0; j < LeftCards.length; j++) 
			{
				var item:Card = LeftCards[j] as Card;
				DeskLeft.addCards(item,0);
			}
			DeskLeft.sort();
			//发牌  但是不发底牌
			//可以用时间轴来发牌
			for (var i:int = 0; i < 51; i++) 
			{
				var cardIndex:int = (AllCards[i] as Card).Index;
				var gameCard:Card = new Card(cardIndex);
				switch (PlayerIndex) 
				{
					case player:
						PlayerIndex.CardArr.push(gameCard);
						DeskPlayer.addCards(gameCard);
					break;
					case bot1:
						PlayerIndex.CardArr.push(gameCard);
						DeskBot1.addCards(gameCard);
					break;
					case bot2:
						PlayerIndex.CardArr.push(gameCard);
						DeskBot2.addCards(gameCard);
					break;
					default:
						
					break;
				}
				NextPlayer();
			}
			player.CardArr.sortOn("CardValue",Array.NUMERIC);
			bot1.CardArr.sortOn("CardValue",Array.NUMERIC );
			bot2.CardArr.sortOn("CardValue", Array.NUMERIC );
			DeskPlayer.sort();
			DeskBot1.sort();
			DeskBot2.sort();
			PlayerIndex = player;
			RaceOwner();//抢
		}
		private function RaceOwner():void 
		{
			//抢
			//省略 直接player
			//假设最终是Player得到
			PlayerIndex = player;
			//将CardLeft给到Owner数组里面去
			InsertOwnerCard();
			open();
		}
		private function InsertOwnerCard():void 
		{
			switch (PlayerIndex) 
			{
				case player:
					for (var i:int = 51; i < 54; i++) 
					{
						var item:Card = AllCards[i] as Card;
						PlayerIndex.CardArr.push(item);
						DeskPlayer.addCards(item);
					}
					player.CardArr.sortOn("CardValue", Array.NUMERIC);
					DeskPlayer.sort();
				break;
				case bot1:
					for (var j:int = 51; j < 54; j++) 
					{
						var item1:Card = AllCards[j] as Card;
						PlayerIndex.CardArr.push(item);
						DeskBot1.addCards(item1);
					}
					bot1.CardArr.sortOn("CardValue", Array.NUMERIC);
					DeskBot1.sort();
				break;
				case bot2:
					for (var k:int = 51; k < 54; k++) 
					{
						var item2:Card = AllCards[k] as Card;
						PlayerIndex.CardArr.push(item);
						DeskBot2.addCards(item2);
					}
					bot2.CardArr.sortOn("CardValue", Array.NUMERIC);
					DeskBot2.sort();
				break;
				default:
					
				break;
			}
		}
		private function open():void 
		{
			dispatchEvent(new Event(BF_EVENT.MATCH_ROUND));
			CardsType = data.POSITIVE_CARD;
		}
		private function MatchRound(e:Event):void 
		{
			//局面循环
			setTimeout(dela, 1000);
		}
		private function dela():void 
		{
			if (ignoreCount==2) 
			{
				CardsType = data.POSITIVE_CARD;
				ignoreCount = 0;
			}
			if (PlayerIndex==player)
			{
				btnPanel.visible = true;
			}
			else 
			{
				if (CardsType==data.POSITIVE_CARD) 
				{
					PlayerDispatchCard(PlayerIndex.CheckSelfCards());
				}
				else 
				{
					var arrdis:Array = PlayerIndex.CheckHasMatch(CardsPool, PlayerIndex.CardArr);
					if (arrdis.length>0)
					{
						PlayerDispatchCard(arrdis);
					}
					else 
					{
						ignoreCount++;
						displayPass();
						CardsType = data.PASSIVE_CARD;
						NextPlayer();
						dispatchEvent(new Event(BF_EVENT.MATCH_ROUND));
					}
				}
			}
		}
		private function displayPass():void 
		{
			switch (PlayerIndex) 
			{
				case bot1:
					DeskBot1Pool.removeAllCards();
					Pass.x = DeskBot1Pool.x+DeskBot1Pool.width/2;
					Pass.y = DeskBot1Pool.y+DeskBot1Pool.height/2;
					Pass.visible = true;
				break;
				case bot2:
					DeskBot2Pool.removeAllCards();
					Pass.x = DeskBot2Pool.x+DeskBot2Pool.width/2;
					Pass.y = DeskBot2Pool.y+DeskBot2Pool.height/2;
					Pass.visible = true;
				break;
				default:
					
				break;
			}
		}
		private function Click_Dispatch(e:MouseEvent):void 
		{
			if (PlayerIndex==player) 
			{
				var arrdis:Array = player.getSelectCard();
				if (CardsType==data.POSITIVE_CARD) 
				{
					if (player.CheckValid())
					{
						PlayerDispatchCard(arrdis);
						//除去已选
					}
				}
				else 
				{
					if (player.CheckHasMatch(CardsPool,arrdis,false).length>0) 
					{
						PlayerDispatchCard(arrdis);
					}
				}
			}
		}
		private function PlayerDispatchCard(DispatchArr:Array):void 
		{
			
			CardsPool = DispatchArr.concat();
			switch (PlayerIndex) 
			{
				case player:
					//应当先移动上一次的
					DeskPlayerPool.removeAllCards();
					DeskPlayerPool.addCardArray(DispatchArr);
					DeskPlayerPool.sort();
					player.SpliceSelectedCards();
					DeskPlayer.SpliceSelectedCards();
					btnPanel.visible = false;
				break;
				case bot1:
					DeskBot1Pool.removeAllCards();
					DeskBot1Pool.addCardArray(DispatchArr);
					DeskBot1Pool.sort();
					bot1.SpliceSelectedCards();
					DeskBot1.SpliceSelectedCards();
				break;
				case bot2:
					DeskBot2Pool.removeAllCards();
					DeskBot2Pool.addCardArray(DispatchArr);
					DeskBot2Pool.sort();
					bot2.SpliceSelectedCards();
					DeskBot2.SpliceSelectedCards();
				break;
				default:
					
				break;
				
				
			}
			Pass.visible = false;
			//完成后
			if (PlayerIndex.CardArr.length==0) 
			{
				trace("Game Over");
				return;
			}
			ignoreCount = 0;
			CardsType = data.PASSIVE_CARD;
			NextPlayer();
			dispatchEvent(new Event(BF_EVENT.MATCH_ROUND));
			//trace(PlayerIndex);
			
		}
		private function Click_Cancel(e:MouseEvent):void 
		{
			DeskPlayerPool.removeAllCards();
			Pass.x = DeskPlayerPool.x+DeskPlayerPool.width/2;
			Pass.y = DeskPlayerPool.y+DeskPlayerPool.height/2;
			Pass.visible = true;
			
			player.cancelSelect();
			if (PlayerIndex==player&&CardsType==data.PASSIVE_CARD) 
			{
				ignoreCount++;
				CardsType = data.PASSIVE_CARD;
				NextPlayer();
				dispatchEvent(new Event(BF_EVENT.MATCH_ROUND));
			}
			
		}
		private function Click_Hint(e:MouseEvent):void 
		{
			//提示
		}
		private function NextPlayer():void 
		{
			DeskPlayerPool.filters = null;
			DeskBot1Pool.filters = null;
			DeskBot2Pool.filters = null;
			switch (PlayerIndex) 
			{
				case player:
					PlayerIndex = bot1;
					DeskBot1Pool.filters = [new DropShadowFilter(10,225,0,0.8,6,6) ];
				break;
				case bot1:
					PlayerIndex = bot2;
					DeskBot2Pool.filters = [new DropShadowFilter(10,225,0,0.8,6,6) ];
				break;
				case bot2:
					PlayerIndex = player;
					DeskPlayerPool.filters = [new DropShadowFilter(10,225,0,0.8,6,6) ];
				break;
				default:
					
				break;
			}
		}
		private function deskDown(e:MouseEvent):void 
		{
			startPoint = new Point(mouseX,mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, deskMove);
		}
		private function deskUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, deskMove);
			for (var i:int = 0; i < player.CardArr.length; i++) 
			{
				var item:Card = player.CardArr[i] as Card;
				var po:Point = new Point(item.x, item.y);
				var poin:Point = DeskPlayer.localToGlobal(po);
				if (item.hitTestObject(sp)) 
				{
					if (mouseX < startPoint.x ) 
					{
						if (i != player.CardArr.length - 1 && mouseX - poin.x > dist ) 
						{
							
						}
						else 
						{
							item.select();
						}
					}
					else 
					{
						if (i != player.CardArr.length - 1 && startPoint.x - poin.x > dist ) 
						{
						
						}
						else 
						{
							item.select();
						}
					}
					
				}
			}
			sp.graphics.clear();
		}
		private function deskMove(e:MouseEvent):void 
		{
			if (mouseX>DeskPlayer.x&&mouseX<DeskPlayer.x+DeskPlayer.width&&mouseY>DeskPlayer.y&&mouseY<DeskPlayer.y+DeskPlayer.height) 
			{
				sp.graphics.clear();
				sp.graphics.beginFill(0x000099, 0.5);
				sp.graphics.lineStyle(1, 0x000099, 0.5);
				sp.graphics.drawRect(startPoint.x, startPoint.y, mouseX - startPoint.x, mouseY - startPoint.y);
				sp.graphics.endFill();
			}
		}
		
		
	}

}