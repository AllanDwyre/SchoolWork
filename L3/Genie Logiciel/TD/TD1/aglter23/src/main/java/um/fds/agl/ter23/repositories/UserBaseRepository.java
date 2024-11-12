package um.fds.agl.ter23.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.NoRepositoryBean;
import um.fds.agl.ter23.entities.UserTER;

@NoRepositoryBean
public interface UserBaseRepository<T extends UserTER>
        extends CrudRepository<T, Long> {

    public T findByLastName(String lastName);

}
