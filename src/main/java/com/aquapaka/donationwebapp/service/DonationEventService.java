package com.aquapaka.donationwebapp.service;

import java.util.Comparator;
import java.util.List;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    @Autowired
    private DonationEventRepository donationEventRepository;

    public List<DonationEvent> getDonationEvents() {
        List<DonationEvent> donationEvents = donationEventRepository.findAll();
        
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

    public void addNewDonationEvent(DonationEvent donationEvent) {
        donationEventRepository.save(donationEvent);
    }
}
