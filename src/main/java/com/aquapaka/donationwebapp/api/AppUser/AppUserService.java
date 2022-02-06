package com.aquapaka.donationwebapp.api.AppUser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppUserService {
    
    @Autowired
    private AppUserRepository appUserRepository;

    public List<AppUser> getAppUsers() {
        return appUserRepository.findAll();
    }
}
