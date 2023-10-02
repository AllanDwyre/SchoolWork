package um.fds.agl.ter23;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import um.fds.agl.ter23.entities.*;
import um.fds.agl.ter23.repositories.*;

@Component
public class DatabaseLoader implements CommandLineRunner {
    private final TeacherRepository teachers;
    private final TERManagerRepository managers;

    private final StudentRepository students;


    @Autowired
    public DatabaseLoader(TeacherRepository teachers, TERManagerRepository managers, StudentRepository students) {
        this.teachers = teachers;
        this.managers=managers;
        this.students=students;
    }

    @Override
    public void run(String... strings) throws Exception {
        TERManager terM1Manager=this.managers.save(new TERManager("Le","Chef", "mdp", "ROLE_MANAGER"));
       SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken("Chef", "bigre",
                        AuthorityUtils.createAuthorityList("ROLE_MANAGER"))); // the actual password is not needed here
        this.teachers.save(new Teacher("Ada", "Lovelace", "lovelace",terM1Manager, "ROLE_TEACHER"));
        this.teachers.save(new Teacher("Alan", "Turing", "turing",terM1Manager, "ROLE_TEACHER"));
        this.teachers.save(new Teacher("Leslie", "Lamport", "lamport",terM1Manager, "ROLE_TEACHER"));
        this.students.save(new Student("Gustave", "Flaubert"));
        this.students.save(new Student("Frédéric", "Chopin"));

        SecurityContextHolder.clearContext();

    }
}
