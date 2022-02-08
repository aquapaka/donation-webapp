package com.aquapaka.donationwebapp.controller;

import java.util.List;

import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.service.DonationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/donation")
public class DonationController {
    
    @Autowired
    private DonationService donationEventService;

    @GetMapping
    public List<Donation> getDonationEvents() {
        return donationEventService.getDonationEvents();
    }

    @PostMapping
    public void addDonationEvent(@RequestBody Donation donationEvent) {
        donationEventService.addNewDonationEvent(donationEvent);
    }
}
