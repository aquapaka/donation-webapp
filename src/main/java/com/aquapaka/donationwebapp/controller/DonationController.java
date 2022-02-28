package com.aquapaka.donationwebapp.controller;

import java.util.List;

import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.service.DonationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "donation")
public class DonationController {
    
    @Autowired
    private DonationService donationEventService;

    @GetMapping
    public List<Donation> getDonations() {

        return donationEventService.getDonations();
    }

}
