//+------------------------------------------------------------------+
//|                                         DemoBotMultiCurrency.mq4 |
//|                                                   Sujit S Jadhav |
//|                                       https://www.sujitjadhav.me |
//+------------------------------------------------------------------+

#property copyright "Sujit S Jadhav"
#property link      "https://www.sujitjadhav.me"
#property version   "1.06"

//+------------------------------------------------------------------+
//| External Inputs                                                 |
//+------------------------------------------------------------------+
extern int MaxTrades = 3;                  // Global maximum trades across all symbols
extern int PerSymbolMaxTrades = 1;         // Maximum trades per symbol
extern double LotSize = 0.01;              // Lot size
extern double TakeProfit = 50;             // Take profit in points
extern double TrailingStop = 20;           // Trailing stop in points
extern double TriggerFactor = 100;         // Momentum trigger level
extern int Timeframe = 15;                 // Timeframe for momentum calculation
extern int UpdateInterval = 60;            // Trailing stop update interval in seconds
extern int CoolingPeriod = 5;              // Cooling period in seconds between trades
extern string Symbol1 = "BTCUSD";          // First symbol
extern string Symbol2 = "XAUUSD";          // Second symbol
extern string Symbol3 = "USDJPY";          // Third symbol

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
datetime lastTradeTimes[];                     // Last trade execution time
datetime lastUpdateTime;                    // Last trailing stop update time
string Symbols[];                           // Symbols to trade on


// ###################################################################### //

//+------------------------------------------------------------------+
//|                                         DemoBotMultiCurrency.mq4 |
//|                                                   Sujit S Jadhav |
//|                                       https://www.sujitjadhav.me |
//+------------------------------------------------------------------+

#property copyright "Sujit S Jadhav"
#property link      "https://www.sujitjadhav.me"
#property version   "1.07"


//+------------------------------------------------------------------+
//| External Inputs                                                  |
//+------------------------------------------------------------------+
extern double LotSize = 0.01;             // Lot size
extern double TriggerFactor = 100;        // Momentum trigger level
extern int Timeframe = 15;                // Timeframe for momentum calculation
extern double CounterPoints = 50;         // Fixed points difference for counter trade
extern string Symbol1 = "BTCUSD";         // First symbol
extern string Symbol2 = "XAUUSD";         // Second symbol
extern string Symbol3 = "USDJPY";         // Third symbol