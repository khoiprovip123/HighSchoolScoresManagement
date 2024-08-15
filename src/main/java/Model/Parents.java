/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Parents {
    private int id;
    private String phone_number;
    private String password;
    private String name;
    private String role;
    private String job;
    private int student_id;

    /**
     * @return the id
     */
    
    public Parents() {
    }

    public Parents(int id, String phone_number, String password, String name, String role, String job, int student_id) {
        this.id = id;
        this.phone_number = phone_number;
        this.password = password;
        this.name = name;
        this.role = role;
        this.job = job;
        this.student_id = student_id;
    }
    
    public Parents(int id, String phone_number, String name, String role, String job, int student_id) {
        this.id = id;
        this.phone_number = phone_number;
        this.name = name;
        this.role = role;
        this.job = job;
        this.student_id = student_id;
    }
    
    public Parents(String phone_number, String name, String role, String job, int student_id) {
        this.phone_number = phone_number;
        this.name = name;
        this.role = role;
        this.job = job;
        this.student_id = student_id;
    }
    

    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the phone_number
     */
    public String getPhone_number() {
        return phone_number;
    }

    /**
     * @param phone_number the phone_number to set
     */
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @param role the role to set
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * @return the job
     */
    public String getJob() {
        return job;
    }

    /**
     * @param job the job to set
     */
    public void setJob(String job) {
        this.job = job;
    }

    /**
     * @return the student_id
     */
    public int getStudent_id() {
        return student_id;
    }

    /**
     * @param student_id the student_id to set
     */
    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }
}
