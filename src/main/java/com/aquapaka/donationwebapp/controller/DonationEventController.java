package com.aquapaka.donationwebapp.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.state.EventState;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.aquapaka.donationwebapp.service.DonationService;
import com.aquapaka.donationwebapp.service.FilterService;
import com.aquapaka.donationwebapp.validator.status.ValidateDonationEventStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DonationEventController {

    @Autowired
    private DonationEventService donationEventService;
    @Autowired
    private AppUserService appUserService;
    @Autowired
    private FilterService filterService;

    @GetMapping("/donation-event")
    public String donationEvent(Model model, HttpServletRequest request, @RequestParam Long id) {
        // Get donation event data
        Optional<DonationEvent> donationEventOptional = donationEventService.getDonationEventById(id);
        DonationEvent donationEvent;
        if (donationEventOptional.isPresent())
            donationEvent = donationEventOptional.get();
        else
            throw new IllegalStateException("Donation event id not found!");

        model.addAttribute("donationEvent", donationEvent);
        model.addAttribute("eventId", id);
        model.addAttribute("minAmount", DonationService.MIN_DONATION_AMOUNT);

        return filterService.filterGuest(request, model, "donationEvent");
    }

    @GetMapping("/DonationEvent/{id}")
    public @ResponseBody DonationEvent getDonationEvent(@PathVariable long id) {
        Optional<DonationEvent> donationEventOptional = donationEventService.getDonationEventById(id);

        if (donationEventOptional.isPresent()) {
            return donationEventOptional.get();
        } else {
            return null;
        }
    }

    @PostMapping("/DonationEvent")
    public @ResponseBody ValidateDonationEventStatus addDonationEvent(
    @RequestParam String title,
    @RequestParam String description,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam String total,
    @RequestParam String startTime,
    @RequestParam String endTime,
    @RequestParam String eventState,
    HttpServletRequest request) {
        
        if(!filterService.canAccessAdminData(request)) throw new IllegalStateException("Can't access is data!");

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        // Parse event state
        EventState state;
        if (eventState.equals(EventState.ACTIVE.name()))
            state = EventState.ACTIVE;
        else if (eventState.equals(EventState.INACTIVE.name()))
            state = EventState.INACTIVE;
        else
            throw new IllegalStateException("Event state not valid!");

        return donationEventService.addDonationEvent(title, description, detail, image, total, startTime, endTime,
                appUser, state);
    }

    @PutMapping("/DonationEvent/{id}")
    public @ResponseBody ValidateDonationEventStatus updateDonationEvent(@PathVariable long id,
    @RequestParam String title,
    @RequestParam String description,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam String total,
    @RequestParam String startTime,
    @RequestParam String endTime,
    @RequestParam String eventState,
    HttpServletRequest request) {

        if(!filterService.canAccessAdminData(request)) throw new IllegalStateException("Can't access is data!");

        // Parse event state
        EventState state;
        if (eventState.equals(EventState.ACTIVE.name()))
            state = EventState.ACTIVE;
        else if (eventState.equals(EventState.INACTIVE.name()))
            state = EventState.INACTIVE;
        else
            throw new IllegalStateException("Event state not valid!");

        return donationEventService.updateDonationEventInfoById(id, description, title, detail, image, total, startTime,
                endTime, state);
    }

    @DeleteMapping("/DonationEvent/{id}")
    public ResponseEntity<Long> deleteDonationEvent(@PathVariable Long id, HttpServletRequest request) {

        if(!filterService.canAccessAdminData(request)) throw new IllegalStateException("Can't access is data!");

        boolean isDeleted = donationEventService.deleteDonationEventById(id);

        if (!isDeleted) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(id, HttpStatus.OK);

    }

    @DeleteMapping("/DonationEvent")
    public ResponseEntity<Long> deleteDonationEvents(@RequestParam List<Long> ids, HttpServletRequest request) {

        if(!filterService.canAccessAdminData(request)) throw new IllegalStateException("Can't access is data!");

        boolean deleteSuccess = donationEventService.deleteDonationEventsByIds(ids);

        if (!deleteSuccess) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(0L, HttpStatus.OK);
    }
}
