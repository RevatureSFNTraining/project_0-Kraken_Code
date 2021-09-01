@isTest
public with sharing class TaskHistoryTriggerHandlerTest {
    
    @isTest
    public static void singleBeforeInsertSuccess(){
        // Call beforeInsert for single action with isSuccess true
        beforeInsert(1, true);
    }
    
    @isTest
    public static void singleBeforeInsertUnsuccess(){
        // Call beforeInsert for single action with isSuccess false
        beforeInsert(1, false);
    }

    
    @isTest
    public static void bulkBeforeInsertSuccess() {
        // Call beforeInsert for bulk action with isSuccess true
        beforeInsert(100, true);
    }

    @isTest
    public static void bulkBeforeInsertUnSuccess() {
        // Call beforeInsert for bulk action with isSuccess false
        beforeInsert(100, false);
    }

    public static void beforeInsert(Integer amount, Boolean isSuccess) {
        // Declare variable for name to ensure it's the same for both objects
        String taskName = 'Test Task';

        //Create and insert test task/s with name variable
        List<Task__c> tasks = new List<Task__c>();
        for(Integer i = 0; i < amount; i++){
            tasks.add(new Task__c(Name = taskName + i));
        }
        insert tasks;

        //Create and insert test customer/s
        List<Contact> customers = new List<Contact>();
        for(Integer i = 0; i < amount; i++){
            customers.add(new Contact(LastName = 'Test Smith' + i, RecordTypeId = '0125f000000PGmnAAG', MobilePhone = '8883336666'));
        }      
        insert customers;
        
        String addWrong = '';
        if(!isSuccess) {
            addWrong = 'Wrong';
        }

        // Create list of histories by iterating over customers list and grabbing customer id
        List<Task_History__c> taskHistories = new List<Task_History__c>();
        for(Integer i = 0; i < amount; i++){

            // Grab the customer id
            Id testCustomerId = customers.get(i).Id;

            // Create task history with the name variable and customer id
            taskHistories.add(new Task_History__c(Name = taskName + i + addWrong, Customer__c = testCustomerId, Payment__c = 1.20));
        }

        // Insert task history object into database and store result in variable
        Database.SaveResult[] saveResults = Database.insert(taskHistories, False);

        system.debug('test task histories: '+ taskHistories);

        // Assert to ensure insertion was un/successful
        for(Database.SaveResult saveResult : saveResults){
            System.debug(saveResult);
            if(isSuccess){
                system.assert(saveResult.isSuccess()); 
            } else {
                system.assert(!saveResult.isSuccess());
            }
        }       
    }

    @isTest
    public static void testSingleAfterInsertPass() {
        // Call afterInsert for single action
        afterInsert(1);
    }

    @isTest
    public static void bulkAfterInsertSuccess(){
        // Call afterInsert for bulk action
        afterInsert(100);
    }

    public static void afterInsert(Integer amount) {
        beforeInsert(amount, true);

        // Querying here enables the task to be updated before asserting
        for(Task__c task : [SELECT Id, Customer__c From Task__c]){
            System.assert(task.Customer__c == null);
        }         
    }

}