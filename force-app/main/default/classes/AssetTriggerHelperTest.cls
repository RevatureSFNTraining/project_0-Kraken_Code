@isTest 
private class AssetTriggerHelperTest {

    @TestSetup
    static void makeData(){
        Location__c location = new Location__c(Name = 'Location1', Address__c = '233', Location_Phone__c = '4343433');
        insert location;
    }

    @isTest static void bulkTest() {

        Location__c location = [Select id FROM Location__c WHERE Name = 'Location1'];
        List<Asset> a = new List<Asset>();
        for (Integer i = 0; i < 10; i++) {
            a.add(new Asset(Name = 'asset' + i, Location__r = location));
        }
        Messaging.SingleEmailMessage[] m = AssetTriggerHelper.onAssetChange(a);
        
        for(Integer j = 0; j < 10; j++) {
            System.assertEquals('There was an asset change. A asset' + i +  
            ' record was changed at location: Location1', m[j].message.plainTextBody);
        }
    }
}