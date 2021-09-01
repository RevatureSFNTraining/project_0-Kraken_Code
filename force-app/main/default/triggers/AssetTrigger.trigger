trigger AssetTrigger on Asset (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    Switch on Trigger.OperationType {
        When BEFORE_INSERT {
			
        }
        When BEFORE_UPDATE {
            
        }
        When BEFORE_DELETE {
            
        }
        When AFTER_INSERT {
            AssetTriggerHelper.onAssetChange(Trigger.New);
        }
        When AFTER_UPDATE {
            
        }
        When AFTER_DELETE {
            AssetTriggerHelper.onAssetChange(Trigger.Old);
        }
        When AFTER_UNDELETE {
            AssetTriggerHelper.onAssetChange(Trigger.New);
        }
    }
}