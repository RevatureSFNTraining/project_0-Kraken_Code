public class EmployeeTriggerHelper {
    
    
	public static void checkNoEmployees(List<Employee__c> e) {

    	List<Employee__c> emps = [SELECT id FROM Employee__c];
        for (Employee__c newEmp : e) {
            if (emps.size() >= 200) {
            	newEmp.addError('Max employee count is 200!');
            }
        }  
    }
}