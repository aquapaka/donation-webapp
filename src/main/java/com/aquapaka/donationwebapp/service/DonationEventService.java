package com.aquapaka.donationwebapp.service;

import java.util.Comparator;
import java.util.List;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    @Autowired
    private DonationEventRepository donationEventRepository;
    @Autowired
    private DonationRepository donationRepository;

    public List<DonationEvent> getDonationEvents() {
        List<DonationEvent> donationEvents = donationEventRepository.findAll();

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEvents) {
            donationEvent.setTotalDonation(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEvents) {
            long currentDonationAmount = donationRepository.sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }
        
        // Sort event list by progress percent
        donationEvents.sort(new Comparator<DonationEvent>() {
            @Override
            public int compare(DonationEvent d1, DonationEvent d2) {
                if(d1.getProgressPercent() < d2.getProgressPercent()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });

        return donationEvents;
    }

    public DonationEvent getDonationEventById(long id) {
        DonationEvent donationEvent = donationEventRepository.getById(id);
        donationEvent.setTotalDonation(donationRepository.countByDonationEvent(donationEvent));
        return donationEvent;
    }
}
