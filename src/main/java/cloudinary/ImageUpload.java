package cloudinary;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;



public class ImageUpload {
	
	public static Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
			"cloud_name", "dqxawxewb",
			"api_key", "534278375837782",
			"api_secret", "vpVQp-rWDoF5IC68oJCzAS8fDR8",
			"secure", true));
	
	
	
	public String uploadImage(File image, String imageUploadType) throws IOException {
		Map params = ObjectUtils.asMap(
			    "public_id", imageUploadType + "/" + BCrypt.gensalt(), 
			    "overwrite", true,
			    "resource_type", "image"         
			);

			Map uploadResult = cloudinary.uploader().upload(image, params);
			System.out.println(uploadResult.toString());
			return (String) uploadResult.get("secure_url");
	}
}
