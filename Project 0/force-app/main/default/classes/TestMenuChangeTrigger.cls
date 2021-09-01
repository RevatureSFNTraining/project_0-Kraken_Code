@isTest
private class TestMenuChangeTrigger {
    @isTest static void TestAddingItemToMenu() {
        Item__c newItem = new Item__c(Name = 'Candy', Price__c = 6.00, Inventory__c = 150);
        Test.startTest();
        insert newItem;
        Test.stopTest();        
    }
    @isTest static void TestAddingDuplicateItemToMenu() {
        Item__c newItem2 = new Item__c(Name = 'Hot Dog', Price__c = 4.00, Inventory__c = 200);
        Test.startTest();
        Database.SaveResult sr = Database.insert(newItem2, false);
        Integer numFailed = 0;
        if(!sr.isSuccess()) {
            numFailed = 1;
        }
        System.assertEquals(1, numFailed);
        Test.stopTest();
    }
    @isTest static void TestAddingBulkItems() {
        List<Item__c> testItems = new List<Item__c>();
        List<Item__c> dupeItems = new List<Item__c>();
        for(Integer i = 0; i < 200; i++) {
            testItems.add(new Item__c(Name= 'TestItem' + i, Price__c = 3.00, Inventory__c = 100));
        }
        for(Integer j = 0; j < 200; j++) {
            dupeItems.add(new Item__c(Name= 'DupeItem', Price__c = 3.00, Inventory__c = 100));
        }
        insert testItems;
        List<Database.SaveResult> results = Database.insert(dupeItems, false);
        Integer numFailed = 0;
        for(Database.SaveResult sr : results) {
            if(!sr.isSuccess()){
                numFailed += 1;
            }
        }
        System.assertEquals(199, numFailed, 'Something went wrong.');
    }
}