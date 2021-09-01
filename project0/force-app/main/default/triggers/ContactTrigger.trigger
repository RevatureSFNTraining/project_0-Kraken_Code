trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    Id employeeRecordTypeId = Schema.getGlobalDescribe().get('Contact').getDescribe().getRecordTypeInfosByName().get('Employee').getRecordTypeId();
    System.assertEquals('0125f000000PHLqAAO', employeeRecordTypeId);

    List<Contact> filterContact(List<Contact> contacts, Id filterRecordTypeId){
        List<Contact> filteredContacts = new List<Contact>();
        for(Contact c : contacts){
            if(c.RecordTypeId == filterRecordTypeId){
                filteredContacts.add(c);
            }
        }
        return filteredContacts;
    }



    switch on trigger.operationType{        
        when BEFORE_INSERT{

        }
        when BEFORE_UPDATE{
            List<Contact> updatedEmployees = filterContact(Trigger.new, employeeRecordTypeId);
            if (!updatedEmployees.isEmpty()){
                ContactTriggerHandler.validateEmployeeCurrentTask(updatedEmployees, filterContact(Trigger.old, employeeRecordTypeId));
                
            }
        }
        when BEFORE_DELETE{
            
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