////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Name: TicketTrigger
// Author: Veselin Georgiev
// Created: 08/30/21
// Updated: 08/30/21
// Description: check before deleting a ticket if it has a reservation assigned to it
// 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

trigger TicketTrigger on Ticket__c (before insert, before update, before delete, after delete, after undelete, after update, after insert ) {
switch on trigger.operationType{
      
        when BEFORE_INSERT{
            
        }
        when BEFORE_UPDATE{
             
        }
        When BEFORE_DELETE{
      		TicketTriggerHandler.avoidDeleting(trigger.old);      
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