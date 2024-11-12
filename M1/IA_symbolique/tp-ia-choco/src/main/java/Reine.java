import org.chocosolver.solver.Model;
import org.chocosolver.solver.variables.IntVar;
import org.chocosolver.solver.variables.Variable;

import java.util.Arrays;

public class Reine {

    private static void Display(int[] queens){
        StringBuilder builder = new StringBuilder();
        int nQueens = queens.length;

        for (int i = 0; i < nQueens; i++) {
            builder.append(". ".repeat(queens[i] - 1));
            builder.append("X ");
            builder.append(". ".repeat(nQueens - queens[i])).append("\n");
        }
        System.out.println(builder.toString());
    }
    public static Model CreateModel(int queenNumber){
        Model model = new Model("N-Queens");

        IntVar[] queens = model.intVarArray("queen", queenNumber,1, queenNumber );

        // Constrains generation :

        // 1 - Each queen need to be on different lines : by default it's already valid;

        // 2 - All the queens need to be on a different column :
        model.allDifferent(queens).post();

        // 3 - All the queens need to be on a different diagonals :

        // for each queen i, we're looking if foreach queen j there aren't in the same diag.
        for (int i = 0; i < queenNumber - 1; i++){  
            for (int j = i + 1; j < queenNumber; j++){
                model.distance(queens[i], queens[j], "!=", j - i).post();
            }
        }
        return model;
    }
    public static void main(String[] args)
    {
        // Number of keens
        if (args.length != 1) {
            System.out.println("Usage: java Reine queenNumber");
            System.exit(1);
        }

        int queenNumber = Integer.parseInt(args[0]);

        Model model = CreateModel(queenNumber);


        // display solution :

        while(model.getSolver().solve()) {
            System.out.println("Sol "+ model.getSolver().getSolutionCount());
            int[] values = Arrays.stream(model.getVars())
                    .map(v -> v.asIntVar().getValue())
                    .mapToInt(Integer::intValue)
                    .toArray();

            Display(values);
        }

        System.out.println("Number of solution : "+ model.getSolver().getSolutionCount());
    }
}
