package com.aquapaka.donationwebapp.api.DonationEvent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    private DonationEventRepository donationEventRepository;
    
    @Autowired
    public DonationEventService(DonationEventRepository donationEventRepository) {
        this.donationEventRepository = donationEventRepository;
    }

    public List<DonationEvent> getDonationEvents() {
        return donationEventRepository.findAll();
    }

    public void addNewDonationEvent(DonationEvent donationEvent) {
        donationEventRepository.save(donationEvent);
    }
}
