@isTest
public with sharing class TaskTriggerHandlerTest {
    @isTest
    public static void singleBeforeInsertTestSuccess(){
        // Call insertTest for single action with isSuccess true
        insertTest(1, 1, true);
    }
    @isTest
    public static void singleBeforeInsertTestUnSuccess(){
        // Call insertTest for single action with isSuccess false
        insertTest(1, 1, false);
    }

    @isTest
    public static void bulkBeforeInsertTestSuccess(){
        // call insertTest for bulk action with isSuccess true 
        insertTest(200, 100, true);
    }
    @isTest
    public static void bulkBeforeInsertTestUnsuccess(){
        // call insertTest for bulk action with isSuccess false
        insertTest(200, 100, false);
    }

    // Non test method that encapsulates testing logic
    public static void insertTest(Integer initialAmount, Integer copyAmount, Boolean isSuccess){
        System.assert(initialAmount >= copyAmount);
       
        // Create first task object/s        
        List<Task__c> initialTasks = new List<Task__c>();
        for (Integer i = 0; i < initialAmount; i++){
            // Add new tasks with string concatenation for name
            initialTasks.add(new Task__c(Name = '' + i));
        }

        // Insert in database
        Database.SaveResult[] srs = Database.insert(initialTasks);

        // Assert success
        for(Database.SaveResult sr : srs){
            System.assert(sr.isSuccess());
        }

        if(!isSuccess) {
            // Create second identical task object/s
            List<Task__c> copyTasks = new List<Task__c>();
            for(Integer i = 0; i < copyAmount; i++){
                // Add new tasks with static string method
                copyTasks.add(new Task__c(Name = String.valueOf(i)));
            }

            // Insert repeated task/s
            Database.SaveResult[] srs2 = Database.insert(copyTasks, false);

            // Assert not success
            for(Database.SaveResult sr : srs2){
                System.assert(!sr.isSuccess());   
            }
        }
    }
}