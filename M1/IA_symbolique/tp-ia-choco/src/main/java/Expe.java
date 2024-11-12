import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;
import java.util.Arrays;
import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solver;
import org.chocosolver.solver.constraints.extension.Tuples;
import org.chocosolver.solver.variables.IntVar;

public class Expe {

    // ANSI escape codes for colors
    public static final String RESET = "\u001B[0m";
    public static final String RED = "\u001B[31m";
    public static final String GREEN = "\u001B[32m";
    public static final String YELLOW = "\u001B[33m";
    public static final String BLUE = "\u001B[34m";
    public static final String MAGENTA = "\u001B[35m";
    public static final String CYAN = "\u001B[36m";
    public static final String WHITE = "\u001B[37m";

    private static Model lireReseau(BufferedReader in) throws Exception{
        Model model = new Model("Expe");

        int nbVariables = Integer.parseInt(in.readLine());				// le nombre de variables
        int tailleDom = Integer.parseInt(in.readLine());                // la valeur max des domaines
        int nbConstraints = Integer.parseInt(in.readLine());			// le nombre de contraintes binaires

        IntVar []var = model.intVarArray("x",nbVariables,0,tailleDom-1);

        for(int k=1;k<=nbConstraints;k++)
        {
            String chaine[] = in.readLine().split(";");
            IntVar portee[] = new IntVar[]{var[Integer.parseInt(chaine[0])],var[Integer.parseInt(chaine[1])]};

            int nbTuples = Integer.parseInt(in.readLine());				// le nombre de tuples
            Tuples tuples = new Tuples(new int[][]{},true);

            for(int nb=1;nb<=nbTuples;nb++) {

                chaine = in.readLine().split(";");
                int t[] = new int[]{Integer.parseInt(chaine[0]), Integer.parseInt(chaine[1])};

                tuples.add(t);
            }

            model.table(portee,tuples).post();
        }

        in.readLine();

        return model;
    }

    public static void main(String[] args) {
        File folder = new File("benchmarks");
        File[] files = folder.listFiles((dir, name) -> name.startsWith("csp") && name.endsWith(".txt"));
        Arrays.sort(files);

        System.out.println("durete, avg_time_ms, solved_percentage");

        for (File file : files) {
            try (BufferedReader readFile = new BufferedReader(new FileReader(file))) {
                // Extract durete from filename (e.g., "csp170.txt" -> 170)
                int durete = Integer.parseInt(file.getName().substring(3, file.getName().length() - 4));

                if (!readFile.ready()) {
                    System.err.println("Problème de lecture de fichier: " + file.getName());
                    continue;
                }

                int nbRes = Integer.parseInt(readFile.readLine());
                int solved = 0;
                long totalTime = 0;

                for (int nb = 1; nb <= nbRes; nb++) {
                    Model model = lireReseau(readFile);
                    Solver solver = model.getSolver();
                    solver.limitTime("10s");

                    long startTime = System.currentTimeMillis();
                    if (solver.solve()) {
                        solved++;
                        totalTime += System.currentTimeMillis() - startTime;
                    }
                }

                float solvedPercentage = (float) solved / nbRes * 100;
                float avgTime = solved > 0 ? (float) totalTime / solved : 0;

                System.out.printf("%d,%.2f,%.2f\n",
                        durete,  avgTime, solvedPercentage);

            } catch (Exception e) {
                System.err.println("Error processing file " + file.getName() + ": " + e.getMessage());
            }
        }
    }
}