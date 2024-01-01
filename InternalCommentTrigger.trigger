trigger InternalCommentTrigger on Internal_Comment__c (before insert) {
    
    if(trigger.isBefore && trigger.isInsert){
        //InternalCommentHandler.withError(trigger.new);
        InternalCommentHandler.insertComment(trigger.new);
        
    }

}