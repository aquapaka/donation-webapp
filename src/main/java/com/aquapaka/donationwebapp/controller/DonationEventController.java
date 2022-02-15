package com.aquapaka.donationwebapp.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.status.ValidateDonationEventStatus;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;

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

    @GetMapping("/donationEvent")
    public String donationEvent(Model model, HttpServletRequest request, @RequestParam String id) {
        // Get donation event data
        DonationEvent donationEvent;
        try {
            donationEvent = donationEventService.getDonationEventById(Long.parseLong(id)).get();
        } catch (Exception e) {
            return "redirect:/";
        }
        
        model.addAttribute("donationEvent", donationEvent);

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        String password = (String)session.getAttribute("password");
        AppUser appUser = appUserService.validateAppUser(email, password);
        boolean isSignedIn = false;

        if(appUser != null) {
            isSignedIn = true;
        }
        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", isSignedIn);
        
        return "donationEvent";
    }
    
    /**
     * RestAPI
     * v
     */

    @GetMapping("/DonationEvent/{id}")
    public @ResponseBody DonationEvent getDonationEvent(@PathVariable long id) {
        Optional<DonationEvent> donationEventOptional = donationEventService.getDonationEventById(id);

        if(donationEventOptional.isPresent()) {
            return donationEventOptional.get();
        } else {
            return null;
        }
    }

    @DeleteMapping("/DonationEvent/{id}")
    public ResponseEntity<Long> deleteDonationEvent(@PathVariable Long id) {

        boolean isDeleted = donationEventService.deleteDonationEventById(id);

        if (!isDeleted) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(id, HttpStatus.OK);

    }

    @DeleteMapping("/DonationEvent")
    public ResponseEntity<Long> deleteDonationEvents(@RequestParam List<Long> ids) {
        boolean deleteSuccess = donationEventService.deleteDonationEventsByIds(ids);

        if (!deleteSuccess) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(0L, HttpStatus.OK);
    }

    @PutMapping("/DonationEvent/{id}")
    public @ResponseBody ValidateDonationEventStatus updateDonationEvent(@PathVariable long id,
    @RequestParam String title,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam String total,
    @RequestParam String endTime
    ) {
        ValidateDonationEventStatus status = donationEventService.updateDonationEventInfoById(id, title, detail, image, total, endTime);
        
        return status;
    }

    @PostMapping("/DonationEvent")
    public @ResponseBody ValidateDonationEventStatus addDonationEvent(
    @RequestParam String title,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam String total,
    @RequestParam String startTime,
    @RequestParam String endTime
    ) {
        ValidateDonationEventStatus status = donationEventService.addDonationEvent(title, detail, image, total, startTime, endTime);
        
        return status;
    }

}
