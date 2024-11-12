package um.fds.agl.ter23.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.security.access.prepost.PreAuthorize;
import um.fds.agl.ter23.entities.Sujet;


public interface SujetRepository  extends CrudRepository<Sujet, Long> {

    @Override @PreAuthorize("hasRole('ROLE_MANAGER')")
    <S extends Sujet> S save(S entity);
}
