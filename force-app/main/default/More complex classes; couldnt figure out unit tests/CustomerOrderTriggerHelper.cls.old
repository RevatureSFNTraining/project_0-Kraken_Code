public class CustomerOrderTriggerHelper {
	
    static long today = DateTime.now().getTime();

    //loop through all orders and determine if we should send an auto ship
    public static void checkAutoShip() {
        
        List<Customer_Order__c> orders = [SELECT id FROM Customer_Order__c];
        List<Customer_Order__c> newOrders;
        
        for (Customer_Order__c c : orders) {
            long orderDay = c.Order_Date_Time__c.getTime();
            long days = checkDifferenceInDays(orderDay);
            if (days <= 30) {
                newOrders.add(c);
            }
        }

        if (newOrders.size() > 200 && getListOfShipmentsLessThan15Days() == false) {
            Inventory_Shipment__c newShip = new Inventory_Shipment__c(Depart_Time__c = DateTime.now());
            insert newShip;
        }
    }

    //gets all shipments and returns true/false if any are from last 15 days
    public static Boolean getListOfShipmentsLessThan15Days() {

        List<Inventory_Shipment__c> inv = [SELECT id FROM Inventory_Shipment__c];

        for (Inventory_Shipment__c i : inv) {
            long shipDay = i.Depart_Time__c.getTime();
            long days = checkDifferenceInDays(shipDay);
            if (days <= 15) {
                return true;
            }
        }
        return false;
    }

    //method to check difference in time down to the day, returns number of days difference
    Public static long checkDifferenceInDays (long dayToCheck) {

        long milliseconds = today - dayToCheck;
        long seconds = milliseconds/1000;
        long minutes = seconds/60;
        long hours = minutes/60;
        long days = hours/24;
        return days;
    }
}