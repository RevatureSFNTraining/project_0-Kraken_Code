@isTest public class CustomerOrderTriggerHelperTest {

    @isTest static void bulkTest() {

        Location__c loc = new Location__c(name = 'Little Rock Pizza', Address__c = '123', Location_Phone__c = '1234567891');
        Contact c = new Contact(firstName = 'Ethan', lastName = 'Wilson');
        insert loc;
        insert c;
        List<Customer_Order__c> coList = new List<Customer_Order__c>();

        for (Integer i = 0; i < 300; i++) {
            coList.add(new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now()));
        }
        
        Insert coList;
        Inventory_Shipment__c is = [SELECT id, Depart_Time__c FROM Inventory_Shipment__c ORDER BY id DESC LIMIT 1];
        System.assertEquals(Datetime.now().Date(), is.Depart_Time__c);

        //check if shipments less than 15 days
        Customer_Order__c failure = new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now());
        insert failure;
        System.assertEquals(Datetime.now().Date(), is.Depart_Time__c);
    }

    @isTest static void singlePositiveTest() {

        Location__c loc = new Location__c(name = 'Little Rock Pizza', Address__c = '123', Location_Phone__c = '1234567891');
        Contact c = new Contact(firstName = 'Ethan', lastName = 'Wilson');
        insert loc;
        insert c;
        List<Customer_Order__c> coList = new List<Customer_Order__c>();

        for (Integer i = 0; i < 200; i++) {
            coList.add(new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now()));
        }
        
        Insert coList;
        Customer_Order__c oneMore = new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now());
        insert oneMore;

        Inventory_Shipment__c is = [SELECT id, Depart_Time__c FROM Inventory_Shipment__c ORDER BY id DESC LIMIT 1];
        System.assertEquals(Datetime.now().Date(), is.Depart_Time__c);

        //check if shipments less than 15 days
        Customer_Order__c failure = new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now());
        insert failure;
        System.assertEquals(Datetime.now().Date(), is.Depart_Time__c);
    }

    @isTest static void singleNegativeTest() {

        Location__c loc = new Location__c(name = 'Little Rock Pizza', Address__c = '123', Location_Phone__c = '1234567891');
        Contact c = new Contact(firstName = 'Ethan', lastName = 'Wilson');
        insert loc;
        insert c;
        List<Customer_Order__c> coList = new List<Customer_Order__c>();

        for (Integer i = 0; i < 200; i++) {
            coList.add(new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese', Order_Date_Time__c = DateTime.now()));
        }
        
        Insert coList;
        Customer_Order__c oneMore = new Customer_Order__c(Contact__c = c.id, Location__c = loc.id, Order_Price__c = 10, Order_Items__c = 'large cheese');
        Database.SaveResult sr = Database.insert(oneMore, false);
        System.assertEquals(false, sr.isSuccess());
        List<Inventory_Shipment__c> emptyShip = new List<Inventory_Shipment__c>();
        System.assertEquals(emptyShip, [SELECT id, Depart_Time__c FROM Inventory_Shipment__c ORDER BY id DESC LIMIT 1]);
    }
}