@isTest 
private class AssetTriggerHelperTest {

    @isTest static void singleTest() {
        Location__c littleRock = new Location__c(name = 'Little Rock');
        Asset testAsset = new Asset(name ='truck', Location__r = littleRock);
        Database.SaveResult sr = Database.insert(testAsset, false);
        ID assetPassed;

        if (sr.isSuccess()) {
            assetPassed = sr.getId();
        } else {
            for (Database.Error e : sr.getErrors()) {
                system.debug('An error has occured.');
                system.debug(e.getStatusCode());
                system.debug(e.getMessage());
                system.debug(e.getFields());
            }
        }
        
        Asset assetEffected = [SELECT name, Location__r.name FROM Asset WHERE ID = :assetPassed];
        System.assertEquals('truck', assetEffected.name);
        System.assertEquals('Little Rock', assetEffected.Location__r.name);
    }
    //test comment to check if this uploads to org properly
}