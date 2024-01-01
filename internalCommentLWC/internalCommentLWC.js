import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import INTERNAL_COMMENT_OBJECT from '@salesforce/schema/Internal_Comment__c';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class InternalCommentLWC extends LightningElement {
    @api recordId; 
    isModalOpen = true;
    comment = '';

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    ChangeComment(event){
        this.comment = event.target.value ?? "";
    }

    handleSubmit() {        
        const recordInput = { apiName: INTERNAL_COMMENT_OBJECT.objectApiName, fields: {Body__c: this.comment,
            Account__c: this.recordId
        } };
        createRecord(recordInput)
            .then((createdRecordId) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success', 
                        message: 'Thank you for your comment!',
                        variant: 'success'
                    })
                );
                this.closeModal();
            })
            .catch((error) => {
                console.log('Error');
                console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to create comment: ' + error.body.output.errors[0].message,
                        variant: 'error'
                    })
                );
            });
    }
}