public with sharing class TaskHistoryTriggerHandler {

    public static void validateTaskField(List<Task_History__c> histories) {

        // Initialize collections that will help track data
        Map<Task_History__c, Integer> countTracker = new Map<Task_History__c, Integer>();
        List<String> names = new List<String>();

        for(Task_History__c history : histories) {

            // Add task history names to names list
            names.add(history.Name);

            // Create key-value pairs with task history object and intial count of 0
            countTracker.put(history, 0);
        }

        System.debug('Incoming task names: ' + names);
        System.debug('Map state before query' + countTracker);

        // Query for all tasks with the same names as the incoming task histories
        for(Task__c task : [SELECT id, Name FROM Task__c where Name IN :names]){

            // There is a one-to-one between the elements of names and histories
            // and that relationship can be used to work backwards to get the 
            // task history object from the task object name.
            integer indexOfName = names.indexOf(task.Name);
            Task_History__c history = histories[indexOfName];

            // Update the count of the task history object.
            integer nameCount = countTracker.get(history);
            countTracker.put(history, ++nameCount);
        }

        System.debug('Map state after query: ' +  countTracker);

        // Loop through the incoming task histories and check the count stored in countTracker.
        for(Task_History__c history : histories){
            Integer count = countTracker.get(history);
            if (count == 0) {

                // Add error.
                history.addError('The name provided does not match any tasks.');

            } else if (count >= 2) {

                // This is a layer of redundancy as there is validation to ensure unique tasks.
                history.addError('There seem to be multiple tasks with this name');
            }
        }
    }

    public static void removeCustomerRelationshipFromTask(List<Task_History__c> histories){
        List<String> names = new List<String>();

        for(Task_History__c history : histories) {

            // Add task history names to names list
            names.add(history.Name);
        } 

        System.debug('Incoming names: ' + names);

        List<Task__c> updatedTasks = new List<Task__c>();
        // Query for all tasks with the same names as the incoming task histories
        for(Task__c task : [SELECT id, Name, Customer__c FROM Task__c where Name IN :names]){
            // Set cutomer relationship to null
            task.Customer__c = null;
            updatedTasks.add(task);
        }

        System.debug('Updated tasks: ' + updatedTasks);

        // Add to database
        Database.update(updatedTasks, false);
    }
}