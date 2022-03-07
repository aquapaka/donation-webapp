package com.aquapaka.donationwebapp.validator.status;

public class DonateStatus {
    private boolean donateAmountEmpty;
    private boolean donateAmountError;
    private boolean donateAmountTooSmall;
    
    public DonateStatus() {
    }

    public boolean isDonateAmountEmpty() {
        return donateAmountEmpty;
    }

    public void setDonateAmountEmpty(boolean donateAmountEmpty) {
        this.donateAmountEmpty = donateAmountEmpty;
    }

    public boolean isDonateAmountError() {
        return donateAmountError;
    }

    public void setDonateAmountError(boolean donateAmountError) {
        this.donateAmountError = donateAmountError;
    }

    public boolean isDonateAmountTooSmall() {
        return donateAmountTooSmall;
    }

    public void setDonateAmountTooSmall(boolean donateAmountTooSmall) {
        this.donateAmountTooSmall = donateAmountTooSmall;
    }

    public boolean isValidDonate() {
        return !isDonateAmountEmpty() && !isDonateAmountError() && !isDonateAmountTooSmall();
    }
}
