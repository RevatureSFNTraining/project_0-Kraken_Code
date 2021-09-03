trigger CapacityReachTrigger on Vessel__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType{
        
        when BEFORE_INSERT{
            
        }
        when BEFORE_UPDATE{
            CapacityReachTriggerHandler.checkVessel(trigger.new);
        }
        When BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}