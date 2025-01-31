//+------------------------------------------------------------------+
//| Expert Initialization                                            |
//+------------------------------------------------------------------+

int OnInit()
{
    // Dynamically populate the Symbols array
    ArrayResize(Symbols, 4);
    Symbols[0] = Symbol1;
    Symbols[1] = Symbol2;
    Symbols[2] = Symbol3; // Fixed this line
    Symbols[3] = Symbol4; // Added Symbol4 correctly

    // Initialize last trade times array for each symbol
    ArrayResize(lastTradeTimes, ArraySize(Symbols));
    for (int i = 0; i < ArraySize(lastTradeTimes); i++)
        lastTradeTimes[i] = 0;

    Print("Symbols initialized: ", Symbols[0], ", ", Symbols[1], ", ", Symbols[2], ", ", Symbols[3]);
    return(INIT_SUCCEEDED);
}

