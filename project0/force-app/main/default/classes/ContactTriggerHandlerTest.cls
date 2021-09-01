@isTest
public with sharing class ContactTriggerHandlerTest {
    @isTest
    public static void beforeUpdateSingleActionSuccess(){
        // Call beforeUpdate for single action with isSuccess true
        beforeUpdate(1, true);
    }

    @isTest
    public static void beforeUpdateSingleActionUnsuccess(){
        // Call beforeUpdate for single action with isSuccess false
        beforeUpdate(1, false);
    }    

    @isTest
    public static void beforeUpdateBulkActionSuccess(){
        // Call beforeUpdate for bulk action with isSuccess true
        beforeUpdate(100, true);
    }

    @isTest
    public static void beforeUpdateBulkActionUnSuccess() {
        // Call beforeUpdate for bulk action with isSuccess false
        beforeUpdate(100, false);
    }

    // Non test method that encapsulates all logic
    public static void beforeUpdate(Integer amount, Boolean isSuccess){

        // Create and populate lists of Employees and tasks
        List<Contact> newEmployees = new List<Contact>();
        List<Task__c> newTasks = new List<Task__c>();
        for(Integer i = 0; i < amount; i++){
            newEmployees.add(new Contact(LastName = 'Test Smith' + i, RecordTypeId = '0125f000000PHLqAAO'));
            newTasks.add(new Task__c(Name = 'Test task' + i));
        }

        System.debug('newEmployees before: ' + newEmployees);
        System.debug('newTasks: ' + newTasks);

        // Insert objects to database
        insert newEmployees;
        insert newTasks;

        // Initialize Unsuccess string to empty and reassign based on isSuccess
        String addWrong = '';
        if(!isSuccess){
            addWrong = 'Wrong';
        }

        // Iterate over both employees and tasks and assign task to employee
        // with the addWrong String
        for(Integer i = 0; i < amount; i++){
            newEmployees.get(i).Current_Task__c = newTasks.get(i).Name + addWrong;
        }        

        System.debug('newEmployees updated: ' + newEmployees);

        // Update database with updated employee tasks
        Database.SaveResult[] srs = Database.update(newEmployees, false);

        System.debug('srs: ' + srs);

        // Iterate over save results and assert based on isSuccess
        for(Database.SaveResult sr : srs){
            if(isSuccess){
                System.assert(sr.isSuccess());
            } else {
                System.assert(!sr.isSuccess());
            }
        }
    }
}