trigger AssetTrigger on Asset (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    Switch on Trigger.OperationType {
        When BEFORE_INSERT {
			AssetTriggerHelper.checkAssetLimit(Trigger.New);
        }
        When BEFORE_UPDATE {
            
        }
        When BEFORE_DELETE {
            
        }
        When AFTER_INSERT {
          
        }
        When AFTER_UPDATE {
            
        }
        When AFTER_DELETE {
            
        }
        When AFTER_UNDELETE {
            
        }
    }
}