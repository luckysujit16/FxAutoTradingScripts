//+------------------------------------------------------------------+
//| Open Trade with Trigger Logic                                    |
//+------------------------------------------------------------------+

bool OpenTradeWithTrigger(string symbol, int symbolIndex)
{
    double momentumValue, lastCandleOpen, lastCandleClose;

    // Check momentum conditions
    if (!CheckMomentumTrigger(symbol, momentumValue, lastCandleOpen, lastCandleClose))
    {
        Print("Momentum conditions not met for ", symbol, ". No trades opened.");
        return false;
    }

    // Prevent multiple trades by enforcing a cooling period
    if (TimeCurrent() - lastTradeTimes[symbolIndex] < 10) // Cooling period (10 seconds)
    {
        Print("Cooling period active for ", symbol, ". No new trades.");
        return false;
    }

    // Determine trade direction based on momentum
    int orderType = -1; // Default to no order
    double price = 0.0;

    if (momentumValue > TriggerFactor && lastCandleClose > lastCandleOpen)
    {
        orderType = OP_BUY;
        price = MarketInfo(symbol, MODE_ASK);
    }
    else if (momentumValue < -TriggerFactor && lastCandleOpen > lastCandleClose)
    {
        orderType = OP_SELL;
        price = MarketInfo(symbol, MODE_BID);
    }

    if (orderType != -1 && OpenTrade(symbol, orderType, price, LotSize))
    {
        lastTradeTimes[symbolIndex] = TimeCurrent(); // Update the last trade time
        Print((orderType == OP_BUY ? "BUY" : "SELL"), " trade opened for ", symbol);
        return true;
    }

    Print("No trades opened for ", symbol, ". Momentum conditions not met.");
    return false;
}
