@isTest 
private class CustomerOrderTriggerTest {

    @isTest static void singleTest () {

        Location__c loc = new Location__c(name = 'Little Rock Pizza', Address__c = '3434', Location_Phone__c = '4545454');
        Contact c = new Contact(firstName = 'Ethan', lastName = 'Wilson');
        Customer_Order__c custOrder = new Customer_Order__c(Contact__r = c, Location__r = loc, Order_Price__c = 10, Order_Items__c = 'large cheese');
        Database.SaveResult sr = Database.insert(custOrder, false);
         System.debug(sr);      
        
        System.assertEquals(true, sr.isSuccess());
    }
}