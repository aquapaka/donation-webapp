package com.aquapaka.donationwebapp.service;

import java.util.List;

import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.repository.DonationRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonationService {

    @Autowired
    private DonationRepository donationRepository;

    public List<Donation> getDonations() {
        return donationRepository.findAll();
    }

}
