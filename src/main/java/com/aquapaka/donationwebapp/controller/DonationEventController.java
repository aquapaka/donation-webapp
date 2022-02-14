package com.aquapaka.donationwebapp.controller;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.DonationEventService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("/DonationEvent/{id}")
    public @ResponseBody String getDonationEvent(@PathVariable long id) {
        Optional<DonationEvent> donationEventOptional = donationEventService.getDonationEventById(id);

        if(donationEventOptional.isPresent()) {
            String jsonResponse = "";
            ObjectMapper mapper = new ObjectMapper().findAndRegisterModules();

            try {
                jsonResponse = mapper.writeValueAsString(donationEventOptional.get());
            } catch (Exception e) {
                System.out.println(e);
                return "false";
            }

            return jsonResponse;
        } else {
            return "false";
        }
    }

    @DeleteMapping("/DonationEvent/{id}")
    public @ResponseBody String deleteDonationEvent(@PathVariable long id) {

        donationEventService.deleteDonationEventById(id);

        return "true";
    }

    @PutMapping("/DonationEvent/{id}")
    public @ResponseBody String updateDonationEvent(@PathVariable long id,
    @RequestParam String title,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam long total,
    @RequestParam String endTime
    ) {
        donationEventService.updateDonationEventInfoById(id, title, detail, image, total, endTime);
        
        return "true";
    }

    @PostMapping("/DonationEvent")
    public @ResponseBody String updateDonationEvent(
    @RequestParam String title,
    @RequestParam String detail,
    @RequestParam String image,
    @RequestParam long total,
    @RequestParam String startTime,
    @RequestParam String endTime
    ) {
        donationEventService.addDonationEvent(title, detail, image, total, startTime, endTime);
        
        return "true";
    }

}
