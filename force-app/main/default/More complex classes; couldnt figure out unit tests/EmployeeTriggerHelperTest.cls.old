@isTest public class EmployeeTriggerHelperTest {
    
    @isTest static void BulkTest() {

        Location__c loc = new Location__c(name = 'Little Rock Pizza', Address__c = '123', Location_Phone__c = '1234567891');
        List<Employee__c> e = new List<Employee__c>();
        for (Integer i; i < 52; i++) {
            e.add(new Employee__c(name = 'name' + i, Employee_Phone__c = '34343', Employee_Email__c = 'email' + i + '@email.com', Location__r = loc));
        }
        EmployeeTriggerHelper.checkNoEmployees(e);
        List<Database.SaveResult> sr = Database.insert(e, false);
        for (Database.SaveResult s : sr) {
            List<Database.Error> errors = s.getErrors();
            for (Database.Error error : errors) {
                System.assertEquals('Can not add more than 25 employees to one store!', error.getMessage());
            }
        }
        
    }
}