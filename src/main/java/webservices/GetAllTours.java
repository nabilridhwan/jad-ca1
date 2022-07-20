package webservices;

import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dataStructures.Tour;
import models.TourModel;
import utils.DatabaseConnection;

@Path("/tours")
public class GetAllTours {
	
	@GET
	@Path("/all")
	@Produces("application/json")
	public Response getAllTours() {
		// Get the data from the database
		
		DatabaseConnection connection = new DatabaseConnection();
		
		Tour[] tours = TourModel.getAllTours().query(connection);
		return Response.status(Response.Status.OK).entity(tours).build();
		
	}

}
