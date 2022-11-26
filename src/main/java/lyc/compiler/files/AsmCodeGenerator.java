package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;

public class AsmCodeGenerator implements FileGenerator {

    private String asm = "TODO";

    public void setASM(String tiraToken){
        this.asm = tiraToken;
    }
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write(this.asm);
    }
}
