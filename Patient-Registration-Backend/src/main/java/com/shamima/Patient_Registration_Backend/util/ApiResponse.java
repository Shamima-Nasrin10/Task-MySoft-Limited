package com.shamima.Patient_Registration_Backend.util;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor

public class ApiResponse {
    private String message;
    private Map<String, Object> data = new HashMap<>();
    private Map<String, String> errors = new HashMap<>();
    private boolean successful = false;

    public ApiResponse() {
        this.successful = successful;
    }

    public ApiResponse(boolean successful, String message) {
        this.successful = successful;
        this.message = message;
    }

    public Object getData(String key) {
        return this.data.get(key);
    }

    public void setData(String key, Object value) {
        this.data.put(key, value);
    }

    public ApiResponse success(String message) {
        this.successful = true;
        this.message = message;
        return this;
    }

    public ApiResponse error(String message) {
        this.successful = false;
        this.message = message;
        return this;
    }

    public ApiResponse error(Exception e) {
        this.successful = false;
        this.message = e.getMessage();
        return this;
    }
}
