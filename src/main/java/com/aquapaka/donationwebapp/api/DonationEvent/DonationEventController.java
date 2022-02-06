package com.aquapaka.donationwebapp.api.DonationEvent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/donationEvent")
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
