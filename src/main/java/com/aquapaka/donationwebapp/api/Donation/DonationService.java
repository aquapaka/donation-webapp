package com.aquapaka.donationwebapp.api.Donation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonationService {

    private DonationRepository donationEventRepository;
    
    @Autowired
    public DonationService(DonationRepository donationEventRepository) {
        this.donationEventRepository = donationEventRepository;
    }

    public List<Donation> getDonationEvents() {
        return donationEventRepository.findAll();
    }

    public void addNewDonationEvent(Donation donationEvent) {
        donationEventRepository.save(donationEvent);
    }
}
