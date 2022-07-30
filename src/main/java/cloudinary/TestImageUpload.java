package cloudinary;

import java.io.File;
import java.io.IOException;

public class TestImageUpload {
	
	public static ImageUpload iu = new ImageUpload();

	public static void main(String[] args) {
		File fileToUpload = new File("C:\\Users\\nabri\\Downloads\\WhatsApp Image 2022-07-19 at 11.30.34 PM.jpeg");
		
		try {
			String uploadedURL = iu.uploadImage(fileToUpload, ImageUploadType.PROFILE_PICTURE);
			System.out.println(uploadedURL);
		}catch(IOException ioe) {
			System.out.println("Image can't be used or found");
		}

	}

}
