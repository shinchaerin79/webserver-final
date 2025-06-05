package dao;
import java.util.ArrayList;

import dto.Movie;

public class MovieRepository {
	
	private ArrayList<Movie> listOfMovies=new  ArrayList<Movie>();

	public MovieRepository() {
		Movie movie1=new Movie("movie1","마블","20230505","SF");
		movie1.setDescription("테스트테스트테스트");
		Movie movie2=new Movie("movie2","어벤져스","20231010","SF");
		movie2.setDescription("테스트테스트테스트");
		
		listOfMovies.add(movie1);
		listOfMovies.add(movie2);
	}
	
	public ArrayList<Movie> getAllMovies(){
		return listOfMovies;
	}

}
