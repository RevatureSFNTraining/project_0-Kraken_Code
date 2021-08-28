public class CustomerOrderTriggerHelper {
	
    public static void checkAutoShip() {
        long todaysDay = DateTime.now().getTime();
        List<Customer_Order__c> orders = [SELECT id FROM Customer_Order__c];
        List<Customer_Order__c> newOrders;
        
        for (Customer_Order__c c : orders) {
            long orderDay = c.Order_Date_Time__c.getTime();
            long milliseconds = todaysDay - orderDay;
            long seconds = milliseconds/1000;
            long minutes = seconds/60;
            long hours = minutes/60;
            long days = hours/24;
            if (days <= 30) {
                newOrders.add(c);
            }
        }
        
        //need some validation here to make sure a shipment doesn't go out after every cust order over 200
        //implement a check on inv shipments for past 30 days; make sure there hasn't been any for at least 2 weeks
        if (newOrders.size() > 200) {
            Inventory_Shipment__c newShip = new Inventory_Shipment__c();
            insert newShip;
        }
    }
}