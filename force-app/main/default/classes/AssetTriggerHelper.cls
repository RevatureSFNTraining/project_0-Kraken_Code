public class AssetTriggerHelper {
	
    public static void checkAssetLimit(List<Asset> a) {
        
        Double totalAssetPrice = Double.valueOf([SELECT SUM(price) num FROM Asset][0].get('num'));
        
        for (Asset assts : a) {
            if (totalAssetPrice >= 2000000) {
                assts.addError('Total Company assets may not exceed 2mil');
            }
        }
    }
}