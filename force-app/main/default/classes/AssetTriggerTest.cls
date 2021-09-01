@isTest 
private class AssetTriggerTest {
    @isTest static void singleTest() {
        Asset a = new Asset(name='Truck1');
        Database.SaveResult sr = Database.insert(a, false);
        System.assertEquals(true, sr.isSuccess());

        Asset b = new Asset(name='Truck2');
        insert b;
        Database.DeleteResult sr1 = Database.delete(b, false);
        System.assertEquals(true, sr1.isSuccess());
        
        Asset c = new Asset(name='Truck3');
        insert c;
        delete c;
        Database.UndeleteResult sr2 = Database.undelete(c, false);
        System.assertEquals(true, sr2.isSuccess());
    }

    @isTest static void bulkTest() {
        List<Asset> assetList = new List<Asset>();
        for (Integer i = 1; i <= 150; i ++) {
            assetList.add(new Asset(name='asset' + i));
        }
        List<Database.SaveResult> results = Database.insert(assetList, false);
        Integer numPassed = 0;
        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                numPassed += 1;
            }
        }
        System.assertEquals(150, numPassed);
    }
}