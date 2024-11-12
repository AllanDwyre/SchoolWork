package um.fds.agl.ter23.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import um.fds.agl.ter23.repositories.SujetRepository;

import java.util.Optional;

@Service
public class SujetService {
    @Autowired
    private SujetRepository repository;

    public Optional<Sujet> getSujet(final long id) {return repo.findById(id)};

}
