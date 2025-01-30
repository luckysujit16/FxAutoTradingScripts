//+------------------------------------------------------------------+
//| Main Function (OnTick)                                           |
//+------------------------------------------------------------------+

void OnTick()
{
    // Loop through all symbols sequentially
    for (int i = 0; i < ArraySize(Symbols); i++)
    {
        string currentSymbol = Symbols[i];

        // Check and handle primary trades
        if (!HasOpenTrade(currentSymbol))
        {
            if (OpenTradeWithTrigger(currentSymbol, i)) // Pass index for cooldown tracking
            {
                Print("Primary trade opened for symbol: ", currentSymbol);
            }
        }
        else
        {
            // Handle counter-trades if a primary trade exists
            if (OpenCounterTrade(currentSymbol, i))
            {
                Print("Counter trade opened for symbol: ", currentSymbol);
            }
        }
    }

    // Close trades with profit above $1
    CloseTradesOnProfit();

    // Log all active trades
    LogAllTradesStatus();
}
