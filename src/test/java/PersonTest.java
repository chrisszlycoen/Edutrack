import com.code888.edutrack.model.Gender;
import com.code888.edutrack.model.Person;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import static org.junit.jupiter.api.Assertions.*;

public class PersonTest {

    @Test
    public void getGender() {

        Person p = new Person(1, "Mike", "Mugisha", Gender.MALE, 18);

        assertTrue(p.getGender() == Gender.MALE);
        assertFalse(p.getGender() == Gender.FEMALE);
    }

    @Test
    public void getAge() {
        String dob = "10-10-2025";
        LocalDate dob1 = LocalDate.parse(dob, DateTimeFormatter.ofPattern("dd-MM-yyyy"));
        Person p1 = new Person(1, "Mike", "Mugisha", Gender.MALE, dob1);
        assertTrue(p1.getAge() == 0);
    }
}

