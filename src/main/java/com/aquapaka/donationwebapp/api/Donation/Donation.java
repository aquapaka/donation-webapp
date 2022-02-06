package com.aquapaka.donationwebapp.api.Donation;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.aquapaka.donationwebapp.api.AppUser.AppUser;
import com.aquapaka.donationwebapp.api.DonationEvent.DonationEvent;

@Entity
@Table
public class Donation {
    @Id
    @GeneratedValue(
        strategy = GenerationType.AUTO
    )
    private Long donationId;
    @OneToOne
    @JoinColumn(name = "app_user_id", referencedColumnName = "app_user_id")
    private AppUser appUser;
    @OneToOne
    @JoinColumn(name = "donation_event_id", referencedColumnName = "donation_event_id")
    private DonationEvent donationEvent;
    private LocalDate date;
    private Long donationAmount;
    
    public Donation(AppUser appUser, DonationEvent donationEvent, LocalDate date, Long donationAmount) {
        this.appUser = appUser;
        this.donationEvent = donationEvent;
        this.date = date;
        this.donationAmount = donationAmount;
    }

    public Long getDonationId() {
        return donationId;
    }

    public AppUser getAppUser() {
        return appUser;
    }

    public void setAppUser(AppUser appUser) {
        this.appUser = appUser;
    }

    public DonationEvent getDonationEvent() {
        return donationEvent;
    }

    public void setDonationEvent(DonationEvent donationEvent) {
        this.donationEvent = donationEvent;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Long getDonationAmount() {
        return donationAmount;
    }

    public void setDonationAmount(Long donationAmount) {
        this.donationAmount = donationAmount;
    }

    
}
