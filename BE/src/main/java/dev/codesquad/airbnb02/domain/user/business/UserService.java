package dev.codesquad.airbnb02.domain.user.business;

import dev.codesquad.airbnb02.domain.favorite.Favorite;
import dev.codesquad.airbnb02.domain.user.data.UserRepository;
import dev.codesquad.airbnb02.domain.user.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

  private final UserRepository userRepository;

  public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @Transactional
  public Favorite addFavorite(Long roomId, Long userId) {
    User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
    Favorite favorite = user.addFavorite(roomId);
    userRepository.save(user);
    return favorite;
  }

  @Transactional
  public Favorite deleteFavorite(Long roomId, Long userId) {
    User user = userRepository.findById(userId).orElseThrow(RuntimeException::new);
    Favorite favorite = user.deleteFavorite(roomId);
    userRepository.save(user);
    return favorite;
  }

}
