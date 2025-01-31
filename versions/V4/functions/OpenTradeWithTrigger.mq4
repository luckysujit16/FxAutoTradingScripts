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
    
    // Ensure we do not exceed MAX_TRADES
    if (OrdersTotal() >= MAX_TRADES)
    {
        Print("Maximum trade limit reached (", MAX_TRADES, "). Primary trade not opened for ", symbol);
        return false;
    }

    int orderType = -1; 
    double price = 0.0;

    if (momentumValue > TriggerFactor && lastCandleClose > lastCandleOpen)
    {
        orderType = OP_BUY;
        price = MarketInfo(symbol, MODE_ASK);

        // Check if a BUY trade already exists with the same price
        if (HasOpenTrade(symbol, OP_BUY, price))
        {
            Print("Duplicate BUY trade detected for ", symbol, ". Skipping trade.");
            return false;
        }
    }
    else if (momentumValue < TriggerFactor && lastCandleOpen > lastCandleClose)
    {
        orderType = OP_SELL;
        price = MarketInfo(symbol, MODE_BID);

        // Check if a SELL trade already exists with the same price
        if (HasOpenTrade(symbol, OP_SELL, price))
        {
            Print("Duplicate SELL trade detected for ", symbol, ". Skipping trade.");
            return false;
        }
    }

    // Ensure no duplicate primary trade
    if (HasPrimaryTrade(symbol))
    {
        Print("Primary trade already exists for ", symbol, ". Skipping trade.");
        return false;
    }

    // Open the primary trade
    if (orderType != -1 && OpenTrade(symbol, orderType, price, LotSize))
    {
        lastTradeTimes[symbolIndex] = TimeCurrent(); // Update last trade time
        Print((orderType == OP_BUY ? "BUY" : "SELL"), " trade opened as PRIMARY for ", symbol);
        return true;
    }

    return false;
}
