package com.aquapaka.donationwebapp.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.state.EventState;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;
import com.aquapaka.donationwebapp.validator.DonationEventValidator;
import com.aquapaka.donationwebapp.validator.status.ValidateDonationEventStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    private static final int EVENT_PER_PAGE = 6;

    @Autowired
    private DonationEventRepository donationEventRepository;
    @Autowired
    private DonationRepository donationRepository;

    public Page<DonationEvent> getDonationEvents(int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        Pageable pageable = PageRequest.of(page, EVENT_PER_PAGE);

        Page<DonationEvent> donationEvents = donationEventRepository.findAll(pageable);

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

        return donationEvents;
    }

    public Optional<DonationEvent> getDonationEventById(long id) {
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);

        if (donationEventOptional.isPresent()) {
            donationEventOptional.get().setTotalDonationCount(donationRepository.countByDonationEvent(donationEventOptional.get()));
            long currentDonationAmount = donationRepository
                    .sumDonationAmountByDonationEventId(donationEventOptional.get().getDonationEventId());
            donationEventOptional.get().setCurrentDonationAmount(currentDonationAmount);
        }

        return donationEventOptional;
    }

    public Page<DonationEvent> searchDonationEvents(String searchText, String searchType, String sortType, int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        
        Pageable pageable = PageRequest.of(page, EVENT_PER_PAGE, Sort.by(sortType));
        Page<DonationEvent> donationEventPage;

        switch(searchType) {
            case "title":
                donationEventPage = donationEventRepository.findAllByTitleContainsIgnoreCase(searchText, pageable);
                break;
            case "description":
                donationEventPage = donationEventRepository.findAllByDescriptionContainsIgnoreCase(searchText, pageable);
                break;
            default:
                throw new IllegalStateException("Search type not valid!");
        }

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEventPage) {
            donationEvent.setTotalDonationCount(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEventPage) {
            long currentDonationAmount = donationRepository
                    .sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }

        return donationEventPage;
    }

    public Page<DonationEvent> searchDonationEvents(String searchText, String searchType, String sortType, int page, EventState state) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        
        Pageable pageable = PageRequest.of(page, EVENT_PER_PAGE, Sort.by(sortType));
        Page<DonationEvent> donationEventPage;

        switch(searchType) {
            case "title":
                donationEventPage = donationEventRepository.findAllByTitleContainsIgnoreCaseAndEventState(searchText, state, pageable);
                break;
            case "description":
                donationEventPage = donationEventRepository.findAllByDescriptionContainsIgnoreCaseAndEventState(searchText, state, pageable);
                break;
            default:
                throw new IllegalStateException("Search type not valid!");
        }

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEventPage) {
            donationEvent.setTotalDonationCount(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEventPage) {
            long currentDonationAmount = donationRepository
                    .sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }

        return donationEventPage;
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
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);

        if (donationEventOptional.isPresent()) {
            // Not delete if there is already donation in event
            if(donationRepository.countByDonationEvent(donationEventOptional.get()) > 0) {
                return false;
            }

            donationEventRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    @Transactional
    public boolean deleteDonationEventsByIds(List<Long> ids) {

        for (long id : ids) {
            Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);

            if (donationEventOptional.isPresent()) {
                // Not delete if there is already donation in event
                if (donationRepository.countByDonationEvent(donationEventOptional.get()) > 0) {
                    throw new DataIntegrityViolationException("Throwing exception for Rollback!!!");
                }

                donationEventRepository.deleteById(id);
            } else {
                throw new DataIntegrityViolationException("Throwing exception for Rollback!!!");
            }
        }

        return true;
    }

}
