//+------------------------------------------------------------------+
//| Manage Trades for Each Symbol                                    |
//+------------------------------------------------------------------+
void ManageSymbolTrades(string symbol, int symbolIndex, int &globalBuyCount, int &globalSellCount)
{
    int buyCount = 0, sellCount = 0;
    CountExistingTrades(symbol, buyCount, sellCount);

    // Update global trade counts
    globalBuyCount += buyCount;
    globalSellCount += sellCount;

    //Print("Managing trades for symbol: ", symbol, 
    //      " | Current BUY trades: ", buyCount, 
    //      " | Current SELL trades: ", sellCount);

    // Prevent new trades if cooling period is active for BUY or SELL
    if (TimeCurrent() - lastTradeTimes[symbolIndex * 2] < CoolingPeriod && buyCount < PerSymbolMaxTrades / 2)
    {
        Print("Cooling period active for BUY trades on ", symbol, ". No new trades will be opened.");
        return;
    }
    if (TimeCurrent() - lastTradeTimes[symbolIndex * 2 + 1] < CoolingPeriod && sellCount < PerSymbolMaxTrades / 2)
    {
        Print("Cooling period active for SELL trades on ", symbol, ". No new trades will be opened.");
        return;
    }

    // Check if we can open more trades for this symbol
    if (buyCount + sellCount >= PerSymbolMaxTrades)
    {
        //Print("Per-symbol MaxTrades limit reached for ", symbol, ". No new trades will be opened.");
        return;
    }

    // Attempt to open a trade for the symbol
    if (OpenTradeWithTrigger(symbol, symbolIndex))
    {
        Print("Trade opened successfully for symbol: ", symbol);
    }
}
