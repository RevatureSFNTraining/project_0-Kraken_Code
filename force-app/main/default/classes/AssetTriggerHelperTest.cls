@isTest private class AssetTriggerHelperTest {

    @TestSetup static void makeData(){
        Location__c location = new Location__c(Name = 'Location1', Address__c = '233 gfsg', Location_Phone__c = '18703709856');
        insert location;
    }

    @isTest static void bulkTest() {

        Location__c location = [SELECT id FROM Location__c WHERE Name = 'Location1'];
        List<Asset> a = new List<Asset>();
        for (Integer i = 0; i < 3; i++) {
            a.add(new Asset(Name = 'asset' + i, Location__c = location.id));
        }
        
        List<Database.SaveResult> srList = Database.insert(a, false);
        Integer numPassed = 0;
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                numPassed += 1;
            }
        }
        System.assertEquals(3, numPassed);
    }

    @isTest static void singlePositiveTest() {

        Location__c location = [SELECT id FROM Location__c WHERE Name = 'Location1'];
        Asset a = new Asset(Name = 'asset', Location__c = location.id);
        
        Database.SaveResult sr = Database.insert(a, false);
        System.assertEquals(true, sr.isSuccess());
    }

    @isTest static void singleNegativeTest() {

        Asset a = new Asset(Name = 'asset');
        
        Database.SaveResult sr = Database.insert(a, false);
        System.assertEquals(false, sr.isSuccess());
    }

    @isTest static void singlePositiveDeleteTest() {

        Location__c location = [SELECT id FROM Location__c WHERE Name = 'Location1'];
        Asset a = new Asset(Name = 'asset', Location__c = location.id);
        insert a;
        Database.DeleteResult sr = Database.delete(a, false);
        System.assertEquals(true , sr.isSuccess());
    }

    @isTest static void singlePositiveUndeleteTest() {

        Location__c location = [SELECT id FROM Location__c WHERE Name = 'Location1'];
        Asset a = new Asset(Name = 'asset', Location__c = location.id);
        insert a;
        delete a;
        Database.UndeleteResult sr = Database.undelete(a, false);
        System.assertEquals(true , sr.isSuccess());
    }
}