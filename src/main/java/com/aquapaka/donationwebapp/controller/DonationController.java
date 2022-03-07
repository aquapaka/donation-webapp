package com.aquapaka.donationwebapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationService;
import com.aquapaka.donationwebapp.service.FilterService;
import com.aquapaka.donationwebapp.validator.status.DonateStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/donation")
public class DonationController {
    
    @Autowired
    private DonationService donationService;
    @Autowired
    private AppUserService appUserService;
    @Autowired
    private FilterService filterService;

    @GetMapping
    public List<Donation> getDonations() {

        return donationService.getDonations();
    }

    @PostMapping("/donate")
    public @ResponseBody DonateStatus donate(
    HttpServletRequest request,
    @RequestParam Long eventId,
    @RequestParam String donateAmount  
    ) {
        if(!filterService.canAccessUserData(request)) throw new IllegalStateException("Need to be an user!");

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);
        
        return donationService.addDonation(appUser, eventId, donateAmount);
    }
    

}
