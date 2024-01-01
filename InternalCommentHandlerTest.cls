@IsTest
public class InternalCommentHandlerTest {

    @TestSetup
    static void setup() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        InternalComment__c InternalCommentLength = new InternalComment__c(Name = 'Test Length', Length__c = 40);
        insert InternalCommentLength;
    }
    
    @IsTest
    static void insertInternalComment(){
        Account acc = [Select Id from Account][0];
        Internal_Comment__c icgood = new Internal_Comment__c(Account__c = acc.id, Body__c = 'aaaaaaaaaaa bbbbbbbbbbbb');
        Internal_Comment__c icerror = new Internal_Comment__c(Account__c = acc.id, Body__c = 'aaaaaaaaaaa bbbbbbbbbbbb ccccccccccc dddddddddd');
        test.startTest();
        insert icgood;
        try{
            insert icerror;
        }
        catch(DMLException ex){
            
        }
        test.stopTest();   
        // System.assert(resBody.toString() != null);
    }
}