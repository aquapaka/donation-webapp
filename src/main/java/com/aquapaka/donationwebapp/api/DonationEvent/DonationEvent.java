package com.aquapaka.donationwebapp.api.DonationEvent;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class DonationEvent {
    @Id
    @GeneratedValue(
        strategy = GenerationType.AUTO
    )
    @Column(name = "donation_event_id")
    private Long donationEventId;
    private String title;
    private String detail;
    private String images;
    private double totalDonationAmount;
    private double currentDonationAmount;
    private LocalDate startTime;
    private LocalDate endTime;

    public DonationEvent(String title, String detail, String images, double totalDonationAmount,
            double currentDonationAmount, LocalDate startTime, LocalDate endTime) {
        this.title = title;
        this.detail = detail;
        this.images = images;
        this.totalDonationAmount = totalDonationAmount;
        this.currentDonationAmount = currentDonationAmount;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Long getDonationEventId() {
        return donationEventId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public double getTotalDonationAmount() {
        return totalDonationAmount;
    }

    public void setTotalDonationAmount(double totalDonationAmount) {
        this.totalDonationAmount = totalDonationAmount;
    }

    public double getCurrentDonationAmount() {
        return currentDonationAmount;
    }

    public void setCurrentDonationAmount(double currentDonationAmount) {
        this.currentDonationAmount = currentDonationAmount;
    }

    public LocalDate getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDate startTime) {
        this.startTime = startTime;
    }

    public LocalDate getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDate endTime) {
        this.endTime = endTime;
    }

}
