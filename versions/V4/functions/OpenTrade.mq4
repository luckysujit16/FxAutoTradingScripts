//+------------------------------------------------------------------+
//| Open a Trade                                                     |
//+------------------------------------------------------------------+

bool OpenTrade(string symbol, int orderType, double price, double lot)
{
    int ticket = OrderSend(symbol, orderType, lot, price, 3, 0, 0, "Momentum Trade", 0, 0, clrBlue);
    return (ticket >= 0);
}