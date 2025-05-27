package com.mba.Model;
public class Movie {
    private String name;
    private String imageUrl;
    private String duration;

    public Movie(String name, String imageUrl, String duration) {
        this.name = name;
        this.imageUrl = imageUrl;
        this.duration = duration;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getDuration() {
        return duration;
    }
}
