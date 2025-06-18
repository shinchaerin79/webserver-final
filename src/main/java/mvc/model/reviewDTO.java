package mvc.model;

import java.sql.Timestamp;

public class reviewDTO {
    private Long review_id;
    private String username;
    private int movie_id;
    private Timestamp writingTime;
    private int scope;
    private String contents;

    public reviewDTO() {}

    // Getters & Setters
    public Long getReview_id() {
        return review_id;
    }

    public void setReview_id(Long review_id) {
        this.review_id = review_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(int movie_id) {
        this.movie_id = movie_id;
    }

    public Timestamp getWritingTime() {
        return writingTime;
    }

    public void setWritingTime(Timestamp writingTime) {
        this.writingTime = writingTime;
    }

    public int getScope() {
        return scope;
    }

    public void setScope(int scope) {
        this.scope = scope;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }
}
