@standalone @aim @lstman
Feature: Reassign Orders
    Traders should be able to reassign orders through the "Reassign Orders" action.

    Background:
        Given I run the EMSX "T_EMSX" view
        And I add the following order
            | # | Ticker        | Side | Quantity | Tif | Type | LimitPrice |
            | 1 | EEM US Equity | BUY  | 1000     | DAY | LMT  | 99.99      |

    Scenario: Reassign Order to CSTS0
        When I select that order
        And I take the " Reassign Order(s)" action from the actions menu
        And I select "CSTS0" dropdown option from reassign orders popup
        Then the first "order" should have the following column values
            | field   | value    |
            | Status  | New      |
            | Traders | 27718145 |
