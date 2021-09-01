public with sharing class TaskTriggerHandler {
    public static void ensureUnique(List<Task__c> newTasks) {
        
        // Create list of names to aid in finding repeats
        List<String> names = new List<String>();
        for(Task__c newTask : newTasks){
            names.add(newTask.Name);
        }

        System.debug('Incoming names: ' + names);

        // Query for tasks with names in names
        for(Task__c task : [SELECT Id, Name FROM Task__c WHERE Name IN :names]){
            
            // Add error for any incoming repeats
            newTasks.get(names.indexOf(task.Name)).addError('Name already exists');
        }
    }
}
