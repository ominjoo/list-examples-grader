import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  public void testFilter() {
    List<String> list1 = Arrays.asList("moon", "star", "sun");
    List<String> list2 = Arrays.asList("start", "moon", "moon");
    
    List<String> result1 = ListExamples.filter(list1, new IsMoon());
    List<String> result2 = ListExamples.filter(list2, new IsMoon());

    List<String> expected1 = Arrays.asList("moon");
    List<String> expected2 = Arrays.asList("moon", "moon");

    assertEquals(expected1, result1);
    assertEquals(expected2, result2);
  }
}
