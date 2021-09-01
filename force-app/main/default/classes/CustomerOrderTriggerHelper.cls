public class CustomerOrderTriggerHelper {
    
    public static void discount() {

        Customer_Order__c newOrder = [SELECT id, Order_Price__c FROM Customer_Order__c ORDER BY createddate DESC limit 1];
        if (newOrder.Order_Price__c >= 30) {
            newOrder.Order_Price__c -= 5;
            update newOrder;
        }
    }
}