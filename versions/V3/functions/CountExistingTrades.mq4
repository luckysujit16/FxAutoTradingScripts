//+------------------------------------------------------------------+
//| Count Existing Trades                                            |
//+------------------------------------------------------------------+
void CountExistingTrades(string symbol, int &buyCount, int &sellCount)
{
    buyCount = 0;
    sellCount = 0;

    for (int i = 0; i < OrdersTotal(); i++)
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if (OrderSymbol() == symbol)
            {
                if (OrderType() == OP_BUY) buyCount++;
                else if (OrderType() == OP_SELL) sellCount++;
            }
        }
    }
}
