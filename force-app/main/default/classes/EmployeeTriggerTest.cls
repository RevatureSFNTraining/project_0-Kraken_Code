@isTest private class EmployeeTriggerTest {

    @isTest static void singleTest() {
        
        Employee__c newEmp = new Employee__c();
        Database.SaveResult sr = Database.insert(newEmp , false);
        System.assert(true, sr.isSuccess());
    }
    
    @isTest static void bulkTest() {
        
        List<Employee__c> newEmpList = new List<Employee__c>();
        for (Integer i = 0; i < 150; i++) {
            newEmplist.add(new Employee__c(name='name' + i));
        }
        List<Database.SaveResult> srList = Database.insert(newEmpList , false);
        Integer numberPassed = 0;
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                numberPassed++;
            }
        }
        System.assertEquals(150, numberPassed);
    }
}