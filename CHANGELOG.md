CHANGELOG
======

v1.9.1
---------------
- Fix not being able to save rounding selection for ACP to Milestone conversion.

v1.9.0
---------------
- Add support for Season 9 to Character Log Entry
- Add support for Season 9 to Campaign Log Entry
- Add support for Season 9 to DM Log Entry

- TODO: Update Campaign Log Entry show page for Season 9
- TODO: Update DM Log Entry show page for Season 9
- TODO: Fix Character Print for Season 9
- TODO: Fix DM Print for Season 9
- TODO: Fix Character Export for Season 9

v1.8.4
---------------
- Fix Tier 3 GP reward
- Fix password reset URL.
- Update Content Catalog.
- Allow for 4 decimal places for Renown or Downtime.


v1.8.3
---------------
- Allow tier to be assigned in campaign log entries.
- Allow for fractional downtime and renown.
- Handle negative XP more gravefully.

v1.8.2
---------------
- Adjust notes field height.
- Allow for fractional checkpoints
- Change DM Logs to tierless TCP
- Fix Trade Log items not becoming purchased
- Fix magic items showing up to be traded away that were already traded.

v1.8.1
---------------
- Make it not show traded away items.
- Set up printing to work with season 8 log entries
- Add ability to toggle XP > ACP conversion speed on a per character basis.
- Fix going above level 20 XP threshold causing issues.

v1.8.0
---------------
- Allow for season 8 changes.
- Add ability to toggle pre season 7 / season 8 changes in user details.
- Add ability to toggle XP > ACP conversion rounding on a per character basis.
- Add Purchase Logs to allow for unlocked magic items to be purchased.
- Sort DMs and Locations alphabetically.
- Update dependencies for maximum powah.

v1.7.4
---------------
- Allow markdown for notes field in log entries.

v1.7.3
---------------
- Fix README and seeds
- Add notes search to DM Log Entry search

v1.7.2
---------------
- Add DM Log Entry search functionalities
- Make Location a dropdown in log entry forms
- Optimize database for more vroom-vroom

v1.7.1
---------------
- Update dependencies
- Fix character sheet button showing up when field blank
- Fix printing to properly show campaign log entries
- Allow for fractional gp in trade logs
- Make Characters display in creation order by default
- Add pagination to Campaign show page
- Campaign DMs can view attached character logs
- Allow Campaign join token in url via ?token=blah
- Set DM Log hours and player level to number inputs
- Add Level column to Characters index
- Allow character editing from show page
- Fix magic item totals on character print sheets
- Add DM Reward multplier to DM Log form

v1.7.0
---------------
- Add parsing support for Season 7 adventures
- Fix bug that prevented multiple DMs from joining a campaign

v1.6.2
---------------
- Add parsing support for Admin Only adventures
- Fix bug that prevented public campaigns from being displayed
- Improve export format to be more human readable

v1.6.1
---------------
- Add "Unique" rarity option to magic items
- Add additional columns to DM Log Entries list
- Add source name to magic items

v1.6.0
---------------
- Add parser for Adventurer's League Content Catalog
- Add hours to adventures
- Add contents of Adventurer's League Content Catalog
- Experience moments of existential dread

v1.4.23
---------------
- Fix accidental murder of Users who used Update My Password

v1.4.22
---------------
- Fix DM Log Magic Items to apply to Characters

v1.4.21
---------------
- Add Character selection for Magic Items in Campaign
- Add Magic Items#index and show pages
- Add Magic Item deletion
- Add Magic Item property Not Include in Count
- Allow multiple DM to join Campaigns
- Allow editting of Campaigns
- Add toggle for Autocalc to Change My Details
- Add Character Sheet Url with Karate Button Action!

v1.4.20
---------------
- Fix minor auto-calc issue
- Fix DM Logs not printing when no date
- Fix misleading entry field
- Fix DM Logs print sorting

v1.4.19
---------------
- Improve DM Log printing
- Add DMed hours to DM Log Entries
- Add auto-calculations of rewards to DM Logs
- Add alpha export to CSV feature

v1.4.18
---------------
- Add DM management
- Fix Stats page
- Add DM Log printing
- Add DM aggregate info
- Show XP to Level at smaller screen sizes

v1.4.17
---------------
- Add second half of season 5 modules
- Add convention content modules
- Fix Adventures page
- Add Public Visible Characters checkbox on My Details page.

v1.4.16
---------------

- Move to autocomplete for Log Entry Adventure Name
- Fix DM Log info not showing up in printouts
- Fix sort broken by adding/removing DM Logs and Unassigned
- Fix spacing for buttons on DM Logs page

v1.4.15
---------------

- Fix inability to unassign characters from DM logs.

v1.4.14
---------------

- Improve browser tab look.
- Add GP to Trade Log Entry form.
- Fix show DM Log Entry alignment.
- Make DM Log actions accessible from Character show page.

v1.4.13
---------------

- Avoid collapsing Logs in navbar unless necessary.
- Fix `Character to Apply Rewards` dropdown in DM Logs.
- Add additional information to magic items for random magic items.

v1.4.12
---------------

- Fix all characters selected when updating `Campaign log entry`.
- Fix deleting campaign breaking access to `Campaign` page.
- Fix sorting by characters in `DM Log Entries` index again.
- Improve log entries code quality.

v1.4.11
---------------

- Improve Campaigns#show and campaign log entry look.


v1.4.10
---------------

- Chanddge the way logs are assigned to allow for campaigns.
- Add campaign log entries to `Campagins` feature.

v1.4.9
---------------

- Fix character link bug on Campaigns#show page.
- Add player names to Campaigns#show page.
- Add hover text icon buttons.

v1.4.8
---------------

- Add beta for `Campaigns` feature
- Add opt-in for `Receive emails about site updates`

v1.4.7
---------------

- Fix `_blank` vulnerability


v1.4.6
---------------

- Add `Donate` page


v1.4.5.1
---------------

- Fix `Print Full` page shows `Starting M Items` instead of `Starting # of Magic Items`

v1.4.5
---------------

- Improve website responsiveness.
- Scale `Print Full` to work in landscape mode again.

v1.4.4
---------------

- Fix DM information sometimes not showing while printing.

v1.4.3
---------------

- Make new tab on print view.

- Fix `Hide Assigned` DM Log Entries page button enabled by default.

- Fix button positioning on DM Log Entries page.

- Fix unable to assign `Date Assigned` in DM Log Entries form.

v1.4.2
---------------

- Fix can't sort by character on DM Log Entries page.

- Add `Hide Assigned` button to DM Log Entries page.

v1.4.1
---------------

- Fix critical bug: Can't set `Date DMed` on DM Log Entry form page.
