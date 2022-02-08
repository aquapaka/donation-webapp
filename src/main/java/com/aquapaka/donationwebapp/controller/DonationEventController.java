package com.aquapaka.donationwebapp.controller;

import java.util.List;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.service.DonationEventService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "donationEvent")
public class DonationEventController {
    
    @Autowired
    private DonationEventService donationEventService;

    @GetMapping
    public List<DonationEvent> getDonationEvents() {
        return donationEventService.getDonationEvents();
    }

    @PostMapping
    public void addDonationEvent(@RequestBody DonationEvent donationEvent) {
        donationEventService.addNewDonationEvent(donationEvent);
    }
}
