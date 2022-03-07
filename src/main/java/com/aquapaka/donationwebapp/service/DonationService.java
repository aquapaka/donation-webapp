package com.aquapaka.donationwebapp.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Optional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;
import com.aquapaka.donationwebapp.validator.status.DonateStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class DonationService {
    public static final long MIN_DONATION_AMOUNT = 50000;
    private static final int DONATION_PER_PAGE = 10;

    @Autowired
    private DonationRepository donationRepository;
    @Autowired
    private DonationEventRepository donationEventRepository;

    public Page<Donation> getDonations(int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        Pageable pageable = PageRequest.of(page, DONATION_PER_PAGE);

        Page<Donation> donations = donationRepository.findAll(pageable);

        return donations;
    }

    public Page<Donation> searchDonations(String searchText, String searchType, String sortType, int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        
        Pageable pageable = PageRequest.of(page, DONATION_PER_PAGE, Sort.by(sortType));
        Page<Donation> DonationsPage;

        switch(searchType) {
            case "donationEventTitle":
                DonationsPage = donationRepository.findAllByDonationEventTitleContainsIgnoreCase(searchText, pageable);
                break;
            case "donationEventId":
                try {
                    Long.parseLong(searchText);
                } catch (Exception e) {
                    searchText = "-1";
                }
                DonationsPage = donationRepository.findAllByDonationEventDonationEventId(Long.parseLong(searchText), pageable);
                break;
            case "appUserUsername":
                DonationsPage = donationRepository.findAllByAppUserUsernameContainsIgnoreCase(searchText, pageable);
                break;
            case "appUserId":
                try {
                    Long.parseLong(searchText);
                } catch (Exception e) {
                    searchText = "-1";
                }
                DonationsPage = donationRepository.findAllByAppUserAppUserId(Long.parseLong(searchText), pageable);
                break;
            default:
                throw new IllegalStateException("Search type not valid!");
        }

        return DonationsPage;
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
