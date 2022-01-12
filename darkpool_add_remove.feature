@standalone @aim @lstman
Feature: Darkpool actions
    Traders should be able to add or remove order from and to darkpool(s)

    Background:
        Given I run the EMSX "T_MINIMAL" view

    Scenario: Add then remove 1 order to single darkpool - Liquidnet
        Given I add the following order
            | # | Ticker         | Side | Quantity | Tif | Type |
            | 1 | TSLA US Equity | BUY  | 6000     | DAY | MKT  |
        When I select that order
        And I take the "Add to Dark Pool" action from the actions menu
        Then I should get a dropdown popup
        When I set the value in the dropdown popup to "Liquidnet"
        And I confirm the dropdown popup
        Then the first "order" should have the following column values
            | field              | value     |
            | Dark Pool Exposure | Liquidnet |
        When I select that order
        And I take the "Remove from Dark Pool" action from the actions menu
        Then I should get a dropdown popup
        When I set the value in the dropdown popup to "Liquidnet"
        And I confirm the dropdown popup
        Then the first "order" should have the following column values
            | field              | value |
            | Dark Pool Exposure |       |

    Scenario: Add then remove 1 order to ALL darkpools
        Given I add the following order
            | # | Ticker         | Side | Quantity | Tif | Type |
            | 1 | TSLA US Equity | BUY  | 7000     | DAY | MKT  |
        When I select that order
        And I take the "Add to All Dark Pools" action from the actions menu
        Then I should get a confirmation popup
        When I confirm the confirmation popup
        Then the first "order" should have the following column values
            | field              | value                |
            | Dark Pool Exposure | BlockCross,Liquidnet |
        When I select that order
        And I take the "Remove from All Dark Pools" action from the actions menu
        Then I should get a confirmation popup
        When I confirm the confirmation popup
        Then the first "order" should have the following column values
            | field              | value |
            | Dark Pool Exposure |       |