package com.aquapaka.donationwebapp.model;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
    private long totalDonationAmount;
    private long currentDonationAmount;
    private LocalDate startTime;
    private LocalDate endTime;
    @Transient
    private long daysLeft;
    @Transient
    private long progressPercent;
    @Transient
    private boolean isCompleted;
    @Transient
    private boolean isEnded;

    public DonationEvent() {
        
    }

    public DonationEvent(String title, String detail, String images, long totalDonationAmount,
            long currentDonationAmount, LocalDate startTime, LocalDate endTime) {
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

    public long getTotalDonationAmount() {
        return totalDonationAmount;
    }

    public void setTotalDonationAmount(long totalDonationAmount) {
        this.totalDonationAmount = totalDonationAmount;
    }

    public long getCurrentDonationAmount() {
        return currentDonationAmount;
    }

    public void setCurrentDonationAmount(long currentDonationAmount) {
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

    public long getDaysLeft() {
        daysLeft = ChronoUnit.DAYS.between(startTime, endTime);
        if(daysLeft <= 0) {
            daysLeft = 0;
        }

        return daysLeft;
    }

    public long getProgressPercent() {
        return (long)((double)currentDonationAmount / totalDonationAmount * 100);
    }

    public boolean getIsCompleted() {
        return currentDonationAmount >= totalDonationAmount;
    }

    public boolean getIsEnded() {
        return getDaysLeft() <= 0;
    }

    @Override
    public String toString() {
        return "DonationEvent [currentDonationAmount=" + currentDonationAmount + ", detail=" + detail
                + ", donationEventId=" + donationEventId + ", endTime=" + endTime + ", images=" + images
                + ", startTime=" + startTime + ", title=" + title + ", totalDonationAmount=" + totalDonationAmount + ", daysLeft=" + daysLeft
                + "]";
    }
    
}
