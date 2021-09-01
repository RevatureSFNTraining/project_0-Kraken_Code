@isTest
public class TestFactory {
    
    public static Ticket__c[] getTicket(Integer numTickets, Boolean isReserved) {
       	// creating a Movie
       	Movie__c myMovie = new Movie__c (
            Name = 'My new Movie' + numTickets,
            Released_Date__c = Date.today() - 2,
            Genre__c = 'Comedy'
        ); 
        insert myMovie;
        
        //creating a single employee, contact so I can create a ticket reservation later
        Employee__c emp = new Employee__c(
            Name='Employo Emp',
            Gender__c='Male',
            Phone_Number__c='(443) 431-0308',
            Birth_Date__c=Date.valueOf('1980-08-16')
        );
        
        insert emp;
        
        Contact customer = new Contact(
            FirstName = 'first',
            LastName = 'Lastly'
        );
        
        insert customer; 
        
        //after inserting 1 employee and 1 customer in the database I can create a ticket reservation
        // there is no limit how many tickets can be assigned to 1 ticket reservation
       
        Ticket_Reservation__c myR = new Ticket_Reservation__c(
            Reservation_Date__c = Date.today().addDays(5),
            Employee__c = emp.Id,
            Contact__c = customer.Id
        );
        insert myR;
    
        List<Ticket__c> myTickets = new List<Ticket__c>();
        for (Integer i = 0; i < numTickets; i++) {
            Ticket__c t = new Ticket__c(Seat_Type__c='Normal', Movie__c = myMovie.id);
            if(isReserved) {
                t.Ticket_Reservation__c= myR.id;
            }
            myTickets.add(t);
        }
                  
       insert myTickets; 
       return myTickets;     
    }
    
    public static Show_Time__c creatingShow() {
        // creating a movie 
            Movie__c myMovie = new Movie__c ();
            	myMovie.Name = 'My new Movie';
            	myMovie.Released_Date__c = Date.today() - 2;
            	myMovie.Genre__c = 'Comedy';
 
        insert myMovie;
        
       	// creating a theater
    		Theater__c ttr = new Theater__c();
                ttr.Name='theater1';
                ttr.City__c='loc1';
    		
    	insert ttr; 
        
        //creating a show_time
   //     List<Show_Time__c> newShowTimes = new List<Show_Time__c>();
   //     for (Integer i=0; i< numShows; i++) {
            Show_Time__c sh = new Show_Time__c();
            sh.Start_Time__c = Time.newInstance(18, 30, 00, 000);
     //       if (isSame){        
                sh.Movie__c = myMovie.Id;
                sh.Theater__c = ttr.Id;
    //        } 
   //    	newShowTimes.add(sh);
  //      }
  //     insert sh;
        return sh;
    }
    
    	      
}