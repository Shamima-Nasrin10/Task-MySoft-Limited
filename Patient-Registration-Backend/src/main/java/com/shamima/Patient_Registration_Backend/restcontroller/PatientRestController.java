package com.shamima.Patient_Registration_Backend.restcontroller;

import com.shamima.Patient_Registration_Backend.entity.Patient;
import com.shamima.Patient_Registration_Backend.service.PatientService;
import com.shamima.Patient_Registration_Backend.util.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/patients")
@CrossOrigin(origins = "*")

public class PatientRestController {

    @Autowired
    private PatientService patientService;

    @GetMapping("/list")
    public ApiResponse getAllPatients() {
        return patientService.getAllPatients();
    }

    @GetMapping("/{id}")
    public ApiResponse getPatientById(@PathVariable Long id) {
        return patientService.getPatientById(id);
    }

    @PostMapping(value = "/save", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ApiResponse savePatient(
            @RequestPart Patient patient,
            @RequestPart(required = false) MultipartFile imageFile) {
        return patientService.savePatient(patient, imageFile);
    }

    @PutMapping(value = "/update" , consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ApiResponse updatePatient(
            @RequestPart Patient updatedPatient,
            @RequestPart(required = false) MultipartFile imageFile) {
        return patientService.updatePatient(updatedPatient, imageFile);
    }


    @DeleteMapping("/delete/{id}")
    public ApiResponse deletePatient(@PathVariable Long id) {
        return patientService.deletePatient(id);
    }

}
