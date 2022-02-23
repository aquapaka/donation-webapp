package com.aquapaka.donationwebapp.validator;

import java.time.LocalDateTime;

import com.aquapaka.donationwebapp.validator.status.ValidateDonationEventStatus;

public class DonationEventValidator {

    private DonationEventValidator() {
        throw new IllegalStateException("Utility class");
    }

    public static ValidateDonationEventStatus validateDonationEvent(String title, String description, String detail,
    String image,
    String total,
    String startTimeString, String endTimeString) {

        // Validate all fields
        ValidateDonationEventStatus status = new ValidateDonationEventStatus();

        if (title.trim().isEmpty())
            status.setTitleEmpty(true);
        if (description.trim().isEmpty())
            status.setDescriptionEmpty(true);
        if (detail.trim().isEmpty())
            status.setDetailEmpty(true);
        if (image.trim().isEmpty())
            status.setImageEmpty(true);

        // Validate total amount
        long totalAmount = 0;
        if (total.trim().isEmpty()) {
            status.setTotalDonationAmountEmpty(true);
        } else {
            try {
                totalAmount = Long.parseLong(total);
            } catch (Exception e) {
                status.setTotalDonationAmountError(true);
            }
        }
        if (totalAmount <= 0)
            status.setTotalDonationAmountError(true);

        // Validate start time and end time
        LocalDateTime startTime = LocalDateTime.now();
        LocalDateTime endTime = LocalDateTime.now();
        try {
            startTime = LocalDateTime.parse(startTimeString);
            endTime = LocalDateTime.parse(endTimeString);
        } catch (Exception e) {
            status.setDateNotValid(true);
        }
        if (!endTime.isAfter(startTime))
            status.setEndDateSmallerThanStartDate(true);
        
        return status;
    }
}
