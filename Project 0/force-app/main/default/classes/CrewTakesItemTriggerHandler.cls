public class CrewTakesItemTriggerHandler {
	public static List<Take_Concession__c> checkAmount(List<Take_Concession__c> itemCount) {
        List<Take_Concession__c> itemAmountList = new List<Take_Concession__c>();
        for(Take_Concession__c itemUnits : itemCount) {
            if(itemUnits.Name != null && itemUnits.Items_Taken__c != null && itemUnits.Amount_Taken__c != null) {
                itemCount.add(itemUnits);
            }
        }
        List<Take_Concession__c> existingTakeList = [SELECT Items_Taken__c, Amount_Taken__c FROM Take_Concession__c];
        for(Take_Concession__c existingTake : existingTakeList) {
            itemAmountList.add(existingTake);
        }
        
        for(Take_Concession__c takeUnit : itemAmountList) {           
            if(takeUnit.Amount_Taken__c > 2) {
                takeUnit.addError('Employees can only take 1 item at a time!');
            }
        }
        return itemCount;
    }
}
