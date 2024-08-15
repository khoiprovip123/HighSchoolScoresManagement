/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author La Hoang Khoi - CE171855
 */
public class Teacher1 {

    private int id;
    private String phone, email, name, gender, address, status;
    private Date birthday;
    private boolean entryPermission;

    public Teacher1() {
    }

    public Teacher1(String phone, String email, String name, String gender, Date birthday, String address, String status, boolean entryPermission) {
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.birthday = birthday;
        this.address = address;
        this.status = status;
        this.entryPermission = entryPermission;
    }

    public Teacher1(int id, String phone, String email, String name, String gender, Date birthday, String address, String status, boolean entryPermission) {
        this.id = id;
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.birthday = birthday;
        this.address = address;
        this.status = status;
        this.entryPermission = entryPermission;
    }

    public Teacher1(int id, String phone, String email, String name, String gender, Date birthday, String address) {
        this.id = id;
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.birthday = birthday;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean getEntryPermission() {
        return entryPermission;
    }

    public void setEntryPermission(boolean entryPermission) {
        this.entryPermission = entryPermission;
    }

}
