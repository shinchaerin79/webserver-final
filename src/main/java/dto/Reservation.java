package dto;

public class Reservation {
    private int id;
    private String movieTitle;
    private String screen;
    private String time;
    private String seat;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }

    public String getScreen() { return screen; }
    public void setScreen(String screen) { this.screen = screen; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getSeat() { return seat; }
    public void setSeat(String seat) { this.seat = seat; }
}