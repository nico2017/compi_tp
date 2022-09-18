package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;

public class SymbolTableGenerator implements FileGenerator{
    private String tiraTokens = "TODO";

    public void setTableSymbol(String tiraToken){
        this.tiraTokens = tiraToken;
    }
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write(tiraTokens);
    }
}
