@isTest 
private class CustomerOrderTriggerTest {

    @isTest static void singleTest () {

        Customer_Order__c custOrder = new Customer_Order__c();
        Database.SaveResult sr = Database.insert(custOrder, false);
        System.assertEquals(true, sr.isSuccess());
    }
}