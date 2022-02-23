package com.aquapaka.donationwebapp.validator.status;

public class RegisterStatus {
    private boolean resUsernameExistError;
    private boolean resUsernameError;
    private boolean resEmailExistError;
    private boolean resEmailError;
    private boolean resPasswordError;

    public RegisterStatus() {
    }

    public boolean isResUsernameExistError() {
        return resUsernameExistError;
    }

    public void setResUsernameExistError(boolean resUsernameExistError) {
        this.resUsernameExistError = resUsernameExistError;
    }

    public boolean isResUsernameError() {
        return resUsernameError;
    }

    public void setResUsernameError(boolean resUsernameError) {
        this.resUsernameError = resUsernameError;
    }

    public boolean isResEmailExistError() {
        return resEmailExistError;
    }

    public void setResEmailExistError(boolean resEmailExistError) {
        this.resEmailExistError = resEmailExistError;
    }

    public boolean isResEmailError() {
        return resEmailError;
    }

    public void setResEmailError(boolean resEmailError) {
        this.resEmailError = resEmailError;
    }

    public boolean isResPasswordError() {
        return resPasswordError;
    }

    public void setResPasswordError(boolean resPasswordError) {
        this.resPasswordError = resPasswordError;
    }

    public boolean isRegisterSuccess() {
        return !isResUsernameError() && !isResUsernameExistError() && !isResPasswordError() && !isResEmailError() && !isResEmailExistError();
    }        
}
