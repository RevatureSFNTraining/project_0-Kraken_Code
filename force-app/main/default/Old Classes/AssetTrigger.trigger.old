trigger AssetTrigger on Asset (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            
        }
        when BEFORE_UPDATE {
            
        }

        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            AssetTriggerHelper a = new AssetTriggerHelper();
            a.onAssetChange(Trigger.new);
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            AssetTriggerHelper a = new AssetTriggerHelper();
            a.onAssetChange(Trigger.new);
        }
        when AFTER_UNDELETE {
            AssetTriggerHelper a = new AssetTriggerHelper();
            a.onAssetChange(Trigger.new);
        }

    }
}