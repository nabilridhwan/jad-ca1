/*
 * 	Name: Xavier Tay Cher Yew
	Admin No: P2129512
	Class: DIT/FT/2A/01
	Group Number: Group 4 - TAY CHER YEW XAVIER, NABIL RIDHWANSHAH BIN ROSLI  
 * */

package servlets.admin;

import models.TourModel;
import utils.DatabaseConnection;
import utils.Util;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import cloudinary.ImageUpload;
import cloudinary.ImageUploadType;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/editTourImage")
public class EditTourImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditTourImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		DatabaseConnection connection = new DatabaseConnection();
		// Get the current session
		HttpSession session = request.getSession(false);

		Util.forceAdmin(session, response);

		ImageUpload imageUpload = new ImageUpload();

		try {
			String tourIdStr = null;
			String tourImageIdStr = null;
			String image_url = null;
			String alt = null;

			System.out.println("tourIdStr: " + tourIdStr);
			System.out.println("tourImageIdStr: " + tourImageIdStr);

			File file;
			int maxFileSize = 5000 * 1024;
			int maxMemSize = 5000 * 1024;
			ServletContext context = request.getServletContext();
			String filePath = context.getInitParameter("file-upload");

			// Verify the content type
			String contentType = request.getContentType();

			if ((contentType.indexOf("multipart/form-data") >= 0)) {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// maximum size that will be stored in memory
				factory.setSizeThreshold(maxMemSize);

				// Location to save data that is larger than maxMemSize.
				factory.setRepository(new File("c:\\temp"));

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// maximum file size to be uploaded.
				upload.setSizeMax(maxFileSize);

				try {
					// Parse the request to get file items.
					List fileItems = upload.parseRequest(new ServletRequestContext(request));

					// Process the uploaded file items
					Iterator i = fileItems.iterator();

					while (i.hasNext()) {
						FileItem fi = (FileItem) i.next();

						// Check if it is a file field
						if (!fi.isFormField()) {
							// Get the uploaded file parameters
							String fieldName = fi.getFieldName();
							String fileName = fi.getName();
							boolean isInMemory = fi.isInMemory();
							long sizeInBytes = fi.getSize();

							// Write the file
							if (fileName.lastIndexOf("\\") >= 0) {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
							} else {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
							}
							fi.write(file);

							// Upload image and retrieve the URL
							image_url = imageUpload.uploadImage(file, ImageUploadType.CATEGORY);
						} else {
							// Item is a normal input field
							String fieldName = fi.getFieldName();
							String fieldValue = fi.getString();
							switch (fieldName) {
							case "id": {
								tourIdStr = fieldValue;
								break;
							}
							case "imageId": {
								tourImageIdStr = fieldValue;
								break;
							}
							case "alt": {
								alt = fieldValue;
								break;
							}
							default:
								System.out.println("Unknown field in multipart/form-data");
								break;
							}
						}
					}
				} catch (Exception ex) {
					System.out.println(ex);
				}
			}

			int tourImageId = Integer.parseInt(tourImageIdStr);
			int tourID = Integer.parseInt(tourIdStr);

			if (tourImageId == 0) {
				int affectedRows = TourModel.insertNewTourImage(tourID, image_url, alt).update(connection);

				connection.close();
				if (affectedRows > 0) {
//			TODO: Change page redirection
					response.sendRedirect(
							request.getContextPath() + "/views/admin/edit_tourImages.jsp?tourId=" + tourID);
					return;
				}
				response.sendRedirect(request.getContextPath()
						+ "/views/admin/edit_tour.jsp?message=Error adding new tour date&tourId=" + tourID);

				return;
			}

			int affectedRows = TourModel.updateTourImage(tourImageId, image_url, alt).update(connection);
			if (affectedRows > 0) {
//			TODO: Change page redirection
				response.sendRedirect(request.getContextPath() + "/views/admin/edit_tourImages.jsp?tourId=" + tourID);
				return;
			}
			response.sendRedirect(request.getContextPath()
					+ "/views/admin/edit_tour.jsp?message=Tour with that name already exists!&tourId=" + tourID);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/views/admin/all_tours.jsp?message=Error");
		} finally {
			connection.close();
		}
	}

}
