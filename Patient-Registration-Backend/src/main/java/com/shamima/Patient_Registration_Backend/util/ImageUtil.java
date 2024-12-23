package com.shamima.Patient_Registration_Backend.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Component
public class ImageUtil {

    private static String imageDir;
    @Value("${image.dir}")
    public void setImageDir(String imageDir) {
        ImageUtil.imageDir = imageDir;
    }

    public static ApiResponse saveImage(
            MultipartFile image) {
        ApiResponse response = new ApiResponse();
        try {
            Path directoryPath = Paths.get(imageDir);
            if (!Files.exists(directoryPath)) {
                Files.createDirectories(directoryPath);
            }

            String originalFilename = image.getOriginalFilename();
            String fileExtension = originalFilename != null ?
                    originalFilename.substring(originalFilename.lastIndexOf('.')) : "";
            String randomFileName = UUID.randomUUID() + fileExtension;
            Path filePath = directoryPath.resolve(randomFileName);

            Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            response.setSuccessful(true);
            response.setData("image", randomFileName);
        } catch (Exception e) {
            response.setMessage(e.getMessage());
        }
        return response;
    }

}
