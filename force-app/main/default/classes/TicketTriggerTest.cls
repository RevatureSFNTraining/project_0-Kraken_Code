@isTest
public class TicketTriggerTest {
    
    // TESTING FOR POSITIVE RESULT 1 TICKET
    @isTest
    static void positiveOneTicket() {

        List<Ticket__c> myList = TestFactory.getTicket(1, true);
        Ticket__c myt = myList[0]; 
               
        
        Test.startTest();
        Database.DeleteResult res = Database.delete(myt, false);
        
        Test.stopTest();
        
        System.assert(!res.isSuccess());
        System.assert(res.getErrors().size() > 0);
        System.assertEquals('You are not allowed to delete this record. It has a Ticket Reservation assigned to it.',
                             res.getErrors()[0].getMessage());
    }
    
    // TESTING FOR NEGATIVE RESULT 1 TICKET (if there is no reservation assigned to the ticket,
    // it will be deleted)
   
    @isTest 
    static void negativeOneTicket() {

        List<Ticket__c> myList = TestFactory.getTicket(1, false);
        Ticket__c myt = myList[0]; 
        
        Test.startTest();
        Database.DeleteResult res = Database.delete(myt, true); 
        Test.stopTest();
        
        System.assert(res.isSuccess());
    }
    
    // BULK TEST 
    @isTest
    static void positiveManyTickets(){
        List<Ticket__c> myList = TestFactory.getTicket(200, true);
        
        Test.startTest();
        
        	Database.DeleteResult[] res = Database.delete(myList, false);
        
        Test.stopTest();
        for(Database.DeleteResult dr : res) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
            System.assertEquals('You are not allowed to delete this record. It has a Ticket Reservation assigned to it.',
                                 dr.getErrors()[0].getMessage());
    	}
    }          
}