//+------------------------------------------------------------------+
//| Expert Initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   // Dynamically populate the Symbols array
    ArrayResize(Symbols, 3);
    Symbols[0] = Symbol1;
    Symbols[1] = Symbol2;
    Symbols[2] = Symbol3;

    // Initialize lastTradeTimes array for each symbol
    ArrayResize(lastTradeTimes, ArraySize(Symbols) * 2); // *2 for BUY and SELL
    for (int i = 0; i < ArraySize(lastTradeTimes); i++)
        lastTradeTimes[i] = 0;

    //Print("Symbols initialized: ", Symbols[0], ", ", Symbols[1], ", ", Symbols[2]);
    return(INIT_SUCCEEDED);
}
