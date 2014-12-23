sObjectListSort
===============

This utility class provides a way to custom sort of a list of sObject records by specifying the field name and the sort direction. Useful in circumstances where you can't create the order you want using a SOQL query or don't want to re-query records each time a sort is required.

## Usage

```
// Sort a list of Opportunities by Amount descending
List<Opportunity> opps = [Select Id, Name, StageName, Amount, CloseDate From Opportunity];
opps = SObjectListSort.sortRecords(opps, 'Amount', 'desc');

// Sort by Name
opps = SObjectListSort.sortRecords(opps, 'Name', 'asc');

// Sort by close date
opps = SObjectListSort.sortRecords(opps, 'CloseDate', 'asc');
```

There are other code examples in the test class.
