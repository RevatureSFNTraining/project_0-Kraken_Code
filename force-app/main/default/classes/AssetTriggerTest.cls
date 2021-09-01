@isTest public class AssetTriggerTest {
	
    @isTest static void test() {
        
      	//single
        Asset a = new Asset(name='newBuilding', price = 2000001);               
        Database.SaveResult singleSr = Database.insert(a, false);
        system.assertEquals(singleSr.isSuccess(), true);
        
		//bulk
        List<Asset> aList = new List<Asset>();
        for (Integer i = 0; i < 10; i++){
        	aList.add(new Asset(name='newBuilding' + i, price = 2000001));   
        }
        
        List<Database.SaveResult> srList = Database.insert(aList, false);
        for (Database.SaveResult sr : srList) {
            system.assertEquals(sr.isSuccess(), false);
        }   
    }
}