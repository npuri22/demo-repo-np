@standalone @aim @lstman @trex
Feature: Cancel Order
    Traders should be able to cancel an order through the "Cancel Order" action.

    Background:
        Given I run the EMSX "T_MINIMAL" view
        And I add the following order
            | # | Ticker        | Side | Quantity | Tif | Type |
            | 1 | EEM US Equity | BUY  | 100      | DAY | MKT  |

    Scenario: Basic Cancel Order Ok
        When I select that order
        And I take the "Cancel Order" action
        Then I should get a confirmation popup
        When I confirm the confirmation popup
        Then the first "order" should have the following column values
            | field  | value  |
            | Qty    | 0      |
            | Status | Cancel |

    Scenario: Also cancels all the order's routes
        When I select that order
        And I add a route with
            | field        | value              |
            | Quantity     | 100                |
            | Tif          | DAY                |
            | Type         | MKT                |
            | Broker       | BB                 |
            | Strategy     | test               |
            | Instructions | s:new wait 600 cxl |

        And I take the "Cancel Order" action
        Then I should get a confirmation popup
        When I confirm the confirmation popup
        Then the first "order" should have the following column values
            | field  | value  |
            | Qty    | 0      |
            | Status | Cancel |
        And the first "route" should have the following column values
            | field  | value  |
            | Status | Cancel |
