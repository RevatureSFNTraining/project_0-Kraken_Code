@isTest
public class ShowTimeTriggerTest {
    //single positive
	@isTest
    static void positiveResult(){
         Show_Time__c mys = TestFactory.creatingShow();
        insert mys;
        
        List<Show_Time__c> myList = new List<Show_Time__c>();
        for (Integer i = 1; i <= 2; i++) {
            Show_Time__c mydubl = new Show_Time__c();
            myList.add(mydubl);
        }
       
        myList[0].Start_Time__c = mys.Start_Time__c;
        myList[0].Movie__c = mys.Movie__c;
        myList[0].Theater__c = mys.Theater__c;
        
       		myList[1].Start_Time__c = Time.newInstance(17, 30, 00, 000);
            myList[1].Movie__c = mys.Movie__c;
            myList[1].Theater__c = mys.Theater__c;
        	insert myList[1];
        
        	system.debug('test check           ' + myList[1]);
        	myList[1].Start_Time__c = mys.Start_Time__c;
        
        Test.startTest();
        
        Database.SaveResult res1 = Database.update(myList[1], false);
        Database.SaveResult res = Database.insert(myList[0], false); 
        
        Test.stopTest();
        
        System.assert(!res.isSuccess());
        System.assert(res.getErrors().size() > 0);
        System.assertEquals('There is already existing Show for this Movie, Time and Location',
                                 res.getErrors()[0].getMessage());
        
        System.assert(!res1.isSuccess());
        System.assert(res1.getErrors().size() > 0);
        System.assertEquals('There is already existing Show for this Movie, Time and Location',
                                 res1.getErrors()[0].getMessage());
    }
    
    // single negative
     
   @isTest
    static void negativeResult(){
        Show_Time__c mys = TestFactory.creatingShow();
        insert mys;
        
        List<Show_Time__c> myList = new List<Show_Time__c>();
        for (Integer i = 1; i <= 2; i++) {
            Show_Time__c mynew = new Show_Time__c();
            mynew.Start_Time__c = Time.newInstance(17, 30, 00, 000);
            mynew.Movie__c = mys.Movie__c;
            mynew.Theater__c = mys.Theater__c;
            
            myList.add(mynew);
        }
        insert myList[1];
        myList[1].Start_Time__c = Time.newInstance(12, 30, 00, 000);
        
        Test.startTest();
        
        Database.SaveResult res1 = Database.update(myList[1], true);
        Database.SaveResult res = Database.insert(myList[0], true); 
        
        Test.stopTest();
        
        System.assert(res.isSuccess());
        System.assert(res.getErrors().size() == 0);
        
        System.assert(res1.isSuccess());
        System.assert(res1.getErrors().size() == 0);
    }
    
    @isTest
    static void bulkTest() {
        Show_Time__c mys = TestFactory.creatingShow();
        insert mys;
        
        List<Show_Time__c> myList = new List<Show_Time__c>();
        for (Integer i = 1; i <= 200; i++) {
            Show_Time__c mynew = new Show_Time__c();
            mynew.Start_Time__c = mys.Start_Time__c;
            mynew.Movie__c = mys.Movie__c;
            mynew.Theater__c = mys.Theater__c;
            
            myList.add(mynew);
        }
        Test.startTest();
        
  //    Database.SaveResult res1 = Database.update(myList[1], true);
        Database.SaveResult[] res = Database.insert(myList, false); 
        
        Test.stopTest();
        
        for(Database.SaveResult sr: res) {
            System.assert(!sr.isSuccess());
        	System.assert(sr.getErrors().size() > 0);
       		System.assertEquals('There is already existing Show for this Movie, Time and Location',
                                 sr.getErrors()[0].getMessage());
        }
    }
    /*
    @isTest 
    static void testing() {
         Movie__c mym = new Movie__c(
        	Name='super cool 1',
        	Released_Date__c = Date.valueOf('2021-09-14'),
            Genre__c='Comedy'
        );
		 insert mym;
        
        Test.startTest();
        List <Movie__c> movies = [SELECT id,(SELECT id, Movie__c, Start_Time__c, Theater__c from Show_Times__r) FROM Movie__c];
        system.debug('in test         ' + movies);
        Test.stopTest();
        system.debug('out test         ' + movies);
    }
    */    
}