////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Name: ShowTimeTrigger
// Author: Veselin Georgiev
// Created: 08/28/21
// Updated: 08/30/21
// Description: trigger activates before inserting and updating Show_Time__c object
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


trigger ShowTimeTrigger on Show_Time__c (before insert, before update, before delete, after delete, after undelete, after update, after insert ) {
switch on trigger.operationType{
      
        when BEFORE_INSERT{
		   	ShowTimeTriggerHandler.validate3Fields(trigger.new);
        }
        when BEFORE_UPDATE{
            ShowTimeTriggerHandler.validate3Fields(trigger.new);
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