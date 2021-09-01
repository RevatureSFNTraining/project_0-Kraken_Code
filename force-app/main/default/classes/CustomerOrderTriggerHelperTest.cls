@isTest public class CustomerOrderTriggerHelperTest {

    @isTest static void singleTest() {
        Contact c = new Contact(firstName = 'Ethan', lastName='Wilson');
        Location__c loc = new Location__c(Address__c = '4343', Location_Phone__c = '4564565');
        insert c;
        insert loc;
        Customer_Order__c co = new Customer_Order__c(Order_Price__c = 30.00, Location__c = loc.id, Contact__c = c.id, Order_Date_Time__c = DateTime.now(), Order_Items__c = 'large cheese');
        insert co;
        
        Customer_Order__c newOrder = [SELECT id, Order_Price__c FROM Customer_Order__c ORDER BY createddate DESC limit 1];
        
        System.assertEquals(25.00, newOrder.Order_Price__c);
    }
   
    
    @isTest static void bulkTest() {
        
        Contact c = new Contact(firstName = 'Ethan', lastName='Wilson');
        Location__c loc = new Location__c(Address__c = '4343', Location_Phone__c = '4564565');
        insert c;
        insert loc; 
        List<Customer_Order__c> coList = new List<Customer_Order__c>();
        for (Integer i = 0; i < 150; i++) {
           coList.add(new Customer_Order__c(Order_Price__c = i, Location__c = loc.id, Contact__c = c.id, Order_Date_Time__c = DateTime.now(), Order_Items__c = 'large cheese')); 
        }
        insert coList;
        
        List<Customer_Order__c> newOrdersList = [SELECT id, Order_Price__c FROM Customer_Order__c];
        Integer numDiscount = 0;
        for (Customer_Order__c custOrder : newOrdersList) {
            if (custOrder.Order_Price__c >= 25) {
                numdiscount += 1;
            } 
        }
        System.assertEquals(125, numDiscount);
    }
}