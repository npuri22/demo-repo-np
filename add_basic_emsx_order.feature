# Group - Add Order and Routes
@standalone @aim @lstman @trex @smoke
Feature: Add a basic EMSX order
    Smoke test to make sure you can run EMSX and add an order with the ticket

    Scenario: Add first order
        Given I run the EMSX "T_MINIMAL" view
        And I add the following order
            | # | Ticker        | Side | Quantity | Tif | Type |
            | 1 | IBM US Equity | BUY  | 101      | DAY | MKT  |
        Then the first "order" should have the following column values
            | field    | value         |
            | Tkr+YKey | IBM US Equity |
            | Qty      | 101           |
            | Side     | BUY           |
            | TIF      | DAY           |
        And I select the first 1 order