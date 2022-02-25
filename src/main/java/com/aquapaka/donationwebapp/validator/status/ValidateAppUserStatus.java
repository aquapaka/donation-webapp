package com.aquapaka.donationwebapp.validator.status;

public class ValidateAppUserStatus {
    private boolean isFullnameError;
    private boolean isDobError;
    private boolean isPhoneNumberError;

    public ValidateAppUserStatus() {

    }

    public boolean isFullnameError() {
        return isFullnameError;
    }

    public void setFullnameError(boolean isFullnameError) {
        this.isFullnameError = isFullnameError;
    }

    public boolean isDobError() {
        return isDobError;
    }

    public void setDobError(boolean isDobError) {
        this.isDobError = isDobError;
    }

    public boolean isPhoneNumberError() {
        return isPhoneNumberError;
    }

    public void setPhoneNumberError(boolean isPhoneNumberError) {
        this.isPhoneNumberError = isPhoneNumberError;
    }

    public boolean isValidAppUser() {
        return !isFullnameError() && !isDobError() && !isPhoneNumberError();
    }
}
