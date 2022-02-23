package com.aquapaka.donationwebapp.service;

import java.io.Console;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.state.EventState;
import com.aquapaka.donationwebapp.model.status.ValidateDonationEventStatus;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;
import com.aquapaka.donationwebapp.validator.DonationEventValidator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    @Autowired
    private DonationEventRepository donationEventRepository;
    @Autowired
    private DonationRepository donationRepository;

    public List<DonationEvent> getDonationEvents() {
        List<DonationEvent> donationEvents = donationEventRepository.findAll();

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEvents) {
            donationEvent.setTotalDonationCount(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEvents) {
            long currentDonationAmount = donationRepository
                    .sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }

        // Sort event list by progress percent
        donationEvents.sort(new Comparator<DonationEvent>() {
            @Override
            public int compare(DonationEvent d1, DonationEvent d2) {
                if (d1.getProgressPercent() < d2.getProgressPercent()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });

        return donationEvents;
    }

    public List<DonationEvent> getDonationEventsSearchBy(String searchText, String searchType) {
        List<DonationEvent> allDonationEvents = donationEventRepository.findAll();
        List<DonationEvent> donationEvents = new ArrayList<>();

        if (searchType.equals("title")) {
            for (DonationEvent donationEvent : allDonationEvents) {
                String title = Normalizer.normalize(donationEvent.getTitle().trim().toLowerCase(), Form.NFD);
                searchText = Normalizer.normalize(searchText.trim().toLowerCase(), Form.NFD);

                if (title.contains(searchText)) {
                    donationEvents.add(donationEvent);
                }
            }
            
        } else if (searchType.equals("id")) {
            for (DonationEvent donationEvent : allDonationEvents) {
                if (String.valueOf(donationEvent.getDonationEventId()).contains(searchText.trim())) {
                    donationEvents.add(donationEvent);
                }
            }
        } else {
            throw new IllegalStateException("Search Type not valid!");
        }

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEvents) {
            donationEvent.setTotalDonationCount(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEvents) {
            long currentDonationAmount = donationRepository
                    .sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }

        // Sort event list by progress percent
        donationEvents.sort(new Comparator<DonationEvent>() {
            @Override
            public int compare(DonationEvent d1, DonationEvent d2) {
                if (d1.getProgressPercent() < d2.getProgressPercent()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });

        return donationEvents;
    }

    public Optional<DonationEvent> getDonationEventById(long id) {
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);

        if (donationEventOptional.isPresent()) {
            donationEventOptional.get()
                    .setTotalDonationCount(donationRepository.countByDonationEvent(donationEventOptional.get()));
        }

        return donationEventOptional;
    }

    public ValidateDonationEventStatus addDonationEvent(String title, String description, String detail, String image,
            String total,
            String startTimeString, String endTimeString, AppUser createAppUser, EventState eventState) {

        // Validate all datas
        ValidateDonationEventStatus status = DonationEventValidator.validateDonationEvent(title, description, detail, image, total, startTimeString, endTimeString);

        // Return without add if there is an error
        if (!status.isValidDonationEvent()) return status;
        
        // Create donation event if there is no error
        long totalAmount = Long.parseLong(total);
        LocalDateTime startTime = LocalDateTime.parse(startTimeString);
        LocalDateTime endTime = LocalDateTime.parse(endTimeString);
        LocalDateTime createTime = LocalDateTime.now().truncatedTo(ChronoUnit.MINUTES);

        DonationEvent donationEvent = new DonationEvent(title, description, detail, image, totalAmount, startTime,
                endTime, createAppUser, createTime, eventState);

        // Save donation event into database
        donationEventRepository.save(donationEvent);

        return status;
    }

    public ValidateDonationEventStatus updateDonationEventInfoById(long id, String description, String title,
            String detail, String image,
            String total, String startTimeString, String endTimeString, EventState eventState) {
        // Get donation event
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);
        if (!donationEventOptional.isPresent()) throw new IllegalStateException("Update donation event id not found!");
        DonationEvent donationEvent = donationEventOptional.get();

        // Validate all fields
        ValidateDonationEventStatus status = DonationEventValidator.validateDonationEvent(title, description, detail, image, total, startTimeString, endTimeString);
        
        // Return without add if there is an error
        if (!status.isValidDonationEvent()) return status;

        // Update donation event info
        long totalAmount = Long.parseLong(total);
        LocalDateTime startTime = LocalDateTime.parse(startTimeString);
        LocalDateTime endTime = LocalDateTime.parse(endTimeString);
        
        donationEvent.setTitle(title);
        donationEvent.setDescription(description);
        donationEvent.setDetail(detail);
        donationEvent.setImage(image);
        donationEvent.setTotalDonationAmount(totalAmount);
        donationEvent.setStartTime(startTime);
        donationEvent.setEndTime(endTime);
        donationEvent.setEventState(eventState);

        // Save donation event
        donationEventRepository.save(donationEvent);

        return status;
    }

    public boolean deleteDonationEventById(long id) {
        if (donationEventRepository.findById(id).isPresent()) {
            donationEventRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    @Transactional
    public boolean deleteDonationEventsByIds(List<Long> ids) {

        for (long id : ids) {
            if (donationEventRepository.findById(id).isPresent()) {
                donationEventRepository.deleteById(id);
            } else {
                throw new DataIntegrityViolationException("Throwing exception for Rollback!!!");
            }
        }

        return true;
    }

}
