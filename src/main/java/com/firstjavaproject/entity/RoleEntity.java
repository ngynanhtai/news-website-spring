package com.firstjavaproject.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "role")
public class RoleEntity extends BaseEntity {
    @Column(name = "name")
    private String name;

    @Column(name = "code")
    private String code;

//    @ManyToMany(mappedBy = "roles")
//    private List<UserEntity> users = new ArrayList<>();

    @OneToMany(mappedBy = "role")
    List<UserEntity> user = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

//    public List<UserEntity> getUsers() {
//        return users;
//    }
//
//    public void setUsers(List<UserEntity> users) {
//        this.users = users;
//    }


    public List<UserEntity> getUser() {
        return user;
    }

    public void setUser(List<UserEntity> user) {
        this.user = user;
    }
}
