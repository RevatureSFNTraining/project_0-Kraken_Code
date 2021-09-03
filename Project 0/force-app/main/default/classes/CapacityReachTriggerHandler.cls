public class CapacityReachTriggerHandler {
	public static List<Vessel__c> checkVessel(List<Vessel__c> vesselCount) {
        List<Vessel__c> vesselList = new List<Vessel__c>();
        Integer passCount;
        for(Vessel__c vesselUnit : vesselCount) {
            if(vesselUnit.Name != null && vesselUnit.Capacity__c != null) {
                vesselList = vesselCount;
            }
        }
        List<Vessel__c> existingRouteList = [SELECT Name, Passengers_Onboard__c, Capacity__c, Location__c, Account__c FROM Vessel__c];
        for(Vessel__c vesselUnit : existingRouteList) {
            if(vesselUnit.Passengers_Onboard__c > vesselUnit.Capacity__c) {
                vesselUnit.addError('The vessel is over capacity. At least ' + (vesselUnit.Passengers_Onboard__c - vesselUnit.Capacity__c) + 
                                  ' passengers must disembark the vessel.');
            }
        }
        return vesselCount;
    }
}