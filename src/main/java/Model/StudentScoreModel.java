/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


/**
 *
 * @author admin
 */
public class StudentScoreModel {

    private int id;
    private int subject_id;
    private float scoreMouth;
    private float scoreShortExam;    
    private float scoreMidSemester;
    private float scoreSemester;

    public StudentScoreModel() {
    }

    public StudentScoreModel(int id, int subject_id, float scoreMouth, float scoreShortExam, float scoreMidSemester, float scoreSemester) {
        this.id = id;
        this.subject_id = subject_id;
        this.scoreMouth = scoreMouth;
        this.scoreShortExam = scoreShortExam;
        this.scoreMidSemester = scoreMidSemester;
        this.scoreSemester = scoreSemester;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSubject_id() {
        return subject_id;
    }

    public void setSubject_id(int subject_id) {
        this.subject_id = subject_id;
    }

    public float getScoreMouth() {
        return scoreMouth;
    }

    public void setScoreMouth(float scoreMouth) {
        this.scoreMouth = scoreMouth;
    }

    public float getScoreShortExam() {
        return scoreShortExam;
    }

    public void setScoreShortExam(float scoreShortExam) {
        this.scoreShortExam = scoreShortExam;
    }

    public float getScoreMidSemester() {
        return scoreMidSemester;
    }

    public void setScoreMidSemester(float scoreMidSemester) {
        this.scoreMidSemester = scoreMidSemester;
    }

    public float getScoreSemester() {
        return scoreSemester;
    }

    public void setScoreSemester(float scoreSemester) {
        this.scoreSemester = scoreSemester;
    }

    public float getGpa(){
        return (float) (Math.round(((scoreMouth + scoreShortExam + scoreMidSemester*2 + scoreSemester*3)/7) *10.0)/10.0);
    }
    
    
}
