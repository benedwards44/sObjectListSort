@isTest
private class SObjectListSortTest {
	
	static testMethod void testSObjectSortByNameAsc()
	{
		List<Opportunity> testOpps = createOpps();

		testOpps = SObjectListSort.sortRecords(testOpps, 'Name', 'asc');

		system.assertEquals(
			'Test Opp #1',
			testOpps[0].Name,
			'First opportunity in list should be Test Opp #9'
		);

		system.assertEquals(
			testOpps[49].Name,
			'Test Opp #9',
			'Last opportunity in list should be the last name alphabetically'
		);
	}

	static testMethod void testSObjectSortByCloseDateAsc()
	{
		List<Opportunity> testOpps = createOpps();

		testOpps = SObjectListSort.sortRecords(testOpps, 'CloseDate', 'asc');

		system.assertEquals(
			testOpps[0].CloseDate,
			system.today().addDays(1),
			'First opportunity in list should have the close date of today plus one'
		);

		system.assertEquals(
			testOpps[49].CloseDate,
			system.today().addDays(50),
			'Last opportunity in list should have the close date of today plus 50'
		);
	}

	static testMethod void testSObjectSortByCreatedDateDesc()
	{
		List<Opportunity> testOpps = createOpps();

		testOpps = SObjectListSort.sortRecords(testOpps, 'CreatedDate', 'desc');
		
	}

	static testMethod void testSObjectSortByAmountDesc()
	{
		List<Opportunity> testOpps = createOpps();

		testOpps = SObjectListSort.sortRecords(testOpps, 'Amount', 'desc');

		system.assertEquals(
			10 * 50,
			testOpps[0].Amount,
			'First opportunity in list should the highest amount. 10 * 50'
		);

		system.assertEquals(
			10 * 1,
			testOpps[49].Amount,
			'Last opportunity in list should the lowest amount. 10 * 1'
		);

	}

	private static List<Opportunity> createOpps()
	{
		// Create Data
		List<Opportunity> oppsForInsert = new List<Opportunity>();
		for (Integer i = 1; i <= 50; i++)
		{
			oppsForInsert.add(
				new Opportunity(
					Name 		= 'Test Opp #' + i,
					StageName	= 'Prospecting',
					Amount 		= 10 * i,
					CloseDate 	= system.today().addDays(i)
				)
			);
		}
		insert oppsForInsert;
		return oppsForInsert;
	}

}