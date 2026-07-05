import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Partner A — word counts + sorted unique words.
 * See ../../README.md
 */
public class WordFrequencyApp {

    private static final Logger LOGGER = LoggerFactory.getLogger("pair.a.words");

    static final String SAMPLE = """
            Java collections maps sets queues lambdas
            Java maps and sets and more Java
            """;

    public static void main(String[] args) {
        LOGGER.info("WordFrequencyApp started");

        String input = args.length > 0 ? String.join(" ", args) : SAMPLE;

        if (input.isBlank()) {
            LOGGER.warn("Input text is empty; no tokens to process");
            return;
        }

        Map<String, Integer> counts = new HashMap<>();
        // TODO: tokenize SAMPLE, populate counts (lower-case tokens)
        String[] words = input.toLowerCase().split("[^A-Za-z]+");
        if (words.length == 0) {
            LOGGER.warn("Tokenization produced no tokens");
            return;
        }

        TreeSet<String> vocabulary = new TreeSet<>();
        // TODO: add all distinct words to vocabulary
        // for(String word: words){
        //     vocabulary.add(word);
        //     counts.put(word, counts.getOrDefault(word, 0) + 1);
            
        // }
        Arrays.stream(words).forEach((word -> {
            LOGGER.debug("Processing token: {}", word);
            vocabulary.add(word);
            counts.put(word, counts.getOrDefault(word, 0) + 1);
        }));
        
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(counts.entrySet());
        entries.sort((a, b) -> b.getValue() - a.getValue());
        
        LOGGER.info("Computed {} unique words and {} total entries", vocabulary.size(), entries.size());

        System.out.println("print counts and top N");
        for (Map.Entry<String, Integer> entry : entries) {
            System.out.println(String.format("%s : %d", entry.getKey(), entry.getValue()));
        }


        
        System.out.println("\nprint first of vocabulary: ");
        System.out.println(vocabulary.first());
        System.out.println("print last of vocabulary: ");
        System.out.println(vocabulary.last());

        LOGGER.info("WordFrequencyApp finished");
    }
}
