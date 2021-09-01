@isTest
public class MovieTriggerTest {
    @isTest
    static void negativeCase() {
     
    // movie with no genre    
    	Movie__c mym = new Movie__c();
  		mym.Name='my super movie';
    	mym.Released_Date__c = Date.valueOf('2021-09-05');
        
    //movie with all needed 
     	Movie__c myMovie = new Movie__c (
     	Name = 'My new Movie',
        Released_Date__c = Date.today() - 2,
        Genre__c = 'Comedy'
        ); 
        insert myMovie;
    //movie with same name
    	Movie__c mydubl = new Movie__c();
        mydubl.Name = 'My new Movie'; 
        mydubl.Released_Date__c = Date.today() -10;
        mydubl.Genre__c = 'Drama';
        
    Test.startTest();
    
    	Database.SaveResult res0 = Database.insert(mydubl,false);
    	Database.SaveResult res = Database.insert(mym, false);
    
    Test.stopTest(); 
    
        System.assert(!res.isSuccess());
    	System.assertEquals('Please fill out the genre',res.getErrors()[0].getMessage());
        System.assert(!res0.isSuccess());
    	System.assertEquals('The movie My new Movie already exists',res0.getErrors()[0].getMessage());
        
    }

    @isTest
    
    static void positiveCase() {
      Movie__c mym = new Movie__c(
        	Name='super cool',
        	Released_Date__c = Date.valueOf('2021-09-14'),
            Genre__c='Comedy'
        );

       	Test.startTest();
               
    	Database.SaveResult res = Database.insert(mym, true);
        
    	Test.stopTest();

        System.assert(res.isSuccess());
    }
}