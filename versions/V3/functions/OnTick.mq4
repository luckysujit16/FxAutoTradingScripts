//+------------------------------------------------------------------+
//| Main Function (OnTick)                                           |
//+------------------------------------------------------------------+
void OnTick()
{
    int globalBuyCount = 0, globalSellCount = 0;

    // Loop through all symbols sequentially
    for (int i = 0; i < ArraySize(Symbols); i++)
    {
        string currentSymbol = Symbols[i];

        // Manage trades for each symbol
        ManageSymbolTrades(currentSymbol, i, globalBuyCount, globalSellCount);
        
        // Close trades dynamically when profit exceeds $1
        CloseTradesOnProfit();

        // Check global max trades
        if (globalBuyCount + globalSellCount >= MaxTrades)
        {
            //Print("Global MaxTrades limit reached. No new trades will be opened.");
            return;
        }
    }

    // Close trades dynamically when profit exceeds $1
    // CloseTradesOnProfit();

    // Log the status of all open trades
    LogAllTradesStatus();
}