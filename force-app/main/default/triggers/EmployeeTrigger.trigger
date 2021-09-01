///////////////////////////////////////////////////////////////
//
// Name: EmployeeTrigger
// Author: Ethan Wilson
// Created: Sept 2021
// Updated: Sept 2021
// Description: It's a trigger yo
//
///////////////////////////////////////////////////////////////

trigger EmployeeTrigger on Employee__c (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    switch on Trigger.operationType {
        
        when BEFORE_INSERT {
            EmployeeTriggerHelper.checkNoEmployees(Trigger.new);
        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}