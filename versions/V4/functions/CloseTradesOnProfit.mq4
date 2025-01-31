//+------------------------------------------------------------------+
//| Close Trades on Profit                                           |
//+------------------------------------------------------------------+

void CloseTradesOnProfit()
{
    Print("=== Checking Trades for Closure Based on Profit ===");

    for (int i = 0; i < OrdersTotal(); i++)
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            string symbol = OrderSymbol();
            double profit = OrderProfit();
            double lotSize = OrderLots();
            double closePrice = (OrderType() == OP_BUY) ? Bid : Ask;
            int ticket = OrderTicket();
            string tradeType = (OrderType() == OP_BUY) ? "BUY" : "SELL";

            Print("Checking trade: Symbol: ", symbol, ", Ticket: ", ticket, 
                  ", Type: ", tradeType, ", Profit: ", profit, 
                  ", Lot Size: ", lotSize, ", Close Price: ", closePrice);

            // Check if the trade profit exceeds the threshold
            if (profit > 1.0)
            {
                Print("Trade with profit above $1 detected: Symbol: ", symbol, 
                      ", Ticket: ", ticket, ", Profit: ", profit);

                // Normalize close price to required precision
                closePrice = NormalizeDouble(closePrice, MarketInfo(symbol, MODE_DIGITS));

                // Attempt to close the trade
                if (!OrderClose(ticket, lotSize, closePrice, 3, clrRed))
                {
                    int errorCode = GetLastError();
                    Print("Failed to close trade: Symbol: ", symbol, 
                          ", Ticket: ", ticket, ", Profit: ", profit, ", Error: ", errorCode);

                    // Handle specific errors
                    switch (errorCode)
                    {
                        case ERR_INVALID_PRICE:
                            Print("Invalid price for closing trade: Symbol: ", symbol, 
                                  ", Ticket: ", ticket, ", Close Price: ", closePrice);
                            break;
                        case ERR_NO_CONNECTION:
                            Print("No connection to server. Unable to close trade: Symbol: ", symbol);
                            break;
                        case ERR_SERVER_BUSY:
                            Print("Server busy. Retrying later: Symbol: ", symbol);
                            break;
                        default:
                            Print("Unhandled error (", errorCode, ") while closing trade: Symbol: ", symbol);
                            break;
                    }
                }
                else
                {
                    Print("Trade closed successfully: Symbol: ", symbol, 
                          ", Ticket: ", ticket, ", Profit: ", profit);
                }
            }
            else
            {
                Print("Trade profit below threshold: Symbol: ", symbol, 
                      ", Ticket: ", ticket, ", Type: ", tradeType, ", Profit: ", profit);
            }
        }
    }

    Print("=== End of Trade Closure Check ===");
}
