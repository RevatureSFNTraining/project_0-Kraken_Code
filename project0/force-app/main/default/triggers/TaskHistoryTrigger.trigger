trigger TaskHistoryTrigger on Task_History__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType{        
        when BEFORE_INSERT{
            TaskHistoryTriggerHandler.validateTaskField(Trigger.new);
        }
        when BEFORE_UPDATE{

        }
        when BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            TaskHistoryTriggerHandler.removeCustomerRelationshipFromTask(Trigger.new);            
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}