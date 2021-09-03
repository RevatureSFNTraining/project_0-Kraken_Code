trigger CrewTakesItemTrigger on Take_Concession__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType{
        
        when BEFORE_INSERT{
            CrewTakesItemTriggerHandler.checkAmount(trigger.new);
        }
        when BEFORE_UPDATE{
            
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