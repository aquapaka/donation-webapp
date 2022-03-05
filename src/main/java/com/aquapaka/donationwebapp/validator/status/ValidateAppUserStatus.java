package com.aquapaka.donationwebapp.validator.status;

public class ValidateAppUserStatus {
    private boolean fullnameError;
    private boolean dobError;
    private boolean phoneNumberError;

    public ValidateAppUserStatus() {

    }

    public boolean isFullnameError() {
        return fullnameError;
    }

    public void setFullnameError(boolean isFullnameError) {
        this.fullnameError = isFullnameError;
    }

    public boolean isDobError() {
        return dobError;
    }

    public void setDobError(boolean isDobError) {
        this.dobError = isDobError;
    }

    public boolean isPhoneNumberError() {
        return phoneNumberError;
    }

    public void setPhoneNumberError(boolean isPhoneNumberError) {
        this.phoneNumberError = isPhoneNumberError;
    }

    public boolean isValidAppUser() {
        return !isFullnameError() && !isDobError() && !isPhoneNumberError();
    }
}
