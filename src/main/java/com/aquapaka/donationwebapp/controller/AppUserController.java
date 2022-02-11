package com.aquapaka.donationwebapp.controller;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.status.RegisterStatus;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AppUserController {
    
    @Autowired
    private AppUserService appUserService;

    @PostMapping("/doLogin")
    public @ResponseBody String doLogin(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AppUser appUser = appUserService.validateAppUser(email, password);
        if(appUser == null) {
            return "false";
        }

        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        
        return "true";
    }

    @PostMapping("/doRegister")
    public @ResponseBody String doRegister(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        RegisterStatus registerStatus = appUserService.registerAppUser(username, email, password);

        // Map register status object into json string
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(registerStatus);
        } catch (Exception e) {
            System.out.println(e);
        }

        if(registerStatus.isRegisterSuccess()) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("password", password);
        }
        
        return json;
    }

    @GetMapping("/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.setAttribute("email", null);
        session.setAttribute("password", null);

        return "redirect:/";
    }

    @GetMapping("/AppUser/{id}")
    public @ResponseBody String getAppUser(@PathVariable long id) {
        Optional<AppUser> appUserOptional = appUserService.getAppUserById(id);

        if(appUserOptional.isPresent()) {
            String jsonResponse = "";
            ObjectMapper mapper = new ObjectMapper().findAndRegisterModules();

            try {
                jsonResponse = mapper.writeValueAsString(appUserOptional.get());
            } catch (Exception e) {
                System.out.println(e);
                return "false";
            }

            return jsonResponse;
        } else {
            return "false";
        }
    }

    @DeleteMapping("/AppUser/{id}")
    public @ResponseBody String deleteAppUser(@PathVariable long id) {

        appUserService.deleteAppUserById(id);
        
        return "true";
    }
}
