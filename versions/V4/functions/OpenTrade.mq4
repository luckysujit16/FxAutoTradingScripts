//+------------------------------------------------------------------+
//| Open a Trade                                                     |
//+------------------------------------------------------------------+

bool OpenTrade(string symbol, int orderType, double price, double lot)
{
    int ticket = OrderSend(symbol, orderType, lot, price, 3, 0, 0, "Momentum Trade", 0, 0, clrBlue);
    if (ticket < 0)
    {
        Print("Failed to open trade on ", symbol, ". Error: ", GetLastError());
        return false;
    }

    Print("Trade opened on ", symbol, 
          " | Ticket: ", ticket, 
          " | Type: ", (orderType == OP_BUY ? "BUY" : "SELL"), 
          " | Lot: ", lot, 
          " | Price: ", price);
    return true;
}

