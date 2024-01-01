public class InternalCommentHandler {
    
    public static void insertComment(List<Internal_Comment__c> records){
        List<InternalComment__c> InternalCommentLength = InternalComment__c.getall().values();
        Decimal BodyLength = InternalCommentLength[0].Length__c;
        for(Internal_Comment__c tmp : records){
            
            tmp.Body__c = formatText(tmp.Body__c, BodyLength);
        }
    }
    
    public static String formatText(String text, Decimal maxLineLength) {
        String formattedText = '';
        Integer currentLineLength = 0;

        // Split the text into words
        List<String> words = text.split(' ');

        for (String word : words) {
            // Check if adding the word would exceed the max line length
            if (currentLineLength + word.length() + 1 > maxLineLength) {
                // Add a newline and reset the current line length
                formattedText += '\n';
                currentLineLength = 0;
            }

            formattedText += word + ' '; // Append the word and a space
            currentLineLength += word.length() + 1; // Update the current line length
        }

        // Remove any trailing space
        return formattedText.trim();
    }
    
    
    
     public static Boolean withError(List<Internal_Comment__c> records){
        List<InternalComment__c> InternalCommentLength = InternalComment__c.getall().values();
        Decimal BodyLength = InternalCommentLength[0].Length__c;
        for(Internal_Comment__c tmp : records){
            Decimal position = 0;
            for(Integer index=0; index < tmp.Body__c.length(); index++){
                if(position > BodyLength){
                    tmp.addError('Row out of boundary of ' + BodyLength + ' character');
                    return true;
					                    
                }
                if(tmp.Body__c.charAt(index) != 10)
                    position++;
            }
        }
        return false;
     }

}