package com.aquapaka.donationwebapp.service;

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
        return donationEventRepository.findAll();
    }

    public void addNewDonationEvent(DonationEvent donationEvent) {
        donationEventRepository.save(donationEvent);
    }
}
