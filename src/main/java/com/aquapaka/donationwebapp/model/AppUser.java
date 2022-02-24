package com.aquapaka.donationwebapp.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Gender;
import com.aquapaka.donationwebapp.model.state.Role;

@Entity
@Table
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "app_user_id")
    private Long appUserId;
    @Column(unique = true)
    private String email;
    private String password;
    @Column(unique = true)
    private String username;
    private String fullname;
    private LocalDate dateOfBirth;
    private Gender gender;
    private String phoneNumber;
    private Role role;
    private AppUserState state;
    private int activeCode;

    public AppUser() {
        
    }
    
    public AppUser(String email, String password, String username, String fullname, LocalDate dateOfBirth, Gender gender,
            String phoneNumber, Role role, AppUserState state, int activeCode) {
        this.email = email;
        this.password = password;
        this.username = username;
        this.fullname = fullname;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.state = state;
        this.activeCode = activeCode;
    }

    public Long getAppUserId() {
        return appUserId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public AppUserState getState() {
        return state;
    }

    public void setState(AppUserState state) {
        this.state = state;
    }

    public int getActiveCode() {
        return activeCode;
    }

    public void setActiveCode(int activeCode) {
        this.activeCode = activeCode;
    }

}
