public class AssetTriggerHelper {

    public static void onAssetChange(List<Asset> a) {
        List<Location__c> loc = [SELECT id, name FROM Location__c];
        for (Location__c location : loc) {
            for (Asset changedAsset : a) {
                if (changedAsset.Location__c == location.id) {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.toAddresses = new String[] {'ethanwilson1991@gmail.com'};
                    message.subject = 'There was an asset change.';
                    message.plainTextBody = 'There was an asset change. A ' + 
                    changedAsset.name + ' record was changed at location: ' + location.name;
                    Messaging.SingleEmailMessage[] messages = 
                    new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                    if (results[0].success) {
                        System.debug('The email was sent successfully.');
                    } else {
                        System.debug('The email failed to send.');
                    }    
                }   
    		}
        } 
    }
}