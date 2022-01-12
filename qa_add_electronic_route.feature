@trex @standalone
Feature: Add Electronic Route
    Traders should be able to add and route an order to an electronic broker and receive fills.
    # Add and Route an order via Stage & Route and get a part fill
    # Add and Route an order via Stage & Route and get a full fill , multiple fills

    Background:
        Given I run the EMSX "T_MINIMAL_QA2" view

    Scenario Outline: Add electronic route in open and terminal states
        Given I stage and electronically route the following order
            | # | Ticker   | Side              | Broker | Type | Tif   | Quantity | Strategy |
            | 1 | <ticker> | <orderSideTicket> | BB     | MKT  | <tif> | <qty>    | test     |
        Then the first "order" should have the following column values
            | field       | value              |
            | Tkr+YKey    | <ticker>           |
            | Qty         | <qty>              |
            | Side        | <orderSideBlotter> |
            | TIF         | <tif>              |
            | Status      | <orderStatus>      |
            | FillQty     | <fillQty>          |
            | Working Qty | <workingQty>       |
        When I select the first 1 order
        Then The "Routes" blotter should have the following data
            | rowIndex | Tkr+YKey | FillQty   | Side        | Status        | Working Qty  |
            | 1        | <ticker> | <fillQty> | <routeside> | <routeStatus> | <workingQty> |

        Examples:
            | ticker         | routeStatus | orderStatus | qty   | routeside        | fillQty | workingQty | tif | orderSideBlotter | orderSideTicket |
            | NFLX US Equity | Working     | Working     | 1,000 | BUY              | 0       | 1,000      | DAY | BUY              | BUY             |
            | SAM US Equity  | Filled      | Filled      | 2,000 | SELL             | 2,000   | 0          | DAY | SELL             | SELL            |
            | YHOO PE Equity | Rejected    | Assign      | 1,000 | SELL SHORT       | 0       | 0          | DAY | SHRT             | SHRT            |
            | G US Equity    | Part-filled | Working     | 1,000 | UNDISCLOSED SELL | 500     | 500        | DAY | UNDIS            | UNDI            |
            | ECOL US Equity | Cancel      | Part-filled | 600   | BUY              | 180     | 0          | IOC | BUY              | BUY             |
