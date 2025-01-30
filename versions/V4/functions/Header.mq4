// ###################################################################### //

//+------------------------------------------------------------------+
//|                                         DemoBotMultiCurrency.mq4 |
//|                                                   Sujit S Jadhav |
//|                                       https://www.sujitjadhav.me |
//+------------------------------------------------------------------+

#property copyright "Sujit S Jadhav"
#property link      "https://www.sujitjadhav.me"
#property version   "V4-1.01"


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

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
datetime lastTradeTimes[];                     // Last trade execution time
datetime lastUpdateTime;                    // Last trailing stop update time
string Symbols[];                           // Symbols to trade on