package com.aquapaka.donationwebapp.model.status;

public class RegisterStatus {
    private boolean resUsernameExistError;
    private boolean resUsernameError;
    private boolean resEmailExistError;
    private boolean resEmailError;
    private boolean resPasswordError;
    private boolean registerSuccess;
    
    public RegisterStatus() {
    }

    public boolean isResUsernameExistError() {
        return resUsernameExistError;
    }

    public void setResUsernameExistError(boolean resUsernameExistError) {
        this.resUsernameExistError = resUsernameExistError;
        updateRegisterSuccess();
    }

    public boolean isResUsernameError() {
        return resUsernameError;
    }

    public void setResUsernameError(boolean resUsernameError) {
        this.resUsernameError = resUsernameError;
        updateRegisterSuccess();
    }

    public boolean isResEmailExistError() {
        return resEmailExistError;
    }

    public void setResEmailExistError(boolean resEmailExistError) {
        this.resEmailExistError = resEmailExistError;
        updateRegisterSuccess();
    }

    public boolean isResEmailError() {
        return resEmailError;
    }

    public void setResEmailError(boolean resEmailError) {
        this.resEmailError = resEmailError;
        updateRegisterSuccess();
    }

    public boolean isResPasswordError() {
        return resPasswordError;
    }

    public void setResPasswordError(boolean resPasswordError) {
        this.resPasswordError = resPasswordError;
        updateRegisterSuccess();
    }

    public boolean isRegisterSuccess() {
        return !isResUsernameError() && !isResUsernameExistError() && !isResPasswordError() && !isResEmailError() && !isResEmailExistError();
    }

    public void updateRegisterSuccess() {
        this.registerSuccess = isRegisterSuccess();
    }        
}
