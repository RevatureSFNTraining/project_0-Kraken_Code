///////////////////////////////////////////////////////////////
//
// Name: EmployeeTriggerTest
// Author: Ethan Wilson
// Created: Sept 2021
// Updated: Sept 2021
// Description: It's a test yo
//
///////////////////////////////////////////////////////////////

@isTest public class EmployeeTriggerTest {

    @isTest static void bulkPositiveTest() {
        
        List<Employee__c> e = new List<Employee__c>();
        
        for (Integer i = 0; i < 300; i++){
            e.add(new Employee__c(name = 'Name Name', Employee_Phone__c = '5555555555', Employee_Email__c = 'fake' + i + '@mail.com'));
        }
        List<Database.SaveResult> srList = Database.insert(e, false);
       	Integer numFailed = 0;
           
        for (Database.SaveResult sr : srList) {
            if (!sr.isSuccess()) {
                numFailed += 1;
            }
        }
        System.assertEquals(100, numFailed);
    }

    @isTest static void bulkNegativeTest() {
        
        List<Employee__c> e = new List<Employee__c>();
        
        for (Integer i = 0; i < 300; i++){
            e.add(new Employee__c(name = 'name' + 1, Employee_Phone__c = '4343434'));
        }
        List<Database.SaveResult> srList = Database.insert(e, false);
       	Integer numFailed = 0;
           
        for (Database.SaveResult sr : srList) {
            if (!sr.isSuccess()) {
                numFailed += 1;
            }
        }
        System.assertEquals(300, numFailed);
    }
}