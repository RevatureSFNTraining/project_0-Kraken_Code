@isTest
private class TestCrewItemTriggerHandler {    
	@isTest static void TestTakeConcession() { 
        Account testAcct = new Account(Name='East River Route');
	    insert testAcct;
	    Vessel__c testVessel = new Vessel__c(Name='Inferior',Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id);
		insert testVessel;
		Crew_Member__c testCrew = new Crew_Member__c(Name='Oceania Voyage', Vessel__c = testVessel.Id);
		insert testCrew;
		Item__c newItem = new Item__c(Name = 'Candy', Price__c = 6.00, Inventory__c = 150);               
        insert newItem;
        Test.startTest();
		Take_Concession__c crewTakesItem = new Take_Concession__c(Crew_Member__c = testCrew.Id, Items_Taken__c = 'Candy', Item__c = newItem.Id, Amount_Taken__c = 1);
        insert crewTakesItem;
        Test.stopTest();        
    }
    @isTest static void TestTakeMultiple() {
        Account testAcct = new Account(Name='East River Route');
	    insert testAcct;
	    Vessel__c testVessel = new Vessel__c(Name='Inferior',Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id);
		insert testVessel;
		Crew_Member__c testCrew = new Crew_Member__c(Name='Oceania Voyage', Vessel__c = testVessel.Id);
		insert testCrew;
		Item__c newItem = new Item__c(Name = 'Candy', Price__c = 6.00, Inventory__c = 150);               
        insert newItem;
        Test.startTest();
        try {            
            Take_Concession__c crewTakesItem = new Take_Concession__c(Crew_Member__c = testCrew.Id, Items_Taken__c = 'Candy', Item__c = newItem.Id, Amount_Taken__c = 2);
            Database.SaveResult sr = Database.insert(crewTakesItem, false);
        }
        catch(DmlException e) {
            System.debug('The following exception has occured: ' + e.getMessage());
            System.assertEquals('Employees can only take 1 item at a time!', e.getMessage());
        }        
        Test.stopTest();
    }
    @isTest static void TestManyMembersTakeItems() {
        Account testAcct = new Account(Name='East River Route');
	    insert testAcct;
	    Vessel__c testVessel = new Vessel__c(Name='Inferior',Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id);
		insert testVessel;
		Item__c newItem = new Item__c(Name = 'Candy', Price__c = 6.00, Inventory__c = 150);               
        insert newItem;
        List<Crew_Member__c> testCrewList = new List<Crew_Member__c>();
        List<Take_Concession__c> testCrewTakeList = new List <Take_Concession__c>();
        for(Integer i = 0; i < 100; i++) {
            testCrewList.add(new Crew_Member__c(Name = 'Crew Member' + (i + 1), Vessel__c = testVessel.Id));           
        }
        insert testCrewList;
		Test.startTest();
        try {
            for(Integer j = 0; j < testCrewList.size(); j++) {
                testCrewTakeList.add(new Take_Concession__c(Crew_Member__c = testCrewList[j].Id, Items_Taken__c = 'Candy', Item__c = newItem.Id, Amount_Taken__c = 1));                
            	Database.SaveResult sr = Database.insert(testCrewTakeList[j], false);
           	}           
        }
        catch (DmlException e) {
            for(Integer j = 0; j < testCrewList.size(); j++) {
            	System.debug('The following exception has occured: ' + e.getMessage());
            	System.assertEquals('Employees can only take 1 item at a time!', e.getMessage());
            }
        }
        Test.stopTest();
    }
}