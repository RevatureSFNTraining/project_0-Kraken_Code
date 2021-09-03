@isTest
private class TestCapacityReachTrigger {
	@isTest static void TestEditingVesselBelowCapacity() {
        
        Account testAcct = new Account(Name='East River Route');
        insert testAcct;
        Vessel__c thisVessel = new Vessel__c(Name='Inferior',Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id);
        insert thisVessel;
        Test.startTest();
        thisVessel.Passengers_Onboard__c = 300;
        update thisVessel;
        Test.stopTest();        
    }
    @isTest static void TestEditingVesselAboveCapacity() {
        Account testAcct = new Account(Name='East River Route');
        insert testAcct;
        Vessel__c thisVessel2 = new Vessel__c(Name='Inferior',Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id);
        insert thisVessel2;
        Test.startTest();
        try {            
            thisVessel2.Passengers_Onboard__c = 800;
            Database.SaveResult sr = Database.update(thisVessel2, false);
        }
        catch(DmlException e) {
            System.debug('The following exception has occured: ' + e.getMessage());
            System.assertEquals('The vessel is over capacity. At least ' + (thisVessel2.Passengers_Onboard__c - thisVessel2.Capacity__c) + 
                                  ' passengers must disembark the vessel.', e.getMessage());
        }        
        Test.stopTest();
    }
    @isTest static void TestEditingManyVessels() {
        Account testAcct = new Account(Name='East River Route');
        insert testAcct;
        List<Vessel__c> testVessels = new List<Vessel__c>();
        for(Integer i = 0; i < 100; i++) {
            testVessels.add(new Vessel__c(Name= 'Vessel' + i, Capacity__c=359,Passengers_Onboard__c=0,Location__c='Pier 82',Account__c=testAcct.Id));
        }
        insert testVessels;
		Test.startTest();
        try {
            for(Integer j = 0; j < testVessels.size(); j++) {
                testVessels[j].Passengers_Onboard__c = 100 + j;
                Database.SaveResult sr = Database.update(testVessels[j], false);
            }            
        }
        catch (DmlException e) {
            for(Integer j = 0; j < testVessels.size(); j++) {
            	System.debug('The following exception has occured: ' + e.getMessage());
            	System.assertEquals('The vessel is over capacity. At least ' + (testVessels[j].Passengers_Onboard__c - testVessels[j].Capacity__c) + 
            	                      ' passengers must disembark the vessel.', e.getMessage());
            }
        }
        Test.stopTest();
    }
}