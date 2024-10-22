import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
public class MyRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @Test
@Sql(statements = {
        "INSERT INTO public.role(id, name) VALUES (1, 'ROLE_LOGIN');",
        "INSERT INTO public.pessoa(id, user_name, password, email, full_name, nome, mobile, user_id, cpf, tipo_pessoa, data_nascimento, gerente, funcionario, matricula) " +
        "VALUES (1, 'tal', '$2a$10$XBQ9jnH3tqdUSqeTRfvrQOFyZsqxPym29nGKrlyhYUUYU7jg9dvMC', 'tlopes@gmail.com', 'Tiago Lopes', 'Tiago Lopes', '1187635463', 1, '32534563546', 'users', '1979-10-03', true, false, '28383284'), " +
        "(2, 'Tiago Santos', '$2a$10$XBQ9jnH3tqdUSqeTRfvrQOFyZsqxPym29nGKrlyhYUUYU7jg9dvMC', 'tlopes@gmail.com', 'Tiago Santos', 'Tiago Santos', '1187635463', 1, '12534563534', 'users', '1979-10-03', false, true, '28383284');"
    })
    public void testInsertData() {

        Users user = userRepository.findByUsername("tal");
        assertThat(user).isNotNull();
        assertThat(user.getFullName()).isEqualTo("Tiago Lopes");
        assertThat(user.getEmail()).isEqualTo("tlopes@gmail.com");


        Users user2 = userRepository.findByUsername("Tiago Santos");
        assertThat(user2).isNotNull();
        assertThat(user2.getFullName()).isEqualTo("Tiago Santos");
}

    public void testUpdateUser() {

        Users user = userRepository.findByUsername("tal");
        user.setFullName("Tiago Lopes Updated");
        user.setEmail("updatedemail@gmail.com");
        userRepository.save(user);


        Users updatedUser = userRepository.findByUsername("tal");
        assertThat(updatedUser.getFullName()).isEqualTo("Tiago Lopes Updated");
        assertThat(updatedUser.getEmail()).isEqualTo("updatedemail@gmail.com");
}

    public void testDeleteUser() {

        Users user = userRepository.findByUsername("Tiago Santos");
        assertThat(user).isNotNull();


        userRepository.delete(user);


        Users deletedUser = userRepository.findByUsername("Tiago Santos");
        assertThat(deletedUser).isNull();
}
}

