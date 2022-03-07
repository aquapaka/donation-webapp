package com.aquapaka.donationwebapp.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class FilterService {
    private final String INDEX_REDIRECT = "redirect:/";
    private final String VALIDATE_EMAIL_REDIRECT = "redirect:/validateEmail";

    @Autowired
    private AppUserService appUserService;

    public String filterGuest(HttpServletRequest request, Model model, String mapping) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        String password = (String)session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if(appUser == null) return mapping;
        else if (appUser.getState() == AppUserState.INACTIVE) return VALIDATE_EMAIL_REDIRECT;

        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", true);
        
        return mapping;
    }

    public String filterUser(HttpServletRequest request, Model model, String mapping) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if (appUser == null)
            return INDEX_REDIRECT;
        else if (appUser.getState() == AppUserState.INACTIVE)
            return VALIDATE_EMAIL_REDIRECT;

        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", true);
        
        return mapping;
    }

    public String filterAdmin(HttpServletRequest request, Model model, String mapping) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if (appUser == null)
            return INDEX_REDIRECT;
        else if (appUser.getState() == AppUserState.INACTIVE)
            return VALIDATE_EMAIL_REDIRECT;
        else if (appUser.getRole() != Role.ADMIN) {
            return INDEX_REDIRECT;
        }

        model.addAttribute("appUser", appUser);
        model.addAttribute("isSignedIn", true);

        return mapping;
    }

    public boolean canAccessUserData(HttpServletRequest request) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if(appUser == null) return false;

        if(appUser.getState() != AppUserState.ACTIVE) return false;

        return true;
    }

    public boolean canAccessUserData(HttpServletRequest request, Long userId) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if(appUser == null) return false;
        if(appUser.getState() != AppUserState.ACTIVE) return false;
        if(appUser.getRole() == Role.ADMIN) return true;

        return (appUser.getAppUserId() == userId);
    }

    public boolean canAccessAdminData(HttpServletRequest request) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        AppUser appUser = appUserService.validateLogin(email, password);

        if(appUser == null) return false;

        return (appUser.getRole() == Role.ADMIN);
    }
}
