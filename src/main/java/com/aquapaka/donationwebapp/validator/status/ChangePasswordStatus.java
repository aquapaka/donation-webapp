package com.aquapaka.donationwebapp.validator.status;

public class ChangePasswordStatus {
    private boolean oldPasswordError;
    private boolean newPasswordError;

    public ChangePasswordStatus() {
    }

    public boolean isOldPasswordError() {
        return oldPasswordError;
    }

    public void setOldPasswordError(boolean oldPasswordError) {
        this.oldPasswordError = oldPasswordError;
    }

    public boolean isNewPasswordError() {
        return newPasswordError;
    }

    public void setNewPasswordError(boolean newPasswordError) {
        this.newPasswordError = newPasswordError;
    }

    public boolean isChangePasswordSuccess() {
        return !isOldPasswordError() && !isNewPasswordError();
    }
}
