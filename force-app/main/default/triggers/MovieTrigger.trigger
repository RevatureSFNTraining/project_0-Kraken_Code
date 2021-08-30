////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Name: ShowTimeTrigger
// Author: Veselin Georgiev
// Created: 08/28/21
// Updated: 08/30/21
// Description: First method is a validation if we have duplicates in field Name (before insert);
// second method creates automatically a record for each new Movie__c record in each of the Teathers
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


trigger MovieTrigger on Movie__c (before insert, before update, before delete, after delete, after undelete, after update, after insert ) {
switch on trigger.operationType{
      
        when BEFORE_INSERT{
	    	MovieTriggerHandler.doingValidations(trigger.new);
        }
        when BEFORE_UPDATE{
            
        }
        When BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
  			MovieTriggerHandler.insertingShows(trigger.new);           
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}