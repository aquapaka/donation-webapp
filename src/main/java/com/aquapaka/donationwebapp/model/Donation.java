package com.aquapaka.donationwebapp.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table
public class Donation {
    @Id
    @SequenceGenerator(
        name = "donation_sequence",
        sequenceName = "donation_sequence",
        allocationSize = 1
    )
    @GeneratedValue(
        strategy = GenerationType.SEQUENCE,
        generator = "donation_sequence"
    )
    @Column(nullable = false, unique = true)
    private Long donationId;
    @OneToOne
    @JoinColumn(name = "app_user_id", referencedColumnName = "app_user_id")
    private AppUser appUser;
    @OneToOne
    @JoinColumn(name = "donation_event_id", referencedColumnName = "donation_event_id")
    private DonationEvent donationEvent;
    @Column(nullable = false)
    private LocalDateTime donationTime;
    @Column(nullable = false)
    private Long donationAmount;

    public Donation() {
        
    }
    
    public Donation(AppUser appUser, DonationEvent donationEvent, LocalDateTime donationTime, Long donationAmount) {
        this.appUser = appUser;
        this.donationEvent = donationEvent;
        this.donationTime = donationTime;
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

    public LocalDateTime getDonationTime() {
        return donationTime;
    }

    public void setDonationTime(LocalDateTime donationTime) {
        this.donationTime = donationTime;
    }

    public Long getDonationAmount() {
        return donationAmount;
    }

    public void setDonationAmount(Long donationAmount) {
        this.donationAmount = donationAmount;
    }

    
}
