///////////////////////////////////////////////////////////////
//
// Name: EmployeeTriggerHelper
// Author: Ethan Wilson
// Created: Sept 2021
// Updated: Sept 2021
// Description: limits employee creation to 200, company wide
//
///////////////////////////////////////////////////////////////

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