public class EmployeeTriggerHelper {
	public static void checkNoEmployees(List<Employee__c> e) {

        List<AggregateResult> stores = [SELECT count(id), Location__r.id FROM Employee__c GROUP BY Location__r.id HAVING count(id) >=25];
        for (Employee__c emp : e) {
            for (AggregateResult store : stores) {
                if (emp.Location__r.id == store.id) {
                    emp.addError('Can not add more than 25 employees to one store!');
                }
            }
        }
    }
}