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

//+------------------------------------------------------------------+
//| Open Trade with Trigger Logic V-01.01                            |
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

    // Determine trade direction and attempt to open
    if (momentumValue > TriggerFactor && lastCandleClose > lastCandleOpen)
    {
        double buyPrice = MarketInfo(symbol, MODE_ASK);

        // Check if BUY trades are within the limit
        if (OpenTrade(symbol, OP_BUY, buyPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2] = TimeCurrent(); // Update last BUY trade time
            return true;
        }
    }
    else if (momentumValue < -TriggerFactor && lastCandleOpen > lastCandleClose)
    {
        double sellPrice = MarketInfo(symbol, MODE_BID);

        // Check if SELL trades are within the limit
        if (OpenTrade(symbol, OP_SELL, sellPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2 + 1] = TimeCurrent(); // Update last SELL trade time
            return true;
        }
    }

    return false;
}

//+------------------------------------------------------------------+
//| Open Trade with Trigger Logic V-01.02                            |
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

    // Count existing trades for the symbol
    int buyCount = 0, sellCount = 0;
    CountExistingTrades(symbol, buyCount, sellCount);

    // Log current trade counts
    Print("Trade counts for ", symbol, ": BUY = ", buyCount, ", SELL = ", sellCount);

    // Primary Trade Logic (Momentum-Based)
    if (momentumValue > TriggerFactor && lastCandleClose > lastCandleOpen)
    {
        double buyPrice = MarketInfo(symbol, MODE_ASK);

        // Check if BUY trades are within the limit
        if (buyCount < PerSymbolMaxTrades / 2 && OpenTrade(symbol, OP_BUY, buyPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2] = TimeCurrent(); // Update last BUY trade time
            Print("Primary BUY trade opened for ", symbol);
            return true;
        }
    }
    else if (momentumValue < -TriggerFactor && lastCandleOpen > lastCandleClose)
    {
        double sellPrice = MarketInfo(symbol, MODE_BID);

        // Check if SELL trades are within the limit
        if (sellCount < PerSymbolMaxTrades / 2 && OpenTrade(symbol, OP_SELL, sellPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2 + 1] = TimeCurrent(); // Update last SELL trade time
            Print("Primary SELL trade opened for ", symbol);
            return true;
        }
    }

    // Counter-Trade Logic
    if (buyCount > sellCount + 1) // Open a counter SELL trade if imbalance exists
    {
        double sellPrice = MarketInfo(symbol, MODE_BID);

        if (sellCount < PerSymbolMaxTrades / 2 && OpenTrade(symbol, OP_SELL, sellPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2 + 1] = TimeCurrent(); // Update last SELL trade time
            Print("Counter SELL trade opened for ", symbol);
            return true;
        }
    }
    else if (sellCount > buyCount + 1) // Open a counter BUY trade if imbalance exists
    {
        double buyPrice = MarketInfo(symbol, MODE_ASK);

        if (buyCount < PerSymbolMaxTrades / 2 && OpenTrade(symbol, OP_BUY, buyPrice, LotSize))
        {
            lastTradeTimes[symbolIndex * 2] = TimeCurrent(); // Update last BUY trade time
            Print("Counter BUY trade opened for ", symbol);
            return true;
        }
    }

    Print("No trades opened for ", symbol, " (momentum or counter conditions not met).");
    return false;
}
