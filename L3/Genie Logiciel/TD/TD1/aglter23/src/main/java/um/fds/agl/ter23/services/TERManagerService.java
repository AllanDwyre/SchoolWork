package um.fds.agl.ter23.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import um.fds.agl.ter23.entities.TERManager;
import um.fds.agl.ter23.repositories.TERManagerRepository;


@Service
public class TERManagerService {
    @Autowired
    private TERManagerRepository terManagerRepository;

    public TERManager getTERManager() {
        return terManagerRepository.findAll().iterator().next();
    }

}
