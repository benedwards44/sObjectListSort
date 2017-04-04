global class SObjectListSort
{

	// Method to take an unsorted list and sort as specified
	global static List<sObject> sortRecords(List<sObject> recordsToSort, String sortField, String sortOrder)
	{
		// Create a new list of wrapped objects
		List<RecordWrapper> sortedRecords = new List<RecordWrapper>();
		for (sObject record :recordsToSort)
		{	
			// Add records to wrapper list
 			sortedRecords.add(new RecordWrapper(record, sortField, sortOrder));
		}

		// Sort the list. This uses the compareTo method within the wrapper class
		sortedRecords.sort();

		// Add sorted list back to sObject list
		recordsToSort = new List<sObject>();
		for (RecordWrapper record :sortedRecords)
		{
			recordsToSort.add(record.record);
		}

		return recordsToSort;
	}

	// Get the field type for the sort field
	global static String fieldType;
	global static String getFieldType(sObject record, String sortField)
	{
		if (fieldType == null)
		{
			fieldType = string.valueOf(record.getSObjectType().getDescribe().fields.getMap().get(sortField).getDescribe().getType());
		}
		return fieldType;
	}

	// Wrapper class for the record
	global class RecordWrapper implements Comparable
	{

		public sObject 		record;
		public String   	sortField;
		public String 		sortDirection;
		public String 		sortValueString;
		public Decimal 		sortValueDecimal;
		public Date 		sortValueDate;
		public DateTime 	sortValueDateTime;

		// Constructor
		global RecordWrapper(sObject r, String sField, String sDirection)
		{
			record 			= r;
			sortField 		= sField;
			sortDirection 	= sDirection;

			// Determine the type of field
			String recordFieldType = getFieldType(record, sortField);
			
			if (recordFieldType == 'CURRENCY' || recordFieldType == 'DOUBLE' || recordFieldType == 'INTEGER' || recordFieldType == 'PERCENT')
			{
				sortValueDecimal = (Decimal)record.get(sortField);
			}
			else if (recordFieldType == 'DATE')
			{
				sortValueDate = Date.valueOf(record.get(sortField));
			}
			else if (recordFieldType == 'DATETIME')
			{
				sortValueDateTime = DateTime.valueOf(record.get(sortField));
			}
			else // Everything else try to cast as string
			{ 
				sortValueString = String.valueOf(record.get(sortField));
			}
			
		}

		// Custom compare method. Sorts records based on the direction.
		global Integer compareTo(Object compareTo)
		{
			RecordWrapper compareToObject = (RecordWrapper)compareTo;

			if (sortDirection == 'asc')
			{
				if (
						(sortValueString != null && sortValueString > compareToObject.sortValueString) ||
						(sortValueDecimal != null && sortValueDecimal > compareToObject.sortValueDecimal) ||
						(sortValueDate != null && sortValueDate > compareToObject.sortValueDate) ||
						(sortValueDateTime != null && sortValueDateTime > compareToObject.sortValueDateTime)
					)
				{
					return 1;
				}
				else if (
							(sortValueString != null && sortValueString < compareToObject.sortValueString) || 
							(sortValueDecimal != null && sortValueDecimal < compareToObject.sortValueDecimal) || 
							(sortValueDate != null && sortValueDate < compareToObject.sortValueDate) ||
							(sortValueDateTime != null && sortValueDateTime < compareToObject.sortValueDateTime) 
						)
				{
					return -1;
				}
				else
				{
					return 0;
				}
			}
			else
			{
				if (
						(sortValueString != null && sortValueString > compareToObject.sortValueString) ||
						(sortValueDecimal != null && sortValueDecimal > compareToObject.sortValueDecimal) ||
						(sortValueDate != null && sortValueDate > compareToObject.sortValueDate) ||
						(sortValueDateTime != null && sortValueDateTime > compareToObject.sortValueDateTime)
					)
				{
					return -1;
				}
				else if (
							(sortValueString != null && sortValueString < compareToObject.sortValueString) || 
							(sortValueDecimal != null && sortValueDecimal < compareToObject.sortValueDecimal) || 
							(sortValueDate != null && sortValueDate < compareToObject.sortValueDate) ||
							(sortValueDateTime != null && sortValueDateTime < compareToObject.sortValueDateTime) 
						)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
		}

	}
}
