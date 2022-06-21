package servlets.admin;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

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

import models.CategoryModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class AddNewCategory
 */
@WebServlet("/addNewCategory")
public class AddNewCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DatabaseConnection connection = new DatabaseConnection();
		// Get the current session
		HttpSession session = request.getSession(false);
		
		if(!Util.isUserLoggedIn(session)) {
//			TODO: Send error back
			response.sendRedirect(request.getContextPath() + "/views/index.jsp");
			return;
		}
		
		Integer userID = (Integer) session.getAttribute("userID");
		
		if(!Util.isUserAdmin(userID)) {
//			Redirect to the home page
			response.sendRedirect(request.getContextPath() + "/views/index.jsp");
			return;
		}
		
		String category_img = "";
		String category_name = "";
		String category_desc = "";
		
		File file ;
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
		      upload.setSizeMax( maxFileSize );
		      
		      try { 
		         // Parse the request to get file items.
		         List fileItems = upload.parseRequest(new ServletRequestContext(request));
		
		         // Process the uploaded file items
		         Iterator i = fileItems.iterator();
		         while ( i.hasNext () ) {
		            FileItem fi = (FileItem)i.next();
		            
//		            Check if the field is a form
		            if ( !fi.isFormField () ) {
		               // Get the uploaded file parameters
		               String fieldName = fi.getFieldName();
		               String fileName = fi.getName();
		               boolean isInMemory = fi.isInMemory();
		               long sizeInBytes = fi.getSize();
		            
		               // Write the file
		               if( fileName.lastIndexOf("\\") >= 0 ) {
		                  file = new File( filePath + 
		                  fileName.substring( fileName.lastIndexOf("\\"))) ;
		               } else {
		                  file = new File( filePath + 
		                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
		               }
		               fi.write( file ) ;
		               
		               
		               // Set the category_img to be filePath and fileName
		               category_img = "/CA1-Preparation/uploaded_images/" + fileName;

		            }else {
		            	String name = fi.getFieldName();
		            	String value = fi.getString();
		            	
		            	switch (name) {
		            		case "category_name":
		            			category_name = value;
		            			break;
		            		case "category_desc":
		            			category_desc = value;
		            			break;
		            	}
		            }
		         }
		      } catch(Exception ex) {
		    	  response.sendRedirect(request.getContextPath() + "/views/admin/add_category.jsp?message=The file exceeds the limit!");
		    	  connection.close();
		    	  return;
		      }
		   }
		   
		   System.out.println(category_img);
		   System.out.println(category_name);
		   System.out.println(category_desc);
		   
		
		int affectedRows = CategoryModel.insertNewCategory(category_img, category_name, category_desc).update(connection);
		
		System.out.println(affectedRows);
		
		if(affectedRows > 0) {
			
//			TODO: Change page redirection
			response.sendRedirect(request.getContextPath() + "/views/index.jsp");
			return;
		}else if(affectedRows == -1) {
			response.sendRedirect(request.getContextPath() + "/views/admin/add_category.jsp?message=Category with that name already exists!");
			return;
		}
		
		// doGet(request, response);
	}

}
