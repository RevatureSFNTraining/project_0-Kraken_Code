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
        try {
             Database.SaveResult sr = Database.insert(newItem2, false);
        }
        catch(DmlException e) {
            System.debug('The following exception has occured: ' + e.getMessage());
            System.assertEquals('ERROR: There is an item with this name already on the menu: ' + newItem2.Name, e.getMessage());
        }        
        Test.stopTest();
    }
    @isTest static void TestAddingBulkItems() {
        List<Item__c> testItems = new List<Item__c>();
        for(Integer i = 0; i < 200; i++) {
            testItems.add(new Item__c(Name= 'TestItem' + i, Price__c = 3.00, Inventory__c = 100));
        }
        insert testItems;        
    }
}