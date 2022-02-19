package com.aquapaka.donationwebapp.model;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.aquapaka.donationwebapp.model.state.EventState;

@Entity
@Table
public class DonationEvent {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "donation_event_id")
    private Long donationEventId;
    private String title;
    private String description;
    private String detail;
    private String images;
    private long totalDonationAmount;
    @Transient
    private long currentDonationAmount;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    @OneToOne
    @JoinColumn(name = "app_user_id", referencedColumnName = "app_user_id")
    private AppUser createAppUser;
    private LocalDateTime createTime;
    private EventState eventState;
    @Transient
    private long daysLeft;
    @Transient
    private float progressPercent;
    @Transient
    private boolean isCompleted;
    @Transient
    private boolean isEnded;
    @Transient
    private int totalDonationCount;

    public DonationEvent() {

    }

    public DonationEvent(String title, String description, String detail, String images, long totalDonationAmount,
            LocalDateTime startTime, LocalDateTime endTime, AppUser createAppUser, LocalDateTime createTime,
            EventState eventState) {
        this.title = title;
        this.description = description;
        this.detail = detail;
        this.images = images;
        this.totalDonationAmount = totalDonationAmount;
        this.startTime = startTime;
        this.endTime = endTime;
        this.createAppUser = createAppUser;
        this.createTime = createTime;
        this.eventState = eventState;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public AppUser getCreateAppUser() {
        return createAppUser;
    }

    public void setCreateAppUser(AppUser createAppUser) {
        this.createAppUser = createAppUser;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public EventState getEventState() {
        return eventState;
    }

    public void setEventState(EventState eventState) {
        this.eventState = eventState;
    }

    public long getDaysLeft() {
        daysLeft = ChronoUnit.DAYS.between(startTime, endTime);
        if (daysLeft <= 0) {
            daysLeft = 0;
        }

        return daysLeft;
    }

    public long getProgressPercent() {
        return (long) ((double) currentDonationAmount / totalDonationAmount * 100);
    }

    public boolean getIsCompleted() {
        return currentDonationAmount >= totalDonationAmount;
    }

    public boolean getIsEnded() {
        return getDaysLeft() <= 0;
    }

    public int getTotalDonationCount() {
        return totalDonationCount;
    }

    public void setTotalDonationCount(int totalDonationCount) {
        this.totalDonationCount = totalDonationCount;
    }
}
