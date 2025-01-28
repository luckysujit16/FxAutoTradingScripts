//+------------------------------------------------------------------+
//| Close Trades on Profit                                           |
//+------------------------------------------------------------------+

void CloseTradesOnProfit()
{
    Print("=== Checking Trades for Closure Based on Profit ===");

    // Iterate through all open trades
    for (int i = OrdersTotal() - 1; i >= 0; i--) // Loop in reverse to avoid indexing issues when closing trades
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            double profit = OrderProfit();
            double lotSize = OrderLots();
            double closePrice = (OrderType() == OP_BUY) ? Bid : Ask;
            string symbol = OrderSymbol();
            int ticket = OrderTicket();
            string tradeType = (OrderType() == OP_BUY) ? "BUY" : "SELL";

            if (profit > 1)
            {
                Print("Trade with profit above $1 detected: Symbol: ", symbol, 
                      ", Ticket: ", ticket, ", Type: ", tradeType, ", Profit: ", profit);

                // Attempt to close the trade
                if (OrderClose(ticket, lotSize, closePrice, 3, clrRed))
                {
                    Print("Trade closed successfully: Symbol: ", symbol, 
                          ", Ticket: ", ticket, ", Type: ", tradeType, ", Profit: ", profit);
                }
                else
                {
                    int errorCode = GetLastError();
                    Print("Failed to close trade: Symbol: ", symbol, 
                          ", Ticket: ", ticket, ", Error: ", errorCode);

                    // Specific error handling
                    if (errorCode == ERR_INVALID_PRICE)
                        Print("Invalid price for closing trade. Current Price: ", closePrice, ", Symbol: ", symbol);
                    else if (errorCode == ERR_NO_CONNECTION)
                        Print("No connection to server. Unable to close trade. Symbol: ", symbol);
                    else if (errorCode == ERR_SERVER_BUSY)
                        Print("Server busy, retrying later. Symbol: ", symbol);
                    else
                        Print("Unhandled error (", errorCode, ") for trade. Symbol: ", symbol, ", Ticket: ", ticket);
                }
            }
        }
        else
        {
            Print("Failed to select trade at position ", i, ". Error: ", GetLastError());
        }
    }

    Print("=== End of Trade Closure Check ===");
}