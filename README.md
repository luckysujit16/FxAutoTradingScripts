# FxAutoTradingScripts
This is custom Auto Trading MQ5 Script developed & Tested by Sujit S Jadhav using 15 years of Technical Analysis and Trading Experience.


# MomentumTradeWithTrailingTP

## Overview
MomentumTradeWithTrailingTP is an automated trading system designed to identify and execute trades based on momentum indicators, manage trailing stop-loss and take-profit levels, and ensure robust trading strategies. This README outlines the version history, updates, and changes made to the system.

---

## Version History

### Version 1.0 (V1)
#### Features:
- **Indicator Initialization**: Added support for initializing the Momentum indicator.
- **Trade Execution**: Implemented buy and sell signal logic based on candle momentum and trigger factor.
- **Trailing Stop-Loss**: Virtual trailing stop-loss and take-profit management added.
- **Trading Hours**: Configured trading hours with start and end time inputs.
- **Global Profit Target**: Introduced global profit target logic to stop trading upon reaching predefined profit levels.
- **Logging and Debugging**: Added detailed logging for debugging trade logic and decision-making.

#### Files Included:
- MomentumTradeWithTrailingTP.mq4

### Version 2.0 (V2)
#### Planned Features:
- **Risk Management**: Add features to dynamically calculate lot size based on account balance and risk percentage.
- **Multi-Symbol Trading**: Extend EA functionality to trade multiple symbols simultaneously.
- **Error Handling Improvements**: Refine error handling and logging for smoother operation.
- **Advanced Trailing Stop**: Introduce more dynamic trailing stop mechanisms based on ATR or market volatility.
- **Performance Optimization**: Optimize indicator calculations to improve execution speed.

---

## Usage Instructions
1. Place the `MomentumTradeWithTrailingTP.mq4` file into the `Experts` folder of your MetaTrader 4 installation directory.
2. Refresh or restart MetaTrader 4 to load the Expert Advisor.
3. Attach the EA to the desired chart and configure the input parameters as needed.
4. Ensure trading hours and global profit targets are configured properly before live trading.

---

## Future Updates
We plan to enhance the functionality and efficiency of MomentumTradeWithTrailingTP by incorporating user feedback and industry best practices.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## Contact
For support or inquiries, contact:
- **Author**: Sujit Jadhav
- **Website**: [sujitjadhav.me](https://www.sujitjadhav.me)

