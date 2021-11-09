import java.io.*;
import org.w3c.dom.*;
import org.xml.sax.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

import java.io.File;
import java.util.Date;
import java.util.Map;

import javax.sound.midi.SysexMessage;
import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.time.Instant;
import java.nio.file.FileSystems;
import java.nio.file.Files;


public class MyTransformator {

    static String outFilename, xslFilename;

    static final String inFilename = "../sample_garrot_dijoux_BigVir2084.xml";

    static int nbTransfo = 1;

    static final String transfoDirPath = "transfos/";

    /**
     * Utilisé pour vérifier l'extension du fichiers xsl passés en paramètres.
     */
    static final PathMatcher matcher = FileSystems.getDefault().getPathMatcher("glob:**.xsl");
    

    /**
     * code inspiré du site StackOverflow https://stackoverflow.com/questions/5977846/how-to-apply-xsl-to-xml-in-java
     * 
     * L'appel doit prendre en paramètre le fichier CHEMIN_VERS_FICHIER_XSL.xsl.
     */
 
    public static void main(String[]args) {

        processInputs(args);

        try {
            TransformerFactory factory = TransformerFactory.newInstance();

            Templates template = factory.newTemplates(new StreamSource(
                new FileInputStream(xslFilename)));
            
            Transformer xformer = template.newTransformer();

            // on créé le répertoire des transformations
            Files.createDirectories(Paths.get(transfoDirPath));

            outFilename = transfoDirPath + "transfo_" + Instant.now().getNano()/1000 + ".xml";

            Source source = new StreamSource(new FileInputStream(inFilename));
            Result result = new StreamResult(new FileOutputStream(outFilename));

            xformer.transform(source, result);
        } catch (Exception e){
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static void processInputs(String[] args) {
        if (args.length!=1 || !matcher.matches(FileSystems.getDefault().getPath(args[0]))) {
            System.err.println("Donnez en paramètre le fichier xsl qui servira a la transformation.");
            System.exit(1);
        }
        xslFilename = args[0];
    }
}