package com.aquapaka.donationwebapp.validator.status;

public class AddAppUserStatus {
    private boolean usernameExistError;
    private boolean usernameError;
    private boolean emailExistError;
    private boolean emailError;
    private boolean fullnameError;
    private boolean dobError;
    private boolean phoneNumberError;

    public AddAppUserStatus () {
        
    }

    public boolean isUsernameExistError() {
        return usernameExistError;
    }

    public void setUsernameExistError(boolean usernameExistError) {
        this.usernameExistError = usernameExistError;
    }

    public boolean isUsernameError() {
        return usernameError;
    }

    public void setUsernameError(boolean usernameError) {
        this.usernameError = usernameError;
    }

    public boolean isEmailExistError() {
        return emailExistError;
    }

    public void setEmailExistError(boolean emailExistError) {
        this.emailExistError = emailExistError;
    }

    public boolean isEmailError() {
        return emailError;
    }

    public void setEmailError(boolean emailError) {
        this.emailError = emailError;
    }

    public boolean isFullnameError() {
        return fullnameError;
    }

    public void setFullnameError(boolean fullnameError) {
        this.fullnameError = fullnameError;
    }

    public boolean isDobError() {
        return dobError;
    }

    public void setDobError(boolean dobError) {
        this.dobError = dobError;
    }

    public boolean isPhoneNumberError() {
        return phoneNumberError;
    }

    public void setPhoneNumberError(boolean phoneNumberError) {
        this.phoneNumberError = phoneNumberError;
    }

    public boolean isValidAppUser() {
        return !isDobError() && 
            !isEmailError() && 
            !isEmailExistError() && 
            !isFullnameError() && 
            !isPhoneNumberError() && 
            !isUsernameError() && 
            !isUsernameExistError();
    }
}
