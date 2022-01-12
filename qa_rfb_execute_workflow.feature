# Group - RfB
@trex2 @standalone

Feature: RfB:Single Route via Execute

    Scenario: Execute single route for Broker with no strategy
        Given I run the EMSX "T_EMSX_RFB" view
        And I add the following orders
            | # | Ticker        | Side | Quantity | Tif | Type |
            | 1 | IBM US Equity | BUY  | 1000     | DAY | MKT  |
        When I modify the following editable R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | value |
            | 1    | R Qty   | 100   |
            | 1    | R Type  | 100   |
            | 1    | R Dest  | PQAB  |
        Then I verify the values of the following R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | values |
            | 1    | R Qty   | 100    |
            | 1    | R Type  | L 100  |
            | 1    | R Dest  | PQAB   |
        And I select that order
        When I take the "Execute" action
        Then I get a route confirmation pop up on the blotter and I confirm the route
        Then I select that order
        And the first "order" should have the following column values
            | field       | value         |
            | Tkr+YKey    | IBM US Equity |
            | Qty         | 1,000         |
            | Side        | BUY           |
            | Working Qty | 50            |


    Scenario: Execute single route for Broker with stratgey
        Given I run the EMSX "T_EMSX_RFB" view
        And I add the following orders
            | # | Ticker        | Side | Quantity | Tif | Type |
            | 1 | EEM US Equity | BUY  | 1000     | DAY | MKT  |
        When I modify the following editable R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | value |
            | 1    | R Qty   | 100   |
            | 1    | R Type  | 100   |
            | 1    | R Dest  | EFIX  |
        Then I verify the values of the following R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | values |
            | 1    | R Qty   | 100    |
            | 1    | R Type  | L 100  |
            | 1    | R Dest  | EFIX   |
        And I select that order
        When I take the "Execute" action
        Then emsx rfb ticket opens up
        Then I enter "NONE" as strategy on the emsx rfb ticket and click route
        Then I get a route confirmation pop up on the blotter and I confirm the route
        And the ticket gets closed
        And I select that order
        Then the first "order" should have the following column values
            | field       | value         |
            | Tkr+YKey    | EEM US Equity |
            | Qty         | 1,000         |
            | Side        | BUY           |
            | Working Qty | 100           |

    Scenario: Execute button is disabled
        Given I run the EMSX "T_EMSX_RFB" view
        And I add the following orders
            | # | Ticker        | Side | Quantity | Tif | Type |
            | 1 | IBM US Equity | BUY  | 1000     | DAY | MKT  |
        When I modify the following editable R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | value |
            | 1    | R Qty   | 10    |
            | 1    | R Type  | 100   |
        Then I verify the values of the following R-Field widgets in the "Orders" blotter for the given rows
            | rows | colName | values |
            | 1    | R Qty   | 10     |
            | 1    | R Type  | L 100  |
        And I select that order
        Then the "Execute" action button is "disabled"

