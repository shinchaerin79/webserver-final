package dto;

import java.io.Serializable;

public class Movie implements Serializable {
	private static final long serialVersionUID = -4274700572038677000L;
	private String movieId;
	private String name;
	private String description;
	private String releaseDate;
	private String genre;
	
	public Movie() {
		super();
	}
	
	public Movie(String movieId, String name, String releaseDate, String genre) {
		this.movieId = movieId;
		this.name = name;
		this.releaseDate = releaseDate;
		this.genre = genre;
	}
	
	public String getMovieId() {
		return movieId;
	}
	public void setMovieId(String movieId) {
		this.movieId = movieId;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
