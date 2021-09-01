trigger CustomerOrderTrigger on Customer_Order__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    Switch on Trigger.OperationType {
        When BEFORE_INSERT {

        }
        When BEFORE_UPDATE {
            
        }
        When BEFORE_DELETE {
            
        }
        When AFTER_INSERT {
            CustomerOrderTriggerHelper.checkAutoShip();
        }
        When AFTER_UPDATE {
            
        }
        When AFTER_DELETE {
            
        }
        When AFTER_UNDELETE {
            
        }
    }
}