package com.aquapaka.donationwebapp.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;
import com.aquapaka.donationwebapp.validator.status.DonateStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

@Service
public class DonationService {
    public static final long MIN_DONATION_AMOUNT = 50000;

    @Autowired
    private DonationRepository donationRepository;
    @Autowired
    private DonationEventRepository donationEventRepository;

    public List<Donation> getDonations() {
        return donationRepository.findAll();
    }

    public DonateStatus addDonation(AppUser appUser, Long eventId, String donationAmountString) {
        DonateStatus status = new DonateStatus();

        // Validate donationAmount
        long donationAmount = 0;
        if (donationAmountString.trim().isEmpty()) {
            status.setDonateAmountEmpty(true);
        } else {
            try {
                donationAmount = Long.parseLong(donationAmountString);
            } catch (Exception e) {
                status.setDonateAmountError(true);
            }
        }
        if(donationAmount < MIN_DONATION_AMOUNT) status.setDonateAmountTooSmall(true);

        if(!status.isValidDonate()) return status;

        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(eventId);
        if(!donationEventOptional.isPresent()) throw new IllegalStateException("Event id not found!");

        Donation donation = new Donation(appUser, donationEventOptional.get(), LocalDateTime.now().truncatedTo(ChronoUnit.SECONDS), donationAmount);
        donationRepository.save(donation);

        return status;
    }
}
