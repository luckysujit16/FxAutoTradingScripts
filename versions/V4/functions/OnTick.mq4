//+------------------------------------------------------------------+
//| Main Function (OnTick)                                           |
//+------------------------------------------------------------------+

void OnTick()
{
    
     // Close trades with profit above $1
    CloseTradesOnProfit();

    // Log all active trades
    LogAllTradesStatus();
      
    // Check if the total number of trades has reached MAX_TRADES
    if (OrdersTotal() >= MAX_TRADES)
    {
        Print("Maximum trade limit reached (", MAX_TRADES, "). No further trades will be opened.");
        return;
    }
      
    for (int i = 0; i < ArraySize(Symbols); i++)
    {
        string currentSymbol = Symbols[i];

        // Ensure only one primary trade per symbol
        if (!HasPrimaryTrade(currentSymbol))
        {
            if (OpenTradeWithTrigger(currentSymbol, i)) // Pass index for cooldown tracking
            {
                Print("Primary trade opened for symbol: ", currentSymbol);
            }
        }
        else
        {
            // Ensure only one counter-trade per symbol
            if (!HasOpenTrade(currentSymbol, OP_BUY) || !HasOpenTrade(currentSymbol, OP_SELL))
            {
                if (OpenCounterTrade(currentSymbol, i))
                {
                    Print("Counter trade opened for symbol: ", currentSymbol);
                }
            }
            else
            {
                Print("Both trades already exist for ", currentSymbol, ". No counter trade needed.");
            }
        }
    }

   
}
