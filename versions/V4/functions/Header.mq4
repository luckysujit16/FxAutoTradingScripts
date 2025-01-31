// ###################################################################### //
//+------------------------------------------------------------------+
//|                                         DemoBotMultiCurrency.mq4 |
//|                                                   Sujit S Jadhav |
//|                                       https://www.sujitjadhav.me |
//+------------------------------------------------------------------+

#property copyright "Sujit S Jadhav"
#property link      "https://www.sujitjadhav.me"
#property version   "1.02"

//+------------------------------------------------------------------+
//| External Inputs                                                  |
//+------------------------------------------------------------------+
extern double LotSize = 0.01;             // Lot size
extern double TriggerFactor = 100;        // Momentum trigger level
extern int Timeframe = 15;                // Timeframe for momentum calculation
extern double CounterPoints = 50;         // Fixed points difference for counter trade
extern int CoolingPeriod = 10;            // Cooling period in seconds for trades
extern string Symbol1 = "BTCUSD";         // First symbol
extern string Symbol2 = "XAUUSD";         // Second symbol
extern string Symbol3 = "USDJPY";         // Third symbol
extern string Symbol4 = "XAGUSD";         // Third symbol

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
datetime lastPrimaryTradeTimes[];         // Last primary trade execution time
datetime lastCounterTradeTimes[];         // Last counter trade execution time
datetime lastTradeTimes[];
string Symbols[];                         // Symbols to trade on
#define MAX_TRADES 13                     // Define the maximum number of trades (hardcoded)