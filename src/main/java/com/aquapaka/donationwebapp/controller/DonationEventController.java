package com.aquapaka.donationwebapp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(path = "donationEvent")
public class DonationEventController {
    
    @Autowired
    private DonationEventService donationEventService;
    @Autowired
    private AppUserService appUserService;

    @GetMapping
    public String donationEvent(Model model, HttpServletRequest request, @RequestParam String id) {
        // Get donation event data
        DonationEvent donationEvent;
        try {
            donationEvent = donationEventService.getDonationEventById(Long.parseLong(id));
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

}
