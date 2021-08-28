public class AssetTriggerHelper {

    public static void onShipmentChange(List<Asset> a) {
        List<Location__c> locations = [SELECT name FROM Location__c];
        for (Location__c loc : locations) {
            for (Asset aMessage : a) {
                if (aMessage.Location__r.id == loc.id) {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.toAddresses = new String[] {'ethanwilson1991@gmail.com'};
                    message.subject = 'There was an asset change.';
                    message.plainTextBody = 'There was an asset change. A ' + aMessage.name + ' record was changed at location: ' + loc.name;
                    Messaging.SingleEmailMessage[] messages = 
                    new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                    if (results[0].success) {
                        System.debug('The email was sent successfully.');
                    } else {
                        System.debug('The email failed to send: '
                        + results[0].errors[0].message);
                    }
                }  
        	}
        } 
    }
    
    public static void onShipmentChange(List<Asset> a, List<Asset> b) {
        
        
    }
}