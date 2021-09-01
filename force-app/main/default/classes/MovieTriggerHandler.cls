///////////////////////////////////////////////////////////////
//
// Name: MovieTriggerHandler
// Author: Veselin, Georgiev
// Created: 08/28/21
// Updated: 08/30/21
// Description: My first trigger
//
///////////////////////////////////////////////////////////////

public class MovieTriggerHandler {
    // BEFORE INSERT
    
    public static void doingValidations(List<Movie__c> freshMovieList) {
                
        Set<String> newMovieSet = new Set<String>();
        for (Movie__c m: freshMovieList) {
            if (m.Genre__c == null) {
                m.Genre__c.addError('Please fill out the genre');
            }
            newMovieSet.add(m.Name);
        }
        Map<String, Movie__c> existingMovieMap = new Map<String, Movie__c>();
        for(Movie__c availableM: [SELECT name, id FROM Movie__c WHERE name IN :newMovieSet]){
            	existingMovieMap.put(availableM.Name.toUpperCase(), availableM);
        }
                              
        for (Movie__c newM: freshMovieList) {
        
            Movie__c duplicate = existingMovieMap.get(newM.Name.toUpperCase());
            if (duplicate != null) {
                newM.Name.addError('The movie ' + duplicate.Name + ' already exists');
            } 
        }
    }
    
    
    // AFTER INSERT
    public static void insertingShows(List<Movie__c> insertedMovies) {
        
        
        //find all the theaters that are available
        List<Theater__c> allTeathers = [SELECT name, id FROM Theater__c];
        
        for(Movie__c newlyInserted: insertedMovies){
            
      //      system.debug('newlyInserted movie: ' + newlyInserted);
            
         //create an empty list of type Show Time
       	List<Show_Time__c> newShows = new List<Show_Time__c>(); 
            
            for (Theater__c t: allTeathers ) {
                // create a new record of premiere Show_Time for each Teather
            	Show_Time__c newPremiere = new Show_Time__c(
                Movie__c=newlyInserted.id,    
            	Start_Time__c=Time.newInstance(21, 30, 0, 00),
                Theater__c=t.id           
            );
                newShows.add(newPremiere);
            }

                 insert newShows;                        
        }      
	}  
    
}