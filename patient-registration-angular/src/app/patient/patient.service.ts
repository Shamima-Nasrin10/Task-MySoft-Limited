import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {ApiResponse} from "../util/apiresponse.model";
import {Patient} from "./patient.model";

@Injectable({
  providedIn: 'root'
})
export class PatientService {
  private apiUrl = 'http://localhost:8080/api/patients';
  constructor(
    private http: HttpClient,
  ) { }

  getAllPatients(): Observable<ApiResponse> {
    return this.http.get<ApiResponse>(`${this.apiUrl}/list`);
  }

  savePatient(patient: Patient, imageFile?: File): Observable<ApiResponse> {
    const formData = new FormData();
    formData.append('patient', new Blob([JSON.stringify(patient)], {type: 'application/json'}));

    if (imageFile) {
      formData.append('imageFile', imageFile);
    }
    return this.http.post<ApiResponse>(`${this.apiUrl}/save`, formData);
  }

  updatePatient(patient: Patient, imageFile?: File): Observable<ApiResponse> {
    const formData = new FormData();
    formData.append('updatedPatient', new Blob([JSON.stringify(patient)], {type: 'application/json'}));

    if (imageFile) {
      formData.append('imageFile', imageFile);
    }
    return this.http.put<ApiResponse>(`${this.apiUrl}/update`, formData);
  }

  deletePatientsById(id: number): Observable<ApiResponse> {
    return this.http.delete<ApiResponse>(`${this.apiUrl}/delete/${id}`);
  }

  findPatientsById(id: number): Observable<ApiResponse> {
    return this.http.get<ApiResponse>(`${this.apiUrl}/${id}`);
  }

}
