public class MenuAddTriggerHandler {
    public static List<Item__c> checkForDuplicates(List<Item__c> newItems) {
        Set<String> itemSet = new Set<String>();
        for(Item__c newItem : newItems) {
            if(newItem.Name != null) {
                itemSet.add(newItem.Name);
            }
        }
        Map<String, Item__c> existingItemList = new Map<String, Item__c>();
        for(Item__c existingItem : [SELECT Name, Price__c FROM Item__c WHERE Name IN :itemSet]) {
            existingItemList.put(existingItem.Name, existingItem);
        }
        
        for(Item__c newItem: newItems) {
            Item__c duplicateItem = existingItemList.get(newItem.Name);
            if(duplicateItem != null) {
                newItem.addError('ERROR: There is an item with this name already on the menu: ' + duplicateItem.Name);
            }
        }
        return newItems;
    }    
}