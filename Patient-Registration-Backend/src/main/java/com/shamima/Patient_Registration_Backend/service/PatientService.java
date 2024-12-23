package com.shamima.Patient_Registration_Backend.service;

import com.shamima.Patient_Registration_Backend.entity.Patient;
import com.shamima.Patient_Registration_Backend.repository.PatientRepository;
import com.shamima.Patient_Registration_Backend.util.ApiResponse;
import com.shamima.Patient_Registration_Backend.util.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    public ApiResponse getAllPatients() {
        ApiResponse response = new ApiResponse();
        try {
            List<Patient> patients = patientRepository.findAll();
            response.setData("patients", patients);
            response.setSuccessful(true);
            response.setMessage("Successfully retrieved patients");
        } catch (Exception e) {
            response.setMessage(e.getMessage());
            return response.error(e.getMessage());
        }
        return response;
    }

    public ApiResponse savePatient(Patient patient, MultipartFile imageFile) {
        ApiResponse response = new ApiResponse();

        try {
            if (patient.getDob() != null) {
                patient.setAge(calculateAge(patient.getDob()));
            }

            if (imageFile != null && !imageFile.isEmpty()) {
                ApiResponse imageResponse = ImageUtil.saveImage(imageFile);
                if (imageResponse.isSuccessful()) {
                    patient.setImage((String) imageResponse.getData("image"));
                } else {
                    return response.error("Failed to save image: " + imageResponse.getMessage());
                }
            }

            patientRepository.save(patient);
            response.setData("patient", patient);
            response.setSuccessful(true);
            response.setMessage("Patient saved successfully!");


        } catch (Exception e) {
           return response.error(e);
        }

        return response;
    }

    public ApiResponse updatePatient(Patient updatedPatient, MultipartFile imageFile) {
        ApiResponse response = new ApiResponse();

        try {
            Patient existingPatient = patientRepository.findById(updatedPatient.getId())
                    .orElse(null);

            existingPatient.setFirstName(updatedPatient.getFirstName());
            existingPatient.setLastName(updatedPatient.getLastName());
            existingPatient.setGender(updatedPatient.getGender());
            existingPatient.setPermanentAddress(updatedPatient.getPermanentAddress());
            existingPatient.setPresentAddress(updatedPatient.getPresentAddress());
            existingPatient.setMobileNo(updatedPatient.getMobileNo());

            if (updatedPatient.getDob() != null) {
                existingPatient.setDob(updatedPatient.getDob());
                existingPatient.setAge(calculateAge(updatedPatient.getDob()));
            }

            if (imageFile != null && !imageFile.isEmpty()) {
                ApiResponse imageResponse = ImageUtil.saveImage(imageFile);
                if (imageResponse.isSuccessful()) {
                    existingPatient.setImage((String) imageResponse.getData("image"));
                } else {
                    return response.error("Failed to update image: " + imageResponse.getMessage());
                }
            }

            patientRepository.save(existingPatient);
            response.setData("patient", existingPatient);
            response.setSuccessful(true);
            response.setMessage("Patient updated successfully!");


        } catch (Exception e) {
            response.error(e);
        }

        return response;
    }

    public ApiResponse getPatientById(Long id) {
        ApiResponse response = new ApiResponse();

        try {
            Patient patient = patientRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));

            response.setData("patient", patient);
            response.setSuccessful(true);
            response.setMessage("Patient fetched successfully!");


        } catch (Exception e) {
            response.error(e);
        }

        return response;
    }

    public ApiResponse deletePatient(Long id) {
        ApiResponse response = new ApiResponse();

        try {
            Patient patient = patientRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));

            patientRepository.delete(patient);
            response.setSuccessful(true);
            response.setMessage("Patient deleted successfully!");

        } catch (Exception e) {
            response.error(e);
        }

        return response;
    }

    private int calculateAge(LocalDate dob) {
        return Period.between(dob, LocalDate.now()).getYears();
    }

}
