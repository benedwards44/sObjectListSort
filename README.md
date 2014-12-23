sObjectListSort
===============

This helper class provides a way to custom sort of a list of sObject records by specifying a the field name and the sort direction. Useful in circumstances where you can't create the order you want using a SOQL query.

## Example

```
// List of sObject records. Example using Opportunities
List<Opportunity> opps = [Select Id, Name, CloseDate, StageName, Amount From Opportunity];

List<SObjectSort> recordsForSorting = new List<SObjectSort>();
for (Opportunity opp :opps)
{
  // Add opportunities to wrapper class. Set "Name" and "asc" as field and sort order
  recordsForSorting.add(new SObjectSort(opp, 'Name', 'asc'));
}

// Sort the list based on details from above
recordsForSorting.sort();

opps = new List<Opportunity>();
for (SObjectSort obj :recordsForSorting)
{
  opps.add((Opportunity)obj.record);
}

// List is now sorted by name ascending
system.debug('### SORTED LIST: ' + opps);
```
You can change the sort method by changing the field and order (supports strings, dates, numbers, currencies).
```
recordsForSorting = new List<SObjectSort>();
for (Opportunity opp :opps)
{
  // Add opportunities to wrapper class. Set "Name" and "asc" as field and sort order
  recordsForSorting.add(new SObjectSort(opp, 'Amount', 'desc'));
}

// Sort the list based on details from above
recordsForSorting.sort();

opps = new List<Opportunity>();
for (SObjectSort obj :recordsForSorting)
{
  opps.add((Opportunity)obj.record);
}

// List is now sorted by name ascending
system.debug('### SORTED LIST: ' + opps);
