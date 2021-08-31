////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Name: ShowTimeTriggerHandler
// Author: Veselin Georgiev
// Created: 08/28/21
// Updated: 08/30/21
// Description: validates if a show time has duplicate with the same time, location, and movie
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

public class ShowTimeTriggerHandler {
    public static void validate3Fields(List<Show_Time__c> newEntries) {
        
        List<Show_Time__c> existingShows = [SELECT Id, Start_Time__c, Movie__c, Theater__c FROM Show_Time__c];
        
        for (Show_Time__c newS: newEntries) {
            for(Show_Time__c oldS: existingShows) {
                if (newS.Start_Time__c == oldS.Start_Time__c && newS.Movie__c == oldS.Movie__c && newS.Theater__c == oldS.Theater__c) {
                    newS.addError('There is already existing Show for this Movie, Time and Location');
                }
            }
        }
    }
}