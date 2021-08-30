////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Name: TicketTrigger
// Author: Veselin Georgiev
// Created: 08/30/21
// Updated: 08/30/21
// Description: This handler avoid deleting of a ticket if it has a reservation assigned to it
// 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public class TicketTriggerHandler {
    public static void avoidDeleting(List<Ticket__c> ticketRecords){
        for (Ticket__c t: ticketRecords) {
            if (t.Sold__c) {
                t.addError('You are not allowed to delete this record. It has a Ticket Reservation assigned to it.');
            }
        }   
    }
}