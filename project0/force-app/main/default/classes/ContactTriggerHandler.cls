public with sharing class ContactTriggerHandler {
    public static void validateEmployeeCurrentTask(List<Contact> updatedEmployees, List<Contact> currentEmployees){
        // Create list of current employee last names
        List<String> currentEmployeeLastNames = new List<String>();
        for(Contact c : currentEmployees) {
            currentEmployeeLastNames.add(c.LastName);
        }

        System.debug('currentEmployeeLastNames: ' + currentEmployeeLastNames);

        // Create lists for managing data
        List<String> updatedEmployeeTasks = new List<String>();
        List<String> updatedTasks = new List<String>();
        for(Contact c: updatedEmployees){
            updatedEmployeeTasks.add(c.Current_Task__c);

            Integer index = currentEmployeeLastNames.indexOf(c.LastName);

            if(index >= 0){
                // Grab the current tasks between the same employee and compare
                // to determine if an update to the current task occured
                String updatedCurrentTask = c.Current_Task__c;
                String currentCurrentTask = currentEmployees.get(index).Current_Task__c;
                if(updatedCurrentTask != currentCurrentTask) {
                    updatedTasks.add(updatedCurrentTask);
                }
            }
        }
        
        System.debug('updatedTasks: ' + updatedTasks);

        System.debug('updatedEmployees before: ' + updatedEmployees);

        // TODO: determine a more optimal approach for the following two loops
        List<Contact> hasTask = new List<Contact>();
        for(Task__c task : [SELECT Id, Name FROM Task__c WHERE Name in :updatedTasks]){
            // Backtrack through lists and add employee to hasTask list
            hasTask.add(updatedEmployees.get(updatedEmployeeTasks.indexOf(task.Name)));
        }

        System.debug('updatedEmployees after: ' + updatedEmployees);
        
        // Find all employees that do not have correct tasks
        for(Contact c : updatedEmployees){
            if(!hasTask.contains(c)){
                c.addError('Tasks does not exist');
            }
        }
    }
}