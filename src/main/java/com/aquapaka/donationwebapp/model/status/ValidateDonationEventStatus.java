package com.aquapaka.donationwebapp.model.status;

public class ValidateDonationEventStatus {
    private boolean titleEmpty;
    private boolean totalDonationAmountEmpty;
    private boolean totalDonationAmountError;
    private boolean detailEmpty;
    private boolean imageEmpty;
    private boolean dateNotValid;
    private boolean endDateSmallerThanStartDate;

    public ValidateDonationEventStatus() {
    }

    public boolean isTotalDonationAmountError() {
        return totalDonationAmountError;
    }

    public void setTotalDonationAmountError(boolean totalDonationAmountError) {
        this.totalDonationAmountError = totalDonationAmountError;
    }

    public boolean isTitleEmpty() {
        return titleEmpty;
    }

    public void setTitleEmpty(boolean titleEmpty) {
        this.titleEmpty = titleEmpty;
    }

    public boolean isTotalDonationAmountEmpty() {
        return totalDonationAmountEmpty;
    }

    public void setTotalDonationAmountEmpty(boolean totalDonationAmountEmpty) {
        this.totalDonationAmountEmpty = totalDonationAmountEmpty;
    }

    public boolean isDetailEmpty() {
        return detailEmpty;
    }

    public void setDetailEmpty(boolean detailEmpty) {
        this.detailEmpty = detailEmpty;
    }

    public boolean isImageEmpty() {
        return imageEmpty;
    }

    public void setImageEmpty(boolean imageEmpty) {
        this.imageEmpty = imageEmpty;
    }

    public boolean isEndDateSmallerThanStartDate() {
        return endDateSmallerThanStartDate;
    }

    public void setEndDateSmallerThanStartDate(boolean endDateSmallerThanStartDate) {
        this.endDateSmallerThanStartDate = endDateSmallerThanStartDate;
    }

    public boolean isDateNotValid() {
        return dateNotValid;
    }

    public void setDateNotValid(boolean dateNotValid) {
        this.dateNotValid = dateNotValid;
    }

    public boolean isValidDonationEvent() {
        return !isDetailEmpty() && !isEndDateSmallerThanStartDate() && !isImageEmpty() && !isTitleEmpty() && !isTotalDonationAmountEmpty() && !isTotalDonationAmountError() && !isDateNotValid();
    }
}
