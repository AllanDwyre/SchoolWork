package um.fds.agl.ter23.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.util.Objects;

@Entity
public class Sujet
{
    private @Id @GeneratedValue Long id;
    private String name;
    @ManyToOne // N sujet : 1 teacher
    private Teacher teacher;
    public Sujet(String name, Teacher teacher){
        this.name = name;
        this.teacher = teacher;
    }
    public Sujet(long id, String name, Teacher teacher){
        this.id = id;
        this.name = name;
        this.teacher = teacher;
    }

    public Sujet(){}

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    @Override
    public String toString() {
        return "Sujet{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", teacher=" + teacher +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Sujet sujet = (Sujet) o;
        return Objects.equals(id, sujet.id) && Objects.equals(name, sujet.name) && Objects.equals(teacher, sujet.teacher);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, teacher);
    }
}




