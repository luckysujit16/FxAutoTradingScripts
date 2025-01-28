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

    // Determine trade direction
    if (momentumValue > TriggerFactor && lastCandleClose > lastCandleOpen)
    {
        double buyPrice = MarketInfo(symbol, MODE_ASK);
        if (OpenTrade(symbol, OP_BUY, buyPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2] = TimeCurrent(); // Update last trade time for BUY
            return true;
        }
    }
    else if (momentumValue < -TriggerFactor && lastCandleOpen > lastCandleClose)
    {
        double sellPrice = MarketInfo(symbol, MODE_BID);
        if (OpenTrade(symbol, OP_SELL, sellPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2 + 1] = TimeCurrent(); // Update last trade time for SELL
            return true;
        }
    }

    return false;
}
