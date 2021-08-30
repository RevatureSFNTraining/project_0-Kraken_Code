public class ContactTriggerHandler {
    
    static Date today = Date.today();
   
    
    public static void emailReminder() {

		List<Contact> contactList = [SELECT Id, Email, LastName,(SELECT Reservation_Date__c FROM Ticket_Reservations__r)  
                                     FROM Contact WHERE Reservations__c >= 1 AND Email != null ];
        for (Contact c: contactList) {
         
            Date lastReservation = c.Ticket_Reservations__r[0].Reservation_Date__c;
          	Integer daysDifference = lastReservation.daysBetween(today);
            if (daysDifference == 30) {
                
            }
            	Messaging.SingleEmailMessage reminder = new Messaging.SingleEmailMessage();
				reminder.toAddresses = new String[] { c.Email };
				reminder.subject = 'Opt Out Test Message';
				reminder.plainTextBody = 'This is the message body.';
				Messaging.SingleEmailMessage[] messages = 
    			new List<Messaging.SingleEmailMessage> {reminder};
         		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
				if (results[0].success) {
    					System.debug('The email was sent successfully.');
				} else {
    					System.debug('The email failed to send: ' + results[0].errors[0].message);
}
        }
    }
}

// no trigger here !!!!